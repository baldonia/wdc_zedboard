###################################################
# Aaron Fienberg
#
# Test the trigger link functionality

from wdc_zedboard import wdcZedboard, read_dev_path
import sys
import numpy as np
import time

pre_conf = 10
post_conf = 10


def check_ltcs(wfms):
    assert not None in wfms and wfms[0]["ltc"] == wfms[1]["ltc"]


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

    for chan in 0, 1:
        print(f"Setting ramp pattern for chan {chan}")
        zed.set_adc_test_pattern(chan, "ramp")

        print(f"Configuring pre conf for chan {chan}")
        zed.fpga_write(f"pre_conf[{chan}]", pre_conf)
        print(f"Configuring post conf for chan {chan}")
        zed.fpga_write(f"post_conf[{chan}]", post_conf)
        print(f"Setting trig mode for chan {chan}")
        zed.fpga_write(f"trig_mode[{chan}]", 0x1)

    zed.fpga_write("buf_reader_dpram_mode", 1)

    print("Enabling reader")
    zed.fpga_write("buf_reader_enable", 0x1)

    # try triggering on chan 0 and linking in chan 1
    print("Enabling trigger link for channel 1")
    zed.fpga_write("trig_link_en", 0x2)
    print("Arming triggers")
    zed.fpga_write("trig_arm", 0x3)
    print("Armed readback:")
    print(zed.fpga_read("trig_armed"))

    print("Enabling triggers for channel 1")
    zed.fpga_write("trig_settings[0]", 0x9)
    print("Armed readback:")
    print(zed.fpga_read("trig_armed"))

    wfms = (zed.read_waveform(), zed.read_waveform())
    check_ltcs(wfms)

    print("Waveforms:")

    ramp_starts = [None, None]

    for wfm in wfms:
        print(wfm)
        if wfm is not None:
            print(f'n samples: {len(wfm["samples"])}')
            ramp_starts[wfm["chan_num"]] = wfm["samples"][0]

    ramp_offset = (ramp_starts[1] - ramp_starts[0]) & 0xFFF
    print(ramp_offset)

    print("Configuring channel 1 for a trigger 8 clock ticks after channel 0")
    chan1_thresh = (ramp_offset + 2) & 0xFFF
    print(f"Chan 1 threshold: {chan1_thresh}")
    zed.fpga_write("trig_threshold[1]", (chan1_thresh + 2) & 0xFFF)
    zed.fpga_write("trig_settings[1]", 0x9)
    print("Enabling trig link for both channels")
    zed.fpga_write("trig_link_en", 0x3)
    print("Arming triggers")
    zed.fpga_write("trig_arm", 0x3)
    print("Armed readback:")
    print(zed.fpga_read("trig_armed"))

    wfms = (zed.read_waveform(), zed.read_waveform())
    check_ltcs(wfms)

    print("New waveforms:")

    for wfm in wfms:
        print(wfm)
        if wfm is not None:
            print(f'n samples: {len(wfm["samples"])}')
            ramp_starts[wfm["chan_num"]] = wfm["samples"][0]

    print("disabling triggers...")
    zed.fpga_write("trig_link_en", 0x0)
    for chan in 0, 1:
        zed.fpga_write(f"trig_settings[{chan}]", 0x0)
        zed.fpga_write(f"trig_threshold[{chan}]", 0x0)
        zed.fpga_write(f"trig_mode[{chan}]", 0x0)

    # empty the buffers
    # while zed.read_waveform() is not None:
    #     pass

    print("disabling reader...")
    zed.fpga_write("buf_reader_enable", 0x0)


if __name__ == "__main__":
    main()
