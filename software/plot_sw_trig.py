###################################################
# Aaron Fienberg
#
# plot one software triggered waveform

from wdc_zedboard import wdcZedboard, read_dev_path
from matplotlib import pyplot as plt
import sys
import numpy as np
import time

plt.rcParams["xtick.labelsize"] = 14
plt.rcParams["ytick.labelsize"] = 14
plt.rcParams["axes.labelsize"] = 16
plt.rcParams["axes.titlesize"] = 16

color_cycle = plt.rcParams["axes.prop_cycle"].by_key()["color"]

colors = dict(combined=color_cycle[2])
for i in 0, 1:
    colors[i] = color_cycle[i]

test_conf = 50
clock_freq = 245.76  # MHz


def order_wfms(wfms):
    chan_nums = [wfm["chan_num"] for wfm in wfms]

    if chan_nums == [0, 1]:
        return wfms
    elif chan_nums == [1, 0]:
        return (wfms[1], wfms[0])
    else:
        raise RuntimeError("Could not read a waveform from both channels!")


def plot_wfm(wfm, ax):
    chan_num = wfm["chan_num"]

    color = colors[chan_num]

    if chan_num == "combined":
        ax.set_title("interleaved")
        samps = wfm["samples"]
        n_samps = len(samps)
        ax.plot(samps[::2], "o", color=colors[1])
        ax.plot(np.arange(int(n_samps / 2)) + 0.5, samps[1::2], "o", color=colors[0])
    else:
        ax.set_title(f"channel {chan_num}")
        ax.plot(wfm["samples"], "-", color=color)

    ax.set_ylabel("ADU")


def plot_fft(wfm, ax):
    chan_num = wfm["chan_num"]

    color = colors[chan_num]

    period = 1 / clock_freq

    if chan_num == "combined":
        period /= 2

    fft_freq = np.fft.fftfreq(len(wfm["samples"]), period)
    fft = np.abs(np.fft.fft(wfm["samples"]))

    ax.plot(fft_freq[fft_freq > 0], fft[fft_freq > 0], "-", color=color)
    ax.set_ylabel("FFT mag")

    ax.set_xlabel("f (MHz)")


def make_plots(wfms, axes):
    # create combined wfm
    wfm_len = len(wfms[0]["samples"])

    combined_samples = np.empty(2 * wfm_len, np.uint16)
    # samples from channel 1 should come first
    combined_samples[::2] = wfms[1]["samples"]
    combined_samples[1::2] = wfms[0]["samples"]

    combined_wfm = dict(chan_num="combined", samples=combined_samples)

    axiter = axes.flat
    for chan_num in [0, 1, "combined"]:

        wfm = wfms[chan_num] if chan_num != "combined" else combined_wfm

        plot_wfm(wfm, next(axiter))
        plot_fft(wfm, next(axiter))


def main():
    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    if len(sys.argv) == 2:
        test_conf = int(sys.argv[1])

    print("Resetting waveform buffers and adc...")
    zed.fpga_write("buf_rst", 0xFFFF)
    zed.fpga_write("buf_rst", 0x0)
    zed.init_adcs()
    time.sleep(0.1)

    print("Configuring test conf")
    for chan in 0, 1:
        zed.fpga_write(f"test_conf[{chan}]", test_conf)

    zed.fpga_write("buf_reader_dpram_mode", 1)

    print("Sending software triggers")
    zed.fpga_write("sw_trig", 0x3)

    print("Enabling reader")
    zed.fpga_write("buf_reader_enable", 0x1)

    wfms = (zed.read_waveform(), zed.read_waveform())

    if None in wfms:
        raise RuntimeError("Failed to read a waveform from both channels!")

    print("disabling reader...")
    zed.fpga_write("buf_reader_enable", 0x0)

    wfms = order_wfms(wfms)

    # quick plotting test
    fig, axes = plt.subplots(ncols=2, nrows=3, figsize=(12.0, 12.0))
    plt.subplots_adjust(hspace=0.3)
    make_plots(wfms, axes)
    plt.show()


if __name__ == "__main__":
    main()
