###################################################
# Aaron Fienberg
#
# read or write an fpga register

from wdc_zedboard import wdcZedboard, read_dev_path
import sys


def print_register_map():
    print("FPGA register map:")

    for key, value in wdcZedboard.fpga_adrs.items():
        try:
            value = hex(value)
        except TypeError:
            value = repr([hex(v) for v in value]).replace("'", "")

        print(f"{key} : {value}")


def main():
    if len(sys.argv) == 1:
        print_register_map()
        return 0

    adr = sys.argv[1]

    if len(sys.argv) >= 3:
        data = sys.argv[2]
    else:
        data = None

    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    if data is not None:
        zed.fpga_write(adr, data)

    print(hex(zed.fpga_read(adr)))


if __name__ == "__main__":
    main()
