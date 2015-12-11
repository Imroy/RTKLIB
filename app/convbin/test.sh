#!/bin/sh

cd `dirname $0`

DATADIR=../../test/data/rcvraw
#DEVICE=ttyACM0
DEVICE=ttyS1:115200:8:n:1:off
#DEVICE=ttyUSB0:115200:8:n:1:off

echo 1
./convbin -r nov ${DATADIR}/oemv_200911218.gps -ti 10 -d . -os || exit

echo 2
./convbin -r hemis ${DATADIR}/cres_20080526.bin -ti 10 -d . -f 1 -od -os || exit

echo 3
./convbin ${DATADIR}/ubx_20080526.ubx -o ubx_test.obs -d . -f 1 -ts 2008/5/26 6:00 -te 2008/5/26 6:10 || exit

echo 4
./convbin ${DATADIR}/ubx_20080526.ubx -n ubx_test.nav -d . || exit

echo 5
./convbin ${DATADIR}/ubx_20080526.ubx -h ubx_test.hnav -s ubx_test.sbs -d . -x 129 || exit

echo 7
./convbin ${DATADIR}/testglo.rtcm2 -tr 2009/12/18 23:20 -d . || exit

echo 8
./convbin ${DATADIR}/testglo.rtcm3 -os -tr 2009/12/18 23:20 -d . || exit

echo 9
./convbin -v 3 -f 6 -r nov ${DATADIR}/oemv_200911218.gps -od -os -o rnx3_test.obs -n rnx3_test.nav -d . || exit

echo 10
./convbin ${DATADIR}/testglo.rtcm3 -os -tr 2009/12/18 23:20 -d . || exit

echo 11
./convbin ${DATADIR}/javad_20110115.jps -d out -c JAV1 || exit

echo 12
./convbin ${DATADIR}/javad_20110115.jps -d out -v 3.00 -f 3 -od -os || exit

echo 13
./convbin ${DATADIR}/javad_20110115.jps -d out -o convbin_test13.obs -v 3 -hc convbin_test1 -hc convbin_test2 -hm MARKER -hn MARKERNO -ht MARKKERTYPE -ho OBSERVER/AGENCY -hr 1234/RECEIVER/V.0.1.2 -ha ANTNO/ANTENNA -hp 1234.567/8901.234/5678.901 -hd 0.123/0.234/0.567 || exit

echo 14
./convbin ${DATADIR}/javad_20110115.jps -d out -o convbin_test14.obs -v 3 -y S -y J -x 2 -x R19 -x R21 || exit

echo 15
./convbin ${DATADIR}/javad_20110115.jps -d out -o convbin_test15.obs -v 3 -ro "-GL1P -GL2C" || exit

echo 16
./convbin ${DATADIR}/javad_20110115.jps -d out -o convbin_test15.obs -v 3 -ro "-GL1P -GL2C" || exit

echo 17
./convbin ${DATADIR}/GMSD7_20121014.rtcm3 -tr 2012/10/14 0:00:00 || exit

echo 18
./convbin ${DATADIR}/GMSD7_20121014.rtcm3 -scan -v 3.01 -f 6 -od -os -tr 2012/10/14 0:00:00 || exit

echo 21
stty raw < $DEVICE || exit
./convbin -r ubx -o ubx.obs -n ubx.nav -s ubx.sbs -h ubx.hnav $DEVICE || exit

echo Okay