
.PHONY: clean 

.SUFFIXES:

EFPP = ../bin/efpp.py

VIS2DLIB_NAME = vv  # <= libvv.a 
VIS2DLIB_DIR  = /Users/kage/VCS/GitHub/slice-svg/lib

FC = gfortran
FFLAGS := -I$(VIS2DLIB_DIR) -L$(VIS2DLIB_DIR) -l$(VIS2DLIB_NAME)
# FFLAGS += -fopenmp
FFLAGS += -fcheck=all
FFLAGS += -Wall
FFLAGS += -fbounds-check
FFLAGS += -fcheck-array-temporaries
FFLAGS += -O0
# FFLAGS += -Wuninitialized

example01_contour_fullbox: example01_contour_fullbox.ef ut.o 
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -o $@ constants.o ut.o $@.F90
	./$@

example02_contour_dashed: example02_contour_dashed.ef ut.o 
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -o $@ constants.o ut.o $@.F90
	./$@

constants.o: constants.ef
	$(EFPP) constants.ef > constants.F90
	$(FC) $(FFLAGS) -c constants.F90

ut.o: ut.ef constants.o
	$(EFPP) ut.ef > ut.F90
	$(FC) $(FFLAGS) -c ut.F90

line:
	@echo "="{1..100} | sed 's/[ 0-9]//g' # bash one-liner for a line

clean:
	rm -f smoke_ring core *.svg *.o *.mod *.L
	rm -rf *.F90
	rm -rf example01_contour_fullbox
	rm -rf example02_contour_dashed
