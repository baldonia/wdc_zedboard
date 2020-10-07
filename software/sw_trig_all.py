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

test_conf = 1021


def check_ramp(wfm):
    samples = wfm["samples"]

    diff = np.remainder((samples[1:] - samples[:-1]), (1 << 12))

    return np.all(diff == 1)


def print_wfm_count(zed):
    count = []
    for chan in range(2):
        count.append(zed.fpga_read(f"buf_n_wfms[{chan}]"))
    print(f"wfms in buf: {count}")


def check_wfm(wfm, ltc):
    chan = wfm["chan_num"]
    evt_len = wfm["evt_len"]

    assert wfm["trig_type"] == "sw"

    assert ltc == wfm["ltc"]

    assert 2 * evt_len == len(wfm["samples"]) == 2 * test_conf

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

    print("Configuring test conf")
    for chan in 0, 1:
        zed.fpga_write(f"test_conf[{chan}]", test_conf)

    zed.fpga_write("buf_reader_dpram_mode", 1)

    print_wfm_count(zed)

    print("Sending software triggers")
    zed.fpga_write("sw_trig", 0x3)
    print_wfm_count(zed)

    print("Enabling reader")

    ltc = None
    zed.fpga_write("buf_reader_enable", 0x1)

    while True:
        wfm = zed.read_waveform()
        if wfm is None:
            break

        chan = wfm["chan_num"]
        evt_len = wfm["evt_len"]
        wfm_ltc = wfm["ltc"]

        if ltc is None:
            ltc = wfm_ltc

        try:
            check_wfm(wfm, ltc)
        except:
            print("Failed wfm!")
            print(wfm)
            raise

        print(f'chan {chan} adc_samples: {wfm["samples"][:5]}')

        print_wfm_count(zed)

    print("disabling reader...")
    zed.fpga_write("buf_reader_enable", 0x0)


if __name__ == "__main__":
    main()
