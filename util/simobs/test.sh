#!/bin/sh

cd `dirname $0`

OPT0=-ts 2009/4/1 -te 2009/4/2 -ti 10
OPT1=../sim/brdc0910.09n ../sim/brdc0910.09g ../sim/brdc0910.09l
OPT2=-r 36.106114294 140.087190410 70.3010
OPT3=-r 36.103635125 140.086307150 69.7442
OPT4=-r 36.031339503 140.202443500 70.9029
OPT5=-r 36.263268936 140.174264100 94.2843

echo 1
./simobs $(OPT0) $(OPT1) $(OPT2) -o ../sim/base_20080509.obs || exit

echo 2
./simobs $(OPT0) $(OPT1) $(OPT3) -o ../sim/rov0_20080509.obs || exit

echo 3
./simobs $(OPT0) $(OPT1) $(OPT4) -o ../sim/rov1_20080509.obs || exit

echo 4
./simobs $(OPT0) $(OPT1) $(OPT5) -o ../sim/rov2_20080509.obs || exit

echo Okay