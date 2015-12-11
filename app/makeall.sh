#!/bin/bash
#
# make all cui applications by gcc
#

for prog in pos2kml str2str rnx2rtkp convbin rtkrcv
do
  echo $prog
  pushd `pwd`
  cd $prog/gcc
  make "$@" || exit
  popd
  echo
done
