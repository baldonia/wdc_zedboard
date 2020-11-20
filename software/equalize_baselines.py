###################################################
# Aaron Fienberg
#
# equalize baselines between channel 0 and channel 1
# sets DAC for channel 0 to a specified value
# and then adjusts the DAC value for channel 1

import numpy as np
import time

from wdc_zedboard import wdcZedboard, read_dev_path

import plot_sw_trig

test_conf = 5000
ch0_dac_val = 1000
step_size = 100


def get_wfms(zed):
    zed.fpga_write("sw_trig", 0x3)

    wfms = plot_sw_trig.order_wfms((zed.read_waveform(), zed.read_waveform()))

    return wfms


def get_baselines(wfms):
    return [np.mean(wfm["samples"]) for wfm in wfms]


def main():
    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    io_rst_state = 0
    for chan in 0, 1:
        io_rst_state |= zed.fpga_read(f"dig_io_reset[{chan}]")
    if io_rst_state == 1:
        raise RuntimeError(
            "ADC IO is in reset! "
            "Either manually enable both ADC IO modules "
            "or run the delay_scan script."
        )

    print("Resetting waveform buffers and adc...")
    zed.fpga_write("buf_rst", 0xFFFF)
    zed.fpga_write("buf_rst", 0x0)
    zed.init_adcs()
    time.sleep(0.1)

    print("Configuring test conf")
    for chan in 0, 1:
        zed.fpga_write(f"test_conf[{chan}]", test_conf)

    zed.fpga_write("buf_reader_dpram_mode", 1)

    print("setting DAC vals")
    zed.set_dac(0, "b", ch0_dac_val)
    zed.set_dac(1, "b", ch0_dac_val)

    time.sleep(0.1)
    print("Enabling reader")
    zed.fpga_write("buf_reader_enable", 0x1)
    wfms = get_wfms(zed)
    init_baselines = get_baselines(wfms)
    print(f"Initial baselines: {init_baselines}")

    zed.set_dac(1, "b", ch0_dac_val + step_size)
    time.sleep(0.1)
    wfms = get_wfms(zed)
    max_dac_bline = get_baselines(wfms)[1]
    print(f"Baseline for ch1 at adjusted DAC setting: {max_dac_bline}")
    slope = (max_dac_bline - init_baselines[1]) / step_size
    target_setting = ch0_dac_val + (init_baselines[0] - init_baselines[1]) / slope
    print(f"target setting: {target_setting}")
    int_setting = int(round(target_setting))

    if 0 <= int_setting <= 0x3FFF:
        print(f"Setting ch1 DAC to {int_setting}")
        zed.set_dac(1, "b", int_setting)
        time.sleep(0.1)
        eq_baselines = get_baselines(get_wfms(zed))
        print(f"equalized baselines: {eq_baselines}")
    else:
        print("Target setting is invalid; failed to equalize baselines")

    print("disabling reader...")
    zed.fpga_write("buf_reader_enable", 0x0)


if __name__ == "__main__":
    main()
