###################################################
# Aaron Fienberg
#
# reset all waveform buffers, trigger both channels,
# verify the results are correct
#

from wdc_zedboard import wdcZedboard, read_dev_path
import sys
import numpy as np
import time
from sw_trig_all import *


pre_conf = 9
post_conf = 12
thresh_val = 97


def check_wfm(wfm):
    chan = wfm["chan_num"]
    evt_len = wfm["evt_len"]

    assert wfm["trig_type"] == "thresh"

    assert 2 * evt_len == len(wfm["samples"]) == 2 * (pre_conf + post_conf + 1)

    assert (
        wfm["samples"][2 * pre_conf] == thresh_val or wfm["samples"][2 * pre_conf + 1]
    )

    # check that this is the channel we think it is...
    assert wfm["samples"][0] % 2 == chan

    # check EOE
    eoe_inds = np.argwhere(wfm["eoe"] == 1)
    assert len(eoe_inds) == 1
    assert eoe_inds[0][0] == len(wfm["samples"]) - 1

    assert check_ramp(wfm)


def main():
    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    print("Resetting waveform buffers...")
    zed.fpga_write("buf_rst", 0xFFFF)
    zed.fpga_write("buf_rst", 0x0)
    time.sleep(0.1)

    print("Configuring trigger settings")
    for chan in (0, 1):
        zed.fpga_write(f"pre_conf[{chan}]", pre_conf)
        zed.fpga_write(f"post_conf[{chan}]", post_conf)
        zed.fpga_write(f"trig_mode[{chan}]", 1)
        zed.fpga_write(f"trig_threshold[{chan}]", thresh_val)

    zed.fpga_write("buf_reader_dpram_mode", 1)
    print("Arming triggers")
    zed.fpga_write("trig_arm", 0x3)
    print("Armed readback:")
    print(zed.fpga_read("trig_armed"))

    print_wfm_count(zed)

    print("Enabling triggers")
    for chan in 0, 1:
        zed.fpga_write(f"trig_settings[{chan}]", 0x9)
    print("Armed readback:")
    print(zed.fpga_read("trig_armed"))
    print_wfm_count(zed)

    print("Enabling reader")

    zed.fpga_write("buf_reader_enable", 0x1)

    while True:
        wfm = zed.read_waveform()
        if wfm is None:
            break

        chan = wfm["chan_num"]
        evt_len = wfm["evt_len"]
        wfm_ltc = wfm["ltc"]

        try:
            check_wfm(wfm)
        except:
            print("Failed wfm!")
            print(wfm)
            raise

        print(f'chan {chan} adc_samples: {wfm["samples"][:5]}')
        tot_index = np.argwhere(wfm["tot"] == 1)[0][0]
        print(f"chan {chan} tot index: {tot_index}")

        print_wfm_count(zed)

    print("disabling triggers...")
    for chan in 0, 1:
        zed.fpga_write(f"trig_settings[{chan}]", 0x0)
        zed.fpga_write(f"trig_mode[{chan}]", 0x0)
        zed.fpga_write(f"trig_threshold[{chan}]", 0x0)

    print("disabling reader...")
    zed.fpga_write("buf_reader_enable", 0x0)


if __name__ == "__main__":
    main()
