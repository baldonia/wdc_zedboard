###################################################
# Aaron Fienberg
#
# read or write an adc register

from wdc_zedboard import wdcZedboard, read_dev_path
import sys


def print_register_map():
    print("ADC register map:")

    for key, value in wdcZedboard.adc_adrs.items():
        try:
            value = hex(value)
        except TypeError:
            value = repr([hex(v) for v in value]).replace("'", "")

        print(f"{key} : {value}")


def main():
    if len(sys.argv) == 1:
        print_register_map()
        return 0

    dig_num = int(sys.argv[1])

    adr = sys.argv[2]

    if len(sys.argv) >= 4:
        data = sys.argv[3]
    else:
        data = None

    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    if data is not None:
        zed.adc_write(dig_num, adr, data)

    print(hex(zed.adc_read(dig_num, adr)))


if __name__ == "__main__":
    main()
