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

slisvg_eflist := $(shell ls slisvg*.ef)
slisvg_filebase := $(basename $(notdir $(slisvg_eflist)))
slisvg_f90list := $(addsuffix .F90,   $(slisvg_filebase))
slisvg_modlist := $(addsuffix _m.mod, $(slisvg_filebase))
slisvg_objlist := $(addsuffix .o,     $(slisvg_filebase))
slisvg_basename := slisvg
slisvg_lib := lib$(slisvg_basename).a

# ES3_HOME = /S/home00/G4013/y0394

.SECONDARY: $(f90list)  # to avoid deleting F90 files.
       # .SECONDARY: obj/%.F90 does not work (GNU Make 3.81).


.PHONY: install clean

EFPP = ../bin/efpp.py
FC = gfortran
FLAGS := -O3
FFLAGS += -fopenmp
#> FFLAGS += -fcheck=all
#> FFLAGS += -Wall
#> FFLAGS += -fbounds-check
#> FFLAGS += -fcheck-array-temporaries
#> FFLAGS += -Wuninitialized
#> FFLAGS += -ffpe-trap=invalid,zero,overflow
#> FFLAGS += -g
#> FFLAGS += -fbacktrace

%.F90: %.ef
	$(EFPP) $< > $@

%.o: %.F90
	$(FC) $(FFLAGS) -o $@ -c $<

install: $(slisvg_lib)
	mkdir -p ../lib
	cp $(slisvg_lib) slisvg*.mod ../lib

$(slisvg_lib): $(slisvg_objlist) 
	ar r $(slisvg_lib) $(slisvg_objlist) 


-include depend_list.mk


depend_list.mk: *.ef
	../bin/gendep.sh > $@ 


clean:
	rm -f depend_list.mk
	rm -f *.o *.lst *.F90 *.mod *.L 
	rm -f $(slisvg_lib)

