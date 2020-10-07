# Aaron Fienberg
# October 2020
#
# Functions for unpacking waveforms from the
# prototype WDC zedboard project
#

import numpy as np

trig_type_map = {0: "sw", 1: "thresh", 2: "link", 3: "sw"}


def unpack_wfm(payload):
    if payload[0] >> 8 != 0x80:
        raise RuntimeError(f"Invalid header word! Got 0x{payload[0]:04x}")

    wfm = {}

    wfm["chan_num"] = payload[0] & 0xFF
    wfm["evt_len"] = payload[1]

    wfm["pre_conf"] = payload[2] >> 10
    wfm["const_run"] = ((payload[2] >> 9) & 0x1) == 1
    wfm["trig_type"] = trig_type_map[payload[2] & 0x3]
    wfm["ltc"] = (payload[3] << 32) + (payload[4] << 16) + payload[5]

    adc_words = payload[6:-2]
    wfm["samples"] = adc_words >> 2

    wfm["tot"] = (adc_words >> 1) & 0x1
    wfm["eoe"] = (adc_words) & 0x1

    return wfm


def wfm_n_words(payload):
    if payload[0] >> 8 != 0x80:
        raise RuntimeError(f"Invalid header word! Got 0x{payload[0]:04x}")
    # format 1
    return 8 + 2 * payload[1]
