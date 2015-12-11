#!/bin/sh

cd `dirname $0`

#DEVICE=ttyACM0
DEVICE=ttyS1:115200:8:n:1:off
#DEVICE=ttyUSB0:115200:8:n:1:off

echo 1
./str2str -in serial://${DEVICE} -out file://test1.out -t 2 || exit

echo 2
./str2str -in serial://${DEVICE} -out tcpsvr://:2102\
 -c ../../data/oem4_raw_10hz.cmd -t 5 || exit

echo 3
./str2str -in serial://${DEVICE} -out ntrips://:sesam@localhost:8000/BUCU0\
 -c ../../data/oem4_raw_10hz.cmd -t 5 || exit

echo 4
./str2str -in '../oem6_20121107.gps#nov' -out 'oem6_20121107.rtcm3#rtcm3'\
 -sta 123 -msg "1077(10),1087(10),1097(10),1107(10),1117(10),1019,1020" || exit

echo 5
./str2str -in '../oem6_20121107.gps#nov' -out 'oem6_20121107_gal.rtcm3#rtcm3'\
 -msg "1097(10)" || exit

echo 6
./str2str -in 'serial://ttyS54:115200#nov' -out 'tcpsvr://:2103#rtcm3'\
 -c ../../data/oem4_raw_10hz.cmd || exit

echo Okay