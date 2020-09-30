################################################################
# Tyler Anderson Thu 07/25/2019_ 9:24:16.32
#
# A python script for parsing commands.
################################################################
import logging
import string
import binascii
import sys
import struct
import crcmod


class cmdClass:
    """A class for handling the command protocol."""

    ###########################################################
    # Data members

    # Constants
    S_ACT_DICT = {
        "swr": 0x0001,  # single write
        "srd": 0x0002,  # single read
        "bwr": 0x8001,  # burst write
        "brd": 0x8002,
    }  # burst read

    ###########################################################
    # Methods
    def __init__(self, adr_dict=None):
        # Command struct
        self.cmd = {
            "ok": True,
            "raw_cmd": "\x8f\xc7\x00\x02\x0f\xff",  # Raw command
            "raw_rsp": "",  # Raw response
            "hdr": 0x8FC7,  # header word
            "act": 0x0002,  # swr, srd, bwr, brd
            "len": 0x0001,  # packet length for burst read/write
            "adr": 0x0FFF,  # a look up for the address
            "data": 0x0000,  # data
            "crc16": 0x0000,
        }  # CRC16
        self.S_ADR_DICT = adr_dict

    def srd_raw_cmd(self):
        self.cmd["raw_cmd"] = struct.pack(">H", self.cmd["hdr"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["act"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["adr"])
        # print binascii.hexlify(self.cmd['raw_cmd'])

    def srd_raw_rsp(self):
        x = int(binascii.hexlify(self.cmd["raw_rsp"]), 16)
        self.cmd["data"] = x >> 16
        self.cmd["crc16"] = x & 0xFFFF
        # print '%x' % self.cmd['data']
        # print '%x' % self.cmd['crc16']

    def single_crc16_calc(self):
        crc16 = crcmod.mkCrcFun(0x18005, rev=False, initCrc=0xFFFF, xorOut=0x0000)
        # print self.cmd['adr']
        # print type(self.cmd['adr'])
        xstr = hex(self.cmd["adr"])[2:].zfill(4)
        xstr = xstr + hex(self.cmd["data"])[2:].zfill(4)
        # print(xstr)
        checksum16 = int(hex(crc16(bytearray.fromhex(xstr)))[2:], 16)
        return checksum16

    def swr_raw_cmd(self):
        self.cmd["raw_cmd"] = struct.pack(">H", self.cmd["hdr"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["act"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["adr"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["data"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["crc16"])
        # print binascii.hexlify(self.cmd['raw_cmd'])

    def single_crc16_check(self):
        checksum16 = self.single_crc16_calc()
        if self.cmd["crc16"] == checksum16:
            self.cmd["ok"] = True
        else:
            self.cmd["ok"] = False

    def gse_cmd_str(self):
        return (
            "cmd: act = "
            + hex(self.cmd["act"])
            + ", len = "
            + hex(self.cmd["len"])
            + ", adr = "
            + hex(self.cmd["adr"])
            + ", data = "
            + hex(self.cmd["data"])
            + ", crc16 = "
            + hex(self.cmd["crc16"])
            + ", ok = "
            + str(self.cmd["ok"])
        )

    def parse_cmd(
        self,
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
    ):
        # Decode the data
        if data != None:
            self.cmd["data"] = data
        elif h_data != None:
            self.cmd["data"] = int(h_data, 16)
            self.cmd["inp_h_data"] = h_data
        #    print 'data is %d' % self.cmd['data']
        # Decode the length
        if length != None:
            self.cmd["len"] = length
        elif h_length != None:
            self.cmd["len"] = int(h_length, 16)
        # Decode the address
        if adr != None:
            self.cmd["adr"] = adr
        elif h_adr != None:
            self.cmd["adr"] = int(h_adr, 16)
        elif s_adr != None:
            self.cmd["adr"] = self.S_ADR_DICT[s_adr]
        else:
            logging.warning(
                "comClass: ERROR: Must specify one of s_adr, h_adr, or adr! Exiting!"
            )
            exit(-1)
        # Decode the action
        if act != None:
            self.cmd["act"] = act
        elif h_act != None:
            self.cmd["act"] = int(h_act, 16)
        elif s_act != None:
            self.cmd["act"] = self.S_ACT_DICT[s_act]
        else:
            logging.warning(
                "comClass: ERROR: Must specify either s_act or act! Exiting!"
            )
            exit(-1)

    # ATF -- burst read and write

    def bwr_raw_cmd(self):
        self.cmd["raw_cmd"] = struct.pack(">H", self.cmd["hdr"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["act"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["len"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["adr"])
        # pack in the data
        for word in self.cmd["words_array"]:
            self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", int(word, 16))

        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["crc16"])

    def brd_raw_cmd(self):
        self.cmd["raw_cmd"] = struct.pack(">H", self.cmd["hdr"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["act"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["len"])
        self.cmd["raw_cmd"] = self.cmd["raw_cmd"] + struct.pack(">H", self.cmd["adr"])

    def brd_raw_rsp(self):
        # srd_raw_rsp works for for now,
        # but if the first register is all 0's, they will not be printed
        self.srd_raw_rsp()

    def burst_crc16_calc(self):
        crc16 = crcmod.mkCrcFun(0x18005, rev=False, initCrc=0xFFFF, xorOut=0x0000)
        xstr = hex(self.cmd["adr"])[2:].zfill(4)
        xstr = xstr + hex(self.cmd["data"])[2:].rstrip("L").zfill(4 * self.cmd["len"])
        checksum16 = int(hex(crc16(bytearray.fromhex(xstr)))[2:], 16)

        return checksum16

    def burst_crc16_check(self):
        checksum16 = self.burst_crc16_calc()
        if self.cmd["crc16"] == checksum16:
            self.cmd["ok"] = True
        else:
            self.cmd["ok"] = False
