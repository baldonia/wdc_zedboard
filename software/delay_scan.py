###################################################
# Aaron Fienberg
#
# Scan through delay settings for each channel,
# print results
#

from wdc_zedboard import wdcZedboard, read_dev_path
import sys
import numpy as np
import time

test_conf = 500
en_clk_freq = 245.76
ref_clk_freq = 200


def check_toggle_wfm(wfm):
    """ check deskew pattern for each bit pair
    return list of form [(pair_ind, valid)...] """
    results = []
    for pair_ind in range(6):
        pair_vals = (wfm["samples"] >> (2 * pair_ind)) & 0x3

        fst = pair_vals[0]

        if not fst in [0x1, 0x2]:
            good = False
        else:
            expected_pat = np.array([fst, (~fst) & 0x3], dtype=np.uint16)
            good = np.all(pair_vals == np.tile(expected_pat, int(len(pair_vals) / 2)))

        results.append((pair_ind, good))

    return results


def check_deskew_wfm(wfm):
    results = []
    for pair_ind in range(6):
        pair_vals = (wfm["samples"] >> (2 * pair_ind)) & 0x3

        good = np.all(pair_vals == 0x2)

        results.append((pair_ind, good))

    return results


def get_combined_results(scan_result):
    combined_res = []

    for delay, pair_results in scan_result.items():
        combined_res.append(all(res for _, res in pair_results))

    return combined_res


def print_pair_result(pair_ind, scan_result):
    line = f"D{2*pair_ind:02d}_{2*pair_ind + 1:02d}"

    for delay, delay_res in scan_result.items():
        res_pair_ind, good = delay_res[pair_ind]

        assert res_pair_ind == pair_ind
        char = "o" if good else "x"
        line += f" {char:2}"

    print(line)


def print_combined_result(combined_res):
    line = f"{'COMB':6}"
    for good in combined_res:
        char = "o" if good else "x"
        line += f" {char:2}"
    print(line)


def print_delay_scan_result(scan_result):
    for pair_ind in range(6):
        print_pair_result(pair_ind, scan_result)
    print_combined_result(get_combined_results(scan_result))

    delay_str = f'{"delay":6}'
    for delay in scan_result:
        delay_str += f" {delay:<2}"

    print(delay_str)


def set_delay(zed, chan, delay):
    for i in range(32):
        if zed.fpga_read(f"dig_delay_tapout_low[{chan}]") & 0x1F == delay:
            return

        # inc delay
        zed.fpga_write(f"dig_io_ctrl[{chan}]", 0x3)

    raise RuntimeError(f"Failed to set delay for channel {chan}")


def read_all_delays(zed, chan):
    delay_words = zed.fpga_read(f"dig_delay_tapout_high[{chan}]") << 16
    delay_words |= zed.fpga_read(f"dig_delay_tapout_low[{chan}]")

    return [(delay_words >> (5 * i)) & 0x1F for i in range(6)]


def get_best_delay(scan_result):
    """ find a good delay setting.
    Assumes the delay settings in scan_result start from 0 """

    combined_res = np.array(get_combined_results(scan_result), dtype=np.bool)

    delay_step = 1.0 / ref_clk_freq / 64

    bitclock_period = 1.0 / 2 / en_clk_freq

    delay_period = round(bitclock_period / delay_step)

    # keep delay < delay_period / 2
    # to avoid requiring any bitslips
    max_delay = int(delay_period / 2)

    rollover_delays = combined_res[max_delay + 1 : delay_period]

    search_window = np.hstack((rollover_delays, combined_res[: max_delay + 1]))

    offset = search_window[1:]
    bad_to_good = (search_window[:-1] == False) & (offset == True)

    transitions = np.argwhere(bad_to_good)

    if len(transitions) == 0:
        good_len = np.count_nonzero(search_window)
        recommended_delay = 0
    else:
        transition_ind = transitions[0][0] + 1

        next_bads = np.argwhere(search_window[transition_ind:] == False)

        if len(next_bads) == 0:
            bad_ind = len(search_window)
        else:
            bad_ind = transition_ind + next_bads[0][0]

        good_len = np.count_nonzero(search_window[transition_ind:bad_ind])

        center = int(transition_ind + good_len / 2)

        recommended_delay = center - len(rollover_delays)
        if recommended_delay < 0:
            recommended_delay = 0

    return (recommended_delay, good_len)


def main():
    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    print("Resetting waveform buffers and adc...")
    zed.fpga_write("buf_rst", 0xFFFF)
    zed.fpga_write("buf_rst", 0x0)
    zed.init_adcs()
    time.sleep(0.1)

    for chan in 0, 1:
        print(f"Setting deskew pattern for chan {chan}")
        zed.set_deskew_pattern(chan)
        zed.set_adc_test_pattern(chan, "custom")

        print(f"Configuring test conf for chan {chan}")
        zed.fpga_write(f"test_conf[{chan}]", test_conf)
        print(f"Resetting io & delay for chan {chan}")
        zed.fpga_write(f"dig_io_reset[{chan}]", 1)
        zed.fpga_write(f"dig_delay_reset[{chan}]", 1)
        zed.fpga_write(f"dig_io_reset[{chan}]", 0)
        zed.fpga_write(f"dig_delay_reset[{chan}]", 0)

    zed.fpga_write("buf_reader_dpram_mode", 1)

    print("Enabling reader")
    zed.fpga_write("buf_reader_enable", 0x1)

    # results for each channel
    scan_results = [{}, {}]

    for _ in range(32):
        zed.fpga_write("sw_trig", 0x3)

        wfms = (zed.read_waveform(), zed.read_waveform())

        if None in wfms:
            raise RuntimeError("Failed to read a waveform from both channels!")

        for wfm in wfms:
            chan = wfm["chan_num"]
            delay = zed.fpga_read(f"dig_delay_tapout_low[{chan}]") & 0x1F
            # scan_results[chan][delay] = check_toggle_wfm(wfm)
            scan_results[chan][delay] = check_deskew_wfm(wfm)
            # inc delay
            zed.fpga_write(f"dig_io_ctrl[{chan}]", 0x3)

    print("disabling reader...")
    zed.fpga_write("buf_reader_enable", 0x0)

    for chan in 0, 1:
        print(f"Channel {chan} results:")
        print_delay_scan_result(scan_results[chan])
        best_delay, good_len = get_best_delay(scan_results[chan])
        print(f"setting delay for channel {chan} to {best_delay}")
        set_delay(zed, chan, best_delay)
        print(f"Chan {chan} delay readback: {read_all_delays(zed, chan)}")
        if chan == 0:
            print("-----")


if __name__ == "__main__":
    main()
