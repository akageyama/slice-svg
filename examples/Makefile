
.PHONY: clean 

.SUFFIXES:

EFPP = ../bin/efpp.py

VIS2DLIB_NAME = vv  # <= libvv.a 
VIS2DLIB_DIR  = /Users/kage/VCS/GitHub/slice-svg/lib

FC = gfortran
FFLAGS := -I$(VIS2DLIB_DIR) -L$(VIS2DLIB_DIR) -l$(VIS2DLIB_NAME)
FFLAGS += -fcheck=all
FFLAGS += -Wall
FFLAGS += -fbounds-check
FFLAGS += -fcheck-array-temporaries
FFLAGS += -Wuninitialized
FFLAGS += -O0

example01 = example01_contour_fullbox
example02 = example02_contour_dashed
example03 = example03_contour_triangle
example04 = example04_vector_arrows
example05 = example05_vector_arrows_animation

fig01 := $(example01).svg
fig02 := $(example02).svg
fig03 := $(example03).svg
fig04 := $(example04).svg
fig05 := $(example05).svg



figs: $(fig01) $(fig02) $(fig03) $(fig04) $(fig05)

$(fig01): $(example01)
	./$(example01)
$(fig02): $(example02)
	./$(example02)
$(fig03): $(example03)
	./$(example03)
$(fig04): $(example04)
	./$(example04)
$(fig05): $(example05)
	./$(example05)

$(example01): $(example01).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90
	$(FC) $(FFLAGS) -o $@ *.o

$(example02): $(example02).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90
	$(FC) $(FFLAGS) -o $@ *.o

$(example03): $(example03).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90
	$(FC) $(FFLAGS) -o $@ *.o

$(example04): $(example04).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90
	$(FC) $(FFLAGS) -o $@ *.o

$(example05): $(example05).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90
	$(FC) $(FFLAGS) -o $@ *.o

line:
	@echo "="{1..100} | sed 's/[ 0-9]//g' # bash one-liner for a line

clean:
	rm -f core *.o *.mod *.L
	rm -f *.F90
	rm -f *.svg
	rm -f $(example01)
	rm -f $(example02)
	rm -f $(example03)
	rm -f $(example04)
	rm -f $(example05)
