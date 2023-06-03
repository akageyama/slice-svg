#
# Makefile for turtle-svg
#
#     2018.05.30: Start coding.
#

.SUFFIXES:

eflist := $(shell ls *.ef)   # e.g., example.eef
filebase := $(basename $(notdir $(eflist))) # => example
f90list := $(addsuffix .F90, $(filebase)) # => example.F90
modlist := $(addsuffix .mod, $(filebase)) # => example.mod
objlist := $(addsuffix .o, $(filebase)) # => example.o

vv_eflist := $(shell ls vv*.ef)
vv_filebase := $(basename $(notdir $(vv_eflist)))
vv_f90list := $(addsuffix .F90,   $(vv_filebase))
vv_modlist := $(addsuffix _m.mod, $(vv_filebase))
vv_objlist := $(addsuffix .o,     $(vv_filebase))
vv_basename := vv
vv_lib := lib$(vv_basename).a

# ES3_HOME = /S/home00/G4013/y0394

.SECONDARY: $(f90list)  # to avoid deleting F90 files.
       # .SECONDARY: obj/%.F90 does not work (GNU Make 3.81).


.PHONY: install clean

EFPP = ../bin/efpp.py
FC = gfortran
FFLAGS := -O5
#> # FFLAGS += -fopenmp
#> FFLAGS += -fcheck=all
#> FFLAGS += -Wall
#> FFLAGS += -fbounds-check
#> FFLAGS += -fcheck-array-temporaries
#> FFLAGS += -O0
#> FFLAGS += -Wuninitialized
#> FFLAGS += -ffpe-trap=invalid,zero,overflow
#> FFLAGS += -g
#> FFLAGS += -fbacktrace

%.F90: %.ef
	$(EFPP) $< > $@

%.o: %.F90
	$(FC) $(FFLAGS) -o $@ -c $<

install: $(vv_lib)
	mkdir -p ../lib
	cp $(vv_lib) vv*.mod ../lib

$(vv_lib): $(vv_objlist) 
	ar r $(vv_lib) $(vv_objlist) 


-include depend_list.mk


depend_list.mk: *.ef
	../bin/gendep.sh > $@ 


clean:
	rm -f depend_list.mk
	rm -f *.o *.lst *.F90 *.mod *.L 
	rm -f $(vv_lib)

