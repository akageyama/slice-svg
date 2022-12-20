#!/bin/sh

../bin/efpp.py color_test.ef > color_test.F90
../bin/efpp.py color.ef > color.F90
gfortran color_test.F90 color.F90 && ./a.out
