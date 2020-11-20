###################################################
# Aaron Fienberg
#
# Acquire a number of waveforms and save them in an npy file

import argparse
import sys
import time
import subprocess
import datetime

import numpy as np

from wdc_zedboard import wdcZedboard, read_dev_path

THRESH_TRIG_SLEEP = 0.01


def parse_args():
    parser = argparse.ArgumentParser(
        prog="acquire_waveforms", description="Acquire waveforms from the degg board"
    )
    parser.add_argument(
        "--n_waveforms",
        "-n",
        type=int,
        help="The number of waveforms to acquire",
        default="1",
    )
    parser.add_argument(
        "--outfile_name", "-o", type=str, help="output file name", default="default",
    )
    parser.add_argument(
        "--sw_trigger",
        "-s",
        action="store_true",
        help="Set this to send a software trigger for each acquisition",
    )
    parser.add_argument(
        "--thresh_trigger", "-t", action="store_true", help="Use threshold triggering",
    )
    parser.add_argument(
        "--threshold",
        type=int,
        help="Trigger threshold for threshold triggering mode",
        default=0,
    )
    parser.add_argument(
        "--skip_ltc",
        action="store_true",
        help="Skip the LTCs validation for each waveform acquisition",
    )

    args = parser.parse_args()

    if args.sw_trigger + args.thresh_trigger != 1:
        print("You must select exactly one of sw_trigger and thresh_trigger, not both")
        sys.exit(0)

    if args.thresh_trigger and args.threshold == 0:
        print(
            "Warning: threshold is set to 0. Consider setting a nonzero threshold with the --threshold parameter."
        )

    return args


def check_io_rst_state(zed):
    io_rst_state = 0
    for chan in 0, 1:
        io_rst_state |= zed.fpga_read(f"dig_io_reset[{chan}]")
    if io_rst_state == 1:
        raise RuntimeError(
            "ADC IO is in reset! "
            "Either manually enable both ADC IO modules "
            "or run the delay_scan script."
        )


def reset_acquisition(zed):
    zed.fpga_write("buf_reader_enable", 0x0)
    zed.fpga_write("trig_link_en", 0x0)
    for chan in 0, 1:
        zed.fpga_write(f"trig_settings[{chan}]", 0x0)
        zed.fpga_write(f"trig_mode[{chan}]", 0x0)

    zed.fpga_write("buf_rst", 0xFFFF)
    zed.fpga_write("buf_rst", 0x0)
    zed.init_adcs()
    zed.fpga_write("buf_reader_dpram_mode", 1)
    time.sleep(0.1)


def configure_thresh_trigger(args, zed):
    for chan in 0, 1:
        zed.fpga_write(f"trig_mode[{chan}]", 0x1)
        zed.fpga_write(f"trig_threshold[{chan}]", args.threshold)
        zed.fpga_write(f"trig_settings[{chan}]", 0xB)

    zed.fpga_write("trig_link_en", 0x3)


def order_wfms(wfms):
    chan_nums = [wfm["chan_num"] for wfm in wfms]

    if chan_nums == [0, 1]:
        return wfms
    elif chan_nums == [1, 0]:
        return (wfms[1], wfms[0])
    else:
        raise RuntimeError("Did not read a waveform from both channels!")


def get_sw_trig_wfms(zed):
    zed.fpga_write("sw_trig", 0x3)
    return order_wfms((zed.read_waveform(), zed.read_waveform()))


def get_thresh_trig_wfms(zed):
    zed.fpga_write("trig_arm", 0x3)
    time.sleep(THRESH_TRIG_SLEEP)
    return order_wfms((zed.read_waveform(), zed.read_waveform()))


def check_ltcs(wfms):
    if wfms[0]["ltc"] != wfms[1]["ltc"]:
        raise RuntimeError("LTCs do not match between channels!")


def acquire_wfms(args, zed):
    if args.sw_trigger:
        wfms = get_sw_trig_wfms(zed)
    else:
        wfms = get_thresh_trig_wfms(zed)

    if not args.skip_ltc:
        check_ltcs(wfms)

    return wfms


def main():
    args = parse_args()
    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))
    print(f"Firmware version: 0x{zed.fw_vnum:x}")
    check_io_rst_state(zed)
    reset_acquisition(zed)

    if args.thresh_trigger:
        configure_thresh_trigger(args, zed)

    wfms = []

    zed.fpga_write("buf_reader_enable", 0x1)
    for i in range(args.n_waveforms):
        wfms.append(acquire_wfms(args, zed))

        if i % 100 == 0:
            print(f"acquired waveform {i}")

    zed.fpga_write("buf_reader_enable", 0x0)

    print(f"got {len(wfms)} waveform{'s' if len(wfms) > 1 else ''}")

    # save output file
    subprocess.call("mkdir -p waveforms/".split())
    time_str = datetime.datetime.now().strftime("%m_%d_%Y-%H_%M_%S")
    ofname = f"waveforms/{args.outfile_name}_{time_str}.npz"
    np.savez_compressed(ofname, a=wfms)


if __name__ == "__main__":
    main()
