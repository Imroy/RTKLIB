#!/bin/sh

cd `dirname $0`

if [ -d out ]
then
  rm -f out/*
else
  mkdir out
fi

OPT1='inp/GMSD7_201210140.* -x 2'
OPT2='inp/javad1_201103010000.* -x 2'
OPT3='inp/brdc0600.11* inp/gras0600.11o -x 2'

echo 1
./rnx2rtcm ${OPT1} -typ 1002,1019,1033 -sta 111 -out out/rtcm_1002.rtcm3 || exit

echo 2
./rnx2rtcm ${OPT1} -typ 1004,1019,1033 -sta 222 -out out/rtcm_1004.rtcm3 || exit

echo 3
./rnx2rtcm ${OPT1} -typ 1010,1020,1033 -sta 333 -out out/rtcm_1010.rtcm3 || exit

echo 4
./rnx2rtcm ${OPT1} -typ 1012,1020,1033 -sta 444 -out out/rtcm_1012.rtcm3 || exit

echo 5
./rnx2rtcm ${OPT1} -typ 1044 -sta 555 -out out/rtcm_1044.rtcm3 || exit

echo 6
./rnx2rtcm ${OPT1} -typ 1074 -sta 666 -out out/rtcm_1074.rtcm3 || exit

echo 7
./rnx2rtcm ${OPT2} -typ 1074,1084,1094,1104,1114,1019,1020,1044,1045,1046 -sta 444 -out out/rtcm_1074_jav.rtcm3 || exit

echo 8
./rnx2rtcm ${OPT2} -typ 1075,1085,1095,1105,1115,1019,1020,1044,1045,1046 -sta 555 -out out/rtcm_1075_jav.rtcm3 || exit

echo 9
./rnx2rtcm ${OPT2} -typ 1076,1086,1096,1106,1116,1019,1020,1044,1045,1046 -sta 666 -out out/rtcm_1076_jav.rtcm3 || exit

echo 10
./rnx2rtcm ${OPT2} -typ 1077,1087,1097,1107,1117,1019,1020,1044,1045,1046 -sta 777 -out out/rtcm_1077_jav.rtcm3 || exit

echo 11
./rnx2rtcm ${OPT3} -typ 1077,1087,1019,1020 -sta 888 -out out/rtcm_1077_gras.rtcm3 || exit

rm -rf out

echo Okay