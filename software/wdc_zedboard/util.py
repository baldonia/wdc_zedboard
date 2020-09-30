# Utility functions for the wdcZedboard software
#
# Aaron Fienberg
# Aug 2019

import sys


def read_dev_path(filename):
    """reads the first line from "filename" and returns it"""
    with open(filename) as file:
        return file.readline().strip()


def get_port(args, default_filename="conf/uart_path.txt"):
    """ Determine a uart port from command line arguments """
    if args.COM != None:
        port = "COM" + str(args.COM)
    elif args.ttyUSB != None:
        port = "/dev/ttyUSB" + str(args.ttyUSB)
    elif args.ttyS != None:
        port = "/dev/ttyS" + str(args.ttyS)
    else:
        port = read_dev_path(default_filename)

    return port


def main():
    print(read_dev_path(sys.argv[1]))


if __name__ == "__main__":
    sys.exit(main())
