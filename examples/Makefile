
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

contour01_in_full_box: contour01_in_full_box.ef
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -o $@ $@.F90
	./$@

line:
	@echo "="{1..100} | sed 's/[ 0-9]//g' # bash one-liner for a line

clean:
	rm -f smoke_ring core ${objlist} *.mod *.L
	rm -rf depend_list.mk
	rm -rf *.F90
	rm -rf ../data/vis2d
