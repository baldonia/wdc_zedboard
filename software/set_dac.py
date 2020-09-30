###################################################
# Aaron Fienberg
# Sep 2020
# set the DAC value for a given dac and channel
#
import argparse
from wdc_zedboard import wdcZedboard, read_dev_path


def main():
    parser = argparse.ArgumentParser(
        prog="set_dac", description="Set a DAC output channel"
    )
    parser.add_argument(
        "-d",
        "--dac_num",
        type=int,
        help="Which DAC to set",
        choices=[0, 1],
        required=True,
    )
    parser.add_argument(
        "-c",
        "--channel",
        type=str,
        help="Which channel to set",
        choices=["a", "b", "all"],
        required=True,
    )
    parser.add_argument(
        "-v", "--value", type=int, help="DAC value to set", required=True
    )

    # Setup arguments
    args = parser.parse_args()

    zed = wdcZedboard(dev_path=read_dev_path("./conf/uart_path.txt"))

    zed.set_dac(args.dac_num, args.channel, args.value)


if __name__ == "__main__":
    main()
