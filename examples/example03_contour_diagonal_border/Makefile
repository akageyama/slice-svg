.PHONY: clean 
.SUFFIXES:

VIS2DLIB_NAME = vv  # <= libvv.a 
VIS2DLIB_DIR  = ../../lib
EFPP = ../../bin/efpp.py
FC = gfortran
FLIBS := -I$(VIS2DLIB_DIR) -L$(VIS2DLIB_DIR) -l$(VIS2DLIB_NAME)

sample = contour_diagonal_border
fig = $(sample).svg

$(fig): $(sample)
	./$(sample)

$(sample): $(sample).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90 $(FLIBS)
	$(FC) $(FFLAGS) -o $@ *.o $(FLIBS)

clean:
	rm -f core *.o *.mod *.L
	rm -f *.F90
	rm -f *.svg
	rm -f $(sample)
