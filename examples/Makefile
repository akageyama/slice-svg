
.PHONY: clean 

.SUFFIXES:

EFPP = ../bin/efpp.py

VIS2DLIB_NAME = vv  # <= libvv.a 
VIS2DLIB_DIR  = ../lib

FLIBS := -I$(VIS2DLIB_DIR) -L$(VIS2DLIB_DIR) -l$(VIS2DLIB_NAME)

this_host = default
this_host := $(shell hostname | cut -c1-3)

ifeq ($(this_host),default)  # Default
        EFPP = ../bin/efpp.py
        FC = gfortran
        FFLAGS := 
        # FFLAGS += -fopenmp
        FFLAGS += -fcheck=all
        FFLAGS += -Wall
        FFLAGS += -fbounds-check
        FFLAGS += -fcheck-array-temporaries
        FFLAGS += -O0
        FFLAGS += -Wuninitialized
        FFLAGS += -ffpe-trap=invalid,zero,overflow
        FFLAGS += -g
        FFLAGS += -fbacktrace
endif
ifeq ($(this_host),alf)  # Alfven
        EFPP = ../bin/efpp.py2
        FC = mpinfort
        FFLAGS = 
endif
ifeq ($(this_host),pif)  # Pi-computer
        EFPP = ../bin/efpp.py
        FC = gfortran
	FC = mpifc
	FC = mpif90
	FC = mpiifort
        FC = ifort
        FFLAGS = -xAVX
        FFLAGS = -O0
        FFLAGS += -check all -traceback -debug
endif
ifeq ($(this_host),mac)  # Mac
        EFPP = ../bin/efpp.py
        FC = gfortran
        FFLAGS = -O0 -Wuninitialized -ffpe-trap=invalid,zero,overflow -fbacktrace 
        FFLAGS += -fbounds-check
        FFLAGS += -fcheck=array-temps,bounds,do,mem,pointer,recursion
        FFLAGS += -Wall
endif
ifeq ($(this_host),ofp)  # Oakforest PACS
        EFPP = ../bin/efpp.py
        FC = mpiifort
        FFLAGS := -O3
        FFLAGS += -qopenmp
        FFLAGS += -axMIC-AVX512
        FFLAGS += -fpe0
        FFLAGS += -ftrapuv
        FFLAGS += -align array64byte
        FFLAGS += -qopt-threads-per-core=1
        #FFLAGS += -CB  # check bounds
        #FFLAGS += -check all
        #FFLAGS += -warn all
        #FFLAGS += -traceback
endif
ifeq ($(this_host),fes)  # NIFS
        EFPP = ../bin/efpp.py2
        FC = mpifrtpx
        FFLAGS := -Kopenmp
        # FFLAGS += -X03 -Free -NRtrap -Qt -Koptmsg=2
        # FFLAGS += -Haefosux
        # FFLAGS += -g
        # FFLAGS += -Nquickdbg=argchk
        # FFLAGS += -Nquickdbg=subchk
endif
ifeq ($(HOME),$(ES3_HOME)) # JAMSTEC
        EFPP = ../../../bin/efpp.py2
        #EFPP = ../bin/efpp.py2
        FC = sxmpif03 # at cg-mhd, must sxmpif03, not sxmpif90
        #FC = sxmpif90 # at yyz-relax, must sxmpif90, not sxmpif03
        FFLAGS := -P openmp
        FFLAGS += -ftrace
        FFLAGS += -R transform fmtlist
        FFLAGS += -pvctl fullmsg
         #FFLAGS += -R2
         #FFLAGS += -Wf"-pvctl fullmsg"
         #FFLAGS += -eR
endif

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
	$(FC) $(FFLAGS) -c $@.F90 $(FLIBS)
	$(FC) $(FFLAGS) -o $@ *.o $(FLIBS)

$(example02): $(example02).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90 $(FLIBS)
	$(FC) $(FFLAGS) -o $@ *.o $(FLIBS)

$(example03): $(example03).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90 $(FLIBS)
	$(FC) $(FFLAGS) -o $@ *.o $(FLIBS)

$(example04): $(example04).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90 $(FLIBS)
	$(FC) $(FFLAGS) -o $@ *.o $(FLIBS)

$(example05): $(example05).ef
	rm -f *.o
	$(EFPP) $@.ef > $@.F90
	$(FC) $(FFLAGS) -c $@.F90 $(FLIBS)
	$(FC) $(FFLAGS) -o $@ *.o $(FLIBS)

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
