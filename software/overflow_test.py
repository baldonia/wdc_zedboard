###################################################
# Aaron Fienberg
#
# overflow all buffers, then drain them

from wdc_zedboard import wdcZedboard, read_dev_path
import sys
import time
import numpy as np
from sw_trig_all import *


test_conf = 5000


def main():
    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    print("Resetting waveform buffers...")
    zed.fpga_write("buf_rst", 0xFFFF)
    zed.fpga_write("buf_rst", 0x0)

    zed.fpga_write("buf_reader_dpram_mode", 1)

    print("Configuring test conf")
    for chan in 0, 1:
        zed.fpga_write(f"test_conf[{chan}]", test_conf)

    print("Causing buffer overflow...")
    while zed.fpga_read("buf_overflow") != 0x3:
        zed.fpga_write("sw_trig", 0x3)
    print_wfm_count(zed)

    print("Enabling reader")
    zed.fpga_write("buf_reader_enable", 0x1)

    print("draining buffers...")
    counter = 0
    start = time.time()
    samp_acc = 0
    while True:
        wfm = zed.read_waveform()
        if wfm is None:
            break
        samp_acc += len(wfm["samples"])

        counter = counter + 1
        if counter % 100 == 0:
            print_wfm_count(zed)
    delta = time.time() - start

    print(counter)

    print_wfm_count(zed)

    print(f"Read {samp_acc} samples in {delta:.2f} seconds")
    data_rate = 16 * samp_acc / delta / 1e6
    print(f"Data rate: {data_rate:3f} Mbit/s with test_conf of {test_conf}")

    print("disabling reader...")
    zed.fpga_write("buf_reader_enable", 0x0)


if __name__ == "__main__":
    main()
