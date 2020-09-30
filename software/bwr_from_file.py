###################################################
# Aaron Fienberg
#
# burst write to xdom

import sys
import time
from wdc_zedboard import wdcZedboard, read_dev_path


def read_file(file_name):
    h_data_wrds = []
    with open(file_name) as f:
        for line in f:
            word = line.strip()
            if len(word) > 4:
                raise RuntimeError(f"word {word} is invalid")
            int_word = int(word, 16)
            h_data_wrds.append(word.zfill(4))

    return "".join(h_data_wrds)


def main():
    if len(sys.argv) < 3:
        print("Usage: bwr_from_file.py <start_adr> <file_name>")
        return 0

    start_adr = sys.argv[1]

    h_data = read_file(sys.argv[2])

    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    zed.fpga_burst_write(start_adr, h_data)

    time.sleep(0.001)

    n_to_read = len(h_data) // 4

    read_data = zed.fpga_read(start_adr, read_len=n_to_read)

    for word in read_data:
        print(f"0x{word:4x}")


if __name__ == "__main__":
    sys.exit(main())
