# wdcZedboard.py
#
# September 2020
#
# Class for interfacing with the Zynq FPGA via the USB UART interface
#

import logging
import time
import numpy as np
from .uartClass import uartClass
from .unpack_wfm import unpack_wfm, wfm_n_words


class wdcZedboard:
    """ class for interfacing with the FPGA on the arty S7 board
    via the USB UART interface
    """

    # address and data maps
    fpga_adrs = {
        "fw_vnum": 0xFFF,
        "trig_settings": [0xFFE, 0xEFE],
        "trig_threshold": [0xFFD, 0xEFD],
        "sw_trig": 0xFFC,
        "trig_mode": [0xFFB, 0xEFB],
        "trig_arm": 0xFFA,
        "trig_armed": 0xFF9,
        "const_conf": [0xFF7, 0xEF7],
        "test_conf": [0xFF6, 0xEF6],
        "post_conf": [0xFF5, 0xEF5],
        "pre_conf": [0xFF4, 0xEF4],
        "dpram_len": 0xDFF,
        "dpram_done": 0xDFE,
        "dpram_sel": 0xDFD,
        "buf_n_wfms": [0xDFC, 0xDF5],
        "buf_wds_used": [0xDFB, 0xDF4],
        "buf_overflow": 0xDFA,
        "buf_rst": 0xDF9,
        "buf_reader_enable": 0xDF8,
        "buf_reader_dpram_mode": 0xDF7,
        "dac_sel": 0xBFF,
        "dac_task_reg": 0xBFE,
        "dac_spi_wr_high": 0xBFD,
        "dac_spi_wr_low": 0xBFC,
        "dig_sel": 0xBEF,
        "dig_task_reg": 0xBEE,
        "dig_wr_data": 0xBED,
        "dig_rd_data": 0xBEC,
        "led_toggle": 0x8FF,
        "spi_rst": 0x8FC,
        "event_data": 0x000,
    }

    fpga_data = {}

    # tuples denote (adr, bit position, mask)
    adc_adrs = {
        "reset": (0x00, 1, 0x01),
        "readout": (0x00, 0, 0x01),
        "lvds_swing": (0x01, 2, 0x3F),
        "high_perf_mode_1": (0x03, 0, 0x03),
        "gain": (0x25, 4, 0x0F),
        "disable_gain": (0x25, 3, 0x01),
        "test_patterns": (0x25, 0, 0x07),
        "lvds_clkout_strength": (0x26, 1, 0x01),
        "lvds_data_strength": (0x26, 0, 0x01),
        "data_format": (0x3D, 6, 0x03),
        "en_offset_corr": (0x3D, 5, 0x01),
        "custom_pattern_high": (0x3F, 0, 0x3F),
        "custom_pattern_low": (0x40, 0, 0xFF),
        "lvds_cmos": (0x41, 6, 0x03),
        "cmos_clkout_strength": (0x41, 4, 0x03),
        "en_clkout_rise": (0x41, 3, 0x01),
        "clkout_rise_posn": (0x41, 1, 0x03),
        "en_clkout_fall": (0x41, 0, 0x01),
        "clkout_fall_posn": (0x42, 6, 0x03),
        "disable_low_latency": (0x42, 3, 0x01),
        "stby": (0x42, 2, 0x01),
        "pdn_global": (0x43, 6, 0x01),
        "pdn_obuf": (0x43, 4, 0x01),
        "en_lvds_swing": (0x43, 0, 0x03),
        "high_perf_mode_2": (0x4A, 0, 0x01),
        "offset_pedestal": (0xBF, 2, 0x3F),
        "freeze_offset_corr": (0xCF, 7, 0x01),
        "offset_corr_time_constant": (0xCF, 2, 0x0F),
        "low_speed": (0xDF, 4, 0x03),
    }

    adc_data = {
        "reset": 1,
        "rd": 1,
        "wr": 0,
        "lvds_swings": {
            "default_swing": 0x0,
            "410mv": 0x1B,
            "465mv": 0x32,
            "570mv": 0x24,
            "200mv": 0xF2,
            "125mv": 0x0F,
        },
        "default_perf": 0x00,
        "high_perf_1": 0x03,
        "gains": {
            "0.0db": 0x00,
            "0.5db": 0x01,
            "1.0db": 0x02,
            "1.5db": 0x03,
            "2.0db": 0x04,
            "2.5db": 0x05,
            "3.0db": 0x06,
            "3.5db": 0x07,
            "4.0db": 0x08,
            "4.5db": 0x09,
            "5.0db": 0x0A,
            "5.5db": 0x0B,
            "6.0db": 0x0C,
        },
        "enable_gain": 0x00,
        "disable_gain": 0x01,
        "test_patterns": {
            "none": 0x00,
            "zeros": 0x01,
            "ones": 0x02,
            "toggle": 0x03,
            "ramp": 0x04,
            "custom": 0x05,
        },
        "100ohm": 0,
        "50ohm": 1,
        "dfs_pin": 0,
        "twos_complement": 2,
        "offset_binary": 3,
        "disable_offset_corr": 0,
        "enable_offset_corr": 1,
        "ddr_lvds": 1,
        "parallel_cmos": 3,
        "max_cmos_clkout": 0,
        "med_cmos_clkout": 1,
        "low_cmos_clkout": 2,
        "very_low_cmos_clkout": 3,
        "disable_clkout_rise_ctrl": 0,
        "en_clkout_rise": 1,
        "clkout_posns": {
            "default_lvds_clkout_posn": 0,
            "500ps_lvds_clkout_posn": 1,
            "aligned_lvds_clkout_posn": 2,
            "200ps_lvds_clkout_posn": 3,
            "default_cmos_clkout_posn": 0,
            "100ps_cmos_clkout_posn": 1,
            "200ps_cmos_clkout_posn": 2,
            "1.5ns_cmos_clkout_posn": 3,
            "400ps_lvds_clkout_fall": 1,
            "aligned_lvds_clkout_fall": 2,
            "200ps_lvds_clkout_fall": 3,
        },
        "disable_clkout_fall_ctrl": 0,
        "enable_clkout_fall_ctrl": 1,
        "default_lvds_clkout_fall": 0,
        "enable_low_latency": 0,
        "disable_low_latency": 1,
        "normal_ops": 0,
        "standby": 1,
        "global_power_down": 1,
        "global_on": 0,
        "obuf_power_down": 1,
        "obuf_on": 0,
        "disable_lvds_swing": 0,
        "enable_lvds_swing": 1,
        "high_perf_2": 1,
        "enable_offset_corr": 0,
        "freeze_offset_corr": 1,
        "offset_time_consts": {
            "1M": 0x0,
            "2M": 0x1,
            "4M": 0x2,
            "8M": 0x3,
            "16M": 0x4,
            "32M": 0x5,
            "64M": 0x6,
            "128M": 0x7,
            "256M": 0x8,
            "512M": 0x9,
            "1G": 0xA,
            "2G": 0xB,
        },
        "enable_low_speed": 0x3,
    }

    dac_cmds = {
        "wr_n": 0,  # Write to register n
        "up_n": 1,  # Update DAC register n
        "wr_n_up_all": 2,  # write n, update all
        "wr_up_n": 3,  # Write to and update DAC Channel n
        "pdu": 4,  # Power down/power up DAC
        "nop": 15,  # No operation
    }

    dac_addrs = {"a": 0, "b": 1, "all": 15}

    #
    # Methods
    #

    def __init__(
        self, uart=None, dev_path=None, uart_sleep=0, uart_timeout=0.25, n_read_tries=3,
    ):
        """ Initializes the wdcZedboard object

        can pass in either an instance of uartClass or a device path,
        e.g. wdcZedboard(dev_path='/dev/ttys3')
        or wdcZedboard(uart)

        uart_sleep is the number of ms to sleep following each uart command

        uart_timeout is the timeout for the usb uart serial interface

        n_read_tries is how many times to attempt a read operation before throwing an error
        """

        if uart is not None and dev_path is not None:
            # must provide either a uart object or a dev path, not both
            raise RuntimeError(
                "Both uart and dev_path are not None (only one should be use)"
            )

        self.uart = uart

        if dev_path is not None:
            uart = uartClass()
            uart.rs232_setup(dev_path, timeout=uart_timeout)
            self.uart = uart

        if uart is None:
            raise RuntimeError("uart is unitialized")

        self.uart_sleep = uart_sleep / 1000  # convert from ms to s

        self.n_read_tries = n_read_tries

    @property
    def fw_vnum(self):
        return self.fpga_read("fw_vnum")

    def read_waveform(self):
        """ read a waveform from the board"""
        event_len = int(self.fpga_read("dpram_len"))

        if event_len == 0:
            return None

        self.fpga_write("dpram_sel", 1)

        dpram_mode = self.fpga_read("buf_reader_dpram_mode")

        fragments = [self.fpga_read("event_data", read_len=event_len)]

        if dpram_mode == 0:
            self.fpga_write("dpram_done", 1)
            return unpack_wfm(fragments[0])

        expected_total_words = wfm_n_words(fragments[0])

        n_read = event_len
        while n_read < expected_total_words:
            self.fpga_write("dpram_done", 1)

            next_len = self.fpga_read("dpram_len")

            if next_len == 0:
                break

            fragments.append(self.fpga_read("event_data", read_len=next_len))
            n_read += next_len

        wfm_payload = np.hstack(fragments)

        self.fpga_write("dpram_done", 1)

        return unpack_wfm(wfm_payload)

    def sw_reset(self, dig_num):
        """ apply software reset to digitizer <dig_num> """
        self.check_dig_num(dig_num)

        self.adc_write(dig_num, "reset", "reset")

    def set_dac(self, dac_num, channel, value):
        high_bits = (self.dac_cmds["wr_n_up_all"] << 4) + self.dac_addrs[channel]
        low_bits = value << 2
        if low_bits > 0xFFFF:
            raise ValueError("DAC value 0x{value:x} too large. It is a 14-bit DAC")

        full_word = (high_bits << 16) | low_bits

        if dac_num in (0, 1):
            self.fpga_write("dac_sel", dac_num)
        else:
            raise ValueError(f"Invalid DAC number ({dac_num})")

        self.fpga_write("dac_spi_wr_high", high_bits)
        self.fpga_write("dac_spi_wr_low", low_bits)
        self.fpga_write("dac_task_reg", 0x1)

    def register_dump(self):
        """ read all the FPGA DPRAM addresses.
        returns a list with one register value per entry, starting with address 0"""
        DPRAM_SIZE = 0x1000
        data = self.fpga_read(0, read_len=DPRAM_SIZE)

        hex_chars = hex(data).rstrip("L")[2:].zfill(4 * DPRAM_SIZE)

        return [hex_chars[4 * i : 4 * i + 4] for i in range(DPRAM_SIZE)]

    def fpga_write(self, adr, data):
        """ wrapper around uart write """
        adr = self.parse_fpga_adr(adr)

        data = self.parse_fpga_data(data)

        self.uart.exe_cmd(logging, s_act="swr", adr=adr, data=data)

        time.sleep(self.uart_sleep)

    def fpga_burst_write(self, adr, h_data):
        """ wrapper around uart burst write """
        adr = self.parse_fpga_adr(adr)

        self.uart.exe_cmd(logging, s_act="bwr", adr=adr, h_data=h_data)

        time.sleep(self.uart_sleep)

    def fpga_read(self, adr, read_len=1):
        """ wrapper around uart read """
        adr = self.parse_fpga_adr(adr)

        read_len = int(read_len)

        if read_len == 1:
            data, ok = self._fpga_srd(adr)
        elif read_len > 1:
            data, ok = self._fpga_brd(adr, read_len)

        else:
            raise ValueError(f"read_len ({read_len}) must be >= 1!")

        if not ok:
            raise RuntimeError("Incorrect checksum from uart read!")

        time.sleep(self.uart_sleep)

        return data

    def _fpga_srd(self, adr):
        """ fpga single read """
        for i in range(self.n_read_tries):
            try:
                data, ok = self.uart.exe_cmd(logging, s_act="srd", adr=adr)
                break
            except IOError:
                if i == self.n_read_tries - 1:
                    raise

        return data, ok

    def _fpga_brd(self, adr, read_len):
        """ fpga burst read """
        for i in range(self.n_read_tries):
            try:
                data, ok = self.uart.exe_cmd(
                    logging, s_act="brd", adr=adr, length=read_len
                )
                break
            except IOError:
                if i == self.n_read_tries - 1:
                    raise

        # interpret data as array of uint16s, ignoring the crc
        data_array = np.frombuffer(self.uart.cc.cmd["raw_rsp"][:-2], np.uint16)
        data_array = data_array.byteswap()

        return data_array, ok

    def adc_read(self, dig_num, adr):
        """ read an ADC register using the SPI interface """

        # select digitizer, place ADC chip in read mode
        self.set_adc_readout_mode(dig_num, "rd")

        # set the read address
        adr = wdcZedboard.parse_adc_adr(adr)

        self.check_adc_adr(adr)

        try:
            adr = adr[0]
        except TypeError:
            pass

        self.fpga_write("dig_wr_data", data=adr << 8)

        # execute the command
        self.fpga_write("dig_task_reg", data=0x1)

        # read back the data and return it
        return self.fpga_read("dig_rd_data")

    def adc_write(self, dig_num, adr, data):
        """ write to an ADC register using the SPI interface """

        # prepare data and address bytes
        adr = wdcZedboard.parse_adc_adr(adr)

        self.check_adc_adr(adr)

        data = wdcZedboard.parse_adc_data(data)

        try:
            data = self.build_spi_data(dig_num, adr, data)
        except TypeError:
            pass

        self.check_adc_data(data)

        # place ADC chip in write mode
        self.set_adc_readout_mode(dig_num, "wr")

        try:
            adr = adr[0]
        except TypeError:
            pass

        # set the write data
        self.fpga_write(adr="dig_wr_data", data=(adr << 8) | data)
        # execute the command
        self.fpga_write(adr="dig_task_reg", data=0x1)

    def build_spi_data(self, dig_num, adr, data):
        """ assumes data is a tuple of (data, bit position, mask)

        reads current data from adr, changes the portion given by (position, mask),
        and writes the data back into the register.

        This prevents writes to part of a register from affecting the
        rest of the data stored in the register."""
        new_data = data

        adr, pos, mask = adr

        data_to_write = new_data << pos

        old_data = self.adc_read(dig_num, adr)

        data_to_write += old_data & ~(mask << pos)

        return data_to_write

    def set_adc_readout_mode(self, dig_num, mode):
        """ set the FPGA chip-select and ADC readout mode """

        # select digitizer
        self.check_dig_num(dig_num)
        self.fpga_write("dig_sel", dig_num)

        if mode not in ["rd", "wr"]:
            raise ValueError(f'Mode {mode} must be "rd" or "wr"!')

        # change the readout mode using the SPI interface
        data = self.adc_data[mode]
        adr, pos, mask = self.adc_adrs["readout"]
        data = (data << pos) & mask

        self.fpga_write("dig_wr_data", (adr << 8) | data)
        self.fpga_write("dig_task_reg", 0x1)

    @staticmethod
    def check_dig_num(dig_num):
        if dig_num not in [0, 1]:
            raise ValueError(f"Digitizer number ({dig_num}) must be 0 or 1!")

    @staticmethod
    def check_adc_adr(adr):
        """ ensure adr is a valid ADS4149 register address """
        try:
            adr = adr[0]
        except TypeError:
            pass

        if adr >= (1 << 8):
            raise ValueError(f"ADC register address ({adr}) is too large!")

    @staticmethod
    def check_adc_data(data):
        """ ensure data is valid ADS4149 register data """
        if data >= (1 << 8):
            raise ValueError(f"Data value ({data}) is too large!")

    @staticmethod
    def parse_int_arg(arg):
        try:
            return int(arg)
        except ValueError:
            return int(arg, 16)

    @staticmethod
    def parse_str_arg(arg, table):
        return table[arg]

    @staticmethod
    def parse_indexed_arg(arg, table):
        start_ind = arg.index("[")
        end_ind = arg.index("]")

        key = arg[:start_ind]
        index = int(arg[start_ind + 1 : end_ind])

        return table[key][index]

    @staticmethod
    def parse_arg(arg, table):
        try:
            return wdcZedboard.parse_int_arg(arg)
        except ValueError:
            pass

        try:
            return wdcZedboard.parse_str_arg(arg, table)
        except (ValueError, KeyError):
            pass

        return wdcZedboard.parse_indexed_arg(arg, table)

    @staticmethod
    def parse_fpga_adr(arg):
        return wdcZedboard.parse_arg(arg, table=wdcZedboard.fpga_adrs)

    @staticmethod
    def parse_fpga_data(arg):
        return wdcZedboard.parse_arg(arg, table=wdcZedboard.fpga_data)

    @staticmethod
    def parse_adc_adr(arg):
        if type(arg) is tuple:
            return arg

        return wdcZedboard.parse_arg(arg, table=wdcZedboard.adc_adrs)

    @staticmethod
    def parse_adc_data(arg):
        return wdcZedboard.parse_arg(arg, table=wdcZedboard.adc_data)
