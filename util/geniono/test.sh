#!/bin/sh

cd `dirname $0`

OBSDIR=/proj/data_gsi/2011
NAVDIR=/proj/data/2011
STA=0225

OBS=$(OBSDIR)/001/$(STA)0010.11o $(OBSDIR)/002/$(STA)0020.11o $(OBSDIR)/003/$(STA)0030.11o
NAV=$(NAVDIR)/001/brdc0010.11n $(NAVDIR)/002/brdc0020.11n $(NAVDIR)/003/brdc0030.11n

echo test1
./genstec ${OBS} ${NAV} -a igs05.atx -o iono_${STA}.stec || exit

echo test 2
./gengrid "stec/iono_*.stec" -d stec_grid || exit

echo Okay