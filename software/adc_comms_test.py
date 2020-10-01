###################################################
# Aaron Fienberg
#
# test of ADC serial comms

from wdc_zedboard import wdcZedboard, read_dev_path
import sys


def get_mod_pat(pat, dig_num):
    return pat if dig_num == 0 else (~pat) & 0xFF


def main():
    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    success = True
    for pat in 0x5A, 0xA5:

        for dig_num in 0, 1:
            print(f"Resetting dig {dig_num}")

            zed.sw_reset(dig_num=dig_num)

            mod_pat = get_mod_pat(pat, dig_num)

            print(f"Writing 0x{mod_pat:02x} to scratch reg of dig {dig_num}")
            zed.adc_write(dig_num=dig_num, adr=0x3F, data=mod_pat)

        for dig_num in 0, 1:
            mod_pat = get_mod_pat(pat, dig_num)

            read_back = zed.adc_read(dig_num=dig_num, adr=0x3F)

            print(f"read back: 0x{read_back:02x} from dig {dig_num}")

            success &= read_back == mod_pat

    if success:
        print("Success! Everything works")
    else:
        print("Failure. Something didn't work.")


if __name__ == "__main__":
    main()
