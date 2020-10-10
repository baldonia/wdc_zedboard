###################################################
# Aaron Fienberg
#
# reset all waveform buffers, set a test pattern,
# read out one waveform

from wdc_zedboard import wdcZedboard, read_dev_path
from matplotlib import pyplot as plt
import sys
import numpy as np
import time

test_conf = 500
clock_freq = 245.76  # MHz


def main():
    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    chan = int(sys.argv[1])
    pattern = sys.argv[2]

    print("Resetting waveform buffers and adc...")
    zed.fpga_write("buf_rst", 0xFFFF)
    zed.fpga_write("buf_rst", 0x0)
    zed.init_adcs()
    time.sleep(0.1)
    print(f"setting {pattern} test pattern")

    if pattern == "deskew":
        print("Setting deskew")
        zed.set_deskew_pattern(chan)
        pattern = "custom"

    elif pattern not in zed.adc_data["test_patterns"]:
        try:
            zed.set_custom_pattern(chan, int(pattern))
            pattern = "custom"
        except ValueError:
            pass

    if pattern != "none":
        zed.set_adc_test_pattern(chan, pattern)

    print("Configuring test conf")
    zed.fpga_write(f"test_conf[{chan}]", test_conf)

    zed.fpga_write("buf_reader_dpram_mode", 1)

    print("Sending software triggers")
    zed.fpga_write("sw_trig", 1 << chan)

    print("Enabling reader")
    zed.fpga_write("buf_reader_enable", 0x1)

    while True:
        wfm = zed.read_waveform()
        if wfm is None:
            break

        chan = wfm["chan_num"]
        evt_len = wfm["evt_len"]
        wfm_ltc = wfm["ltc"]

        print(f'chan {chan} adc_samples: {wfm["samples"][:16]}')

        # look at bit pairs
        for pair_ind in range(6):
            pair_vals = (wfm["samples"] >> (2 * pair_ind)) & 0x3
            print(f"pair {pair_ind}: {pair_vals[:16]}")

        # print sample mean to help with testing
        print(f'sample mean = {np.average(wfm["samples"]):.2f}')

    print("disabling reader...")
    zed.fpga_write("buf_reader_enable", 0x0)


if __name__ == "__main__":
    main()
