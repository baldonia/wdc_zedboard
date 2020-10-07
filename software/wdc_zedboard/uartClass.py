################################################################
# Tyler Anderson Thu 07/25/2019_ 9:22:20.08
#
# A python class for handling the serial interface to the
# uart board.
################################################################
import serial
import logging
import struct

from .cmdClass import cmdClass

################################################################
# An object representing the UART
class uartClass:
    """Object representing the UART"""

    ###################################
    # Data members
    def __init__(self, s_adr_dict=None):
        self.cc = cmdClass(s_adr_dict)
        self.rs232 = serial.Serial()
        self.dryrun = False

    ###################################
    # Data members
    # Setup the serial connection, bail if error
    def rs232_setup(self, port, timeout=1):
        if not self.dryrun:
            self.rs232 = serial.Serial(
                port=port,
                baudrate=3000000,
                parity=serial.PARITY_NONE,
                stopbits=serial.STOPBITS_ONE,
                timeout=timeout,
                bytesize=serial.EIGHTBITS,
                xonxoff=False,
                rtscts=False,
                dsrdtr=False,
            )

    # Close the serial port
    def rs232_close(self):
        self.rs232.close()

    # Write a raw string
    def write_raw(self, raw):
        self.rs232.write(raw)

    # Read a raw string
    def read_raw(self, length):
        rsp = self.rs232.read(length)
        if len(rsp) != length:
            raise IOError(f"Read only {len(rsp)} out of {length} bytes!")

        return rsp

    # Send an RS232 command to get a response
    def exe_cmd(
        self,
        logging=None,
        s_act=None,
        h_act=None,
        act=None,
        s_adr=None,
        h_adr=None,
        adr=None,
        h_length=None,
        length=None,
        h_data=None,
        data=None,
    ):
        self.cc.parse_cmd(
            logging,
            s_act,
            h_act,
            act,
            s_adr,
            h_adr,
            adr,
            h_length,
            length,
            h_data,
            data,
        )
        if self.cc.cmd["act"] == self.cc.S_ACT_DICT["srd"]:
            self.cc.srd_raw_cmd()
            self.write_raw(self.cc.cmd["raw_cmd"])
            self.cc.cmd["raw_rsp"] = self.read_raw(4)
            self.cc.srd_raw_rsp()
            self.cc.single_crc16_check()
            if self.cc.cmd["ok"]:
                logging.debug(
                    "uartClass: DEBUG: single read adr = 0x%04x: 0x%04x"
                    % (self.cc.cmd["adr"], self.cc.cmd["data"])
                )
            else:
                logging.warning(
                    "uartClass: ERROR: Checksum wrong for single read 0x%04x: 0x%04x"
                    % (self.cc.cmd["adr"], self.cc.cmd["data"])
                )
            return self.cc.cmd["data"], self.cc.cmd["ok"]
        elif self.cc.cmd["act"] == self.cc.S_ACT_DICT["swr"]:
            self.cc.cmd["crc16"] = self.cc.single_crc16_calc()
            self.cc.swr_raw_cmd()
            self.write_raw(self.cc.cmd["raw_cmd"])
            return self.cc.cmd["data"], self.cc.cmd["ok"]

        # ATF -- burst read and write
        elif self.cc.cmd["act"] == self.cc.S_ACT_DICT["bwr"]:
            # get data length in number of 16 bit words
            hex_data = hex(self.cc.cmd["data"]).rstrip("L")[2:]
            hex_len = len(hex_data)

            n_words = hex_len // 4
            if hex_len % 4 != 0:
                n_words += 1
            self.cc.cmd["len"] = n_words

            # get array of words
            words_array = []
            hex_data = hex_data.zfill(4 * n_words)
            for i in range(n_words):
                words_array.append(hex_data[4 * i : 4 * i + 4])

            # check for edge case of leading zeros in input
            # and make sure they get written properly
            if "inp_h_data" in self.cc.cmd:
                h_data_cpy = self.cc.cmd["inp_h_data"]
                while h_data_cpy.startswith("0000"):
                    words_array = ["0000"] + words_array
                    self.cc.cmd["len"] += 1
                    h_data_cpy = h_data_cpy[4:]

            self.cc.cmd["words_array"] = words_array

            # calculate checksum
            self.cc.cmd["crc16"] = self.cc.burst_crc16_calc()

            # send the command
            self.cc.bwr_raw_cmd()
            self.write_raw(self.cc.cmd["raw_cmd"])
            return self.cc.cmd["data"], self.cc.cmd["ok"]

        elif self.cc.cmd["act"] == self.cc.S_ACT_DICT["brd"]:
            self.cc.brd_raw_cmd()
            self.write_raw(self.cc.cmd["raw_cmd"])
            self.cc.cmd["raw_rsp"] = self.read_raw(self.cc.cmd["len"] * 2 + 2)
            self.cc.brd_raw_rsp()
            self.cc.burst_crc16_check()

            if self.cc.cmd["ok"]:
                logging.debug(
                    "uartClass: DEBUG: burst read adr = 0x%04x: 0x%04x"
                    % (self.cc.cmd["adr"], self.cc.cmd["data"])
                )
            else:
                logging.warning(
                    "uartClass: ERROR: Checksum wrong for burst read 0x%04x: 0x%04x"
                    % (self.cc.cmd["adr"], self.cc.cmd["data"])
                )

            return self.cc.cmd["data"], self.cc.cmd["ok"]
