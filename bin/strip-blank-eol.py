#!/usr/bin/env python3

import sys

argv = sys.argv
argc = len(argv)

if (argc != 2):
    print('Usage: {} filename'.format(argv[0]))
    quit()

fh = open(argv[1], "r")

for line in fh:
    print(line.rstrip())

fh.close()
