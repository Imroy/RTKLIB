#!/bin/sh

cd `dirname $0`

INPUT11="../../test/data/rinex/07590920.05o ../../test/data/rinex/30400920.05n"
INPUT12="../../test/data/rinex/30400920.05o"
OPTS1="-r -3978241.958 3382840.234 3649900.853"

echo 1
./rnx2rtkp ${INPUT11} -x 5 -o test1.pos || exit

echo 2
./rnx2rtkp -t -e ${OPTS1} ${INPUT11} > test2.pos || exit

echo 3
./rnx2rtkp -t -p 1 -e ${OPTS1} ${INPUT11} ${INPUT12} > test3.pos || exit

echo 4
./rnx2rtkp -t -p 3 -e ${OPTS1} ${INPUT11} ${INPUT12} > test4.pos || exit

echo 5
./rnx2rtkp -t -m 15 -e ${OPTS1} ${INPUT11} ${INPUT12} > test5.pos || exit

echo 6
./rnx2rtkp -t -f 1 -e ${OPTS1} ${INPUT11} ${INPUT12} > test6.pos || exit

echo 7
./rnx2rtkp -t -v 5 -e ${OPTS1} ${INPUT11} ${INPUT12} > test7.pos || exit

echo 8
./rnx2rtkp -t -i -e ${OPTS1} ${INPUT11} ${INPUT12} > test8.pos || exit

echo 9
./rnx2rtkp -t -p 0 ${OPTS1} ${INPUT11} > test9.pos || exit

echo 10
./rnx2rtkp -t -p 0 ${OPTS1} ${INPUT11} -o test10.pos || exit

echo 11
./rnx2rtkp -t -p 0 -n ${OPTS1} ${INPUT11} > test11.pos || exit

echo 12
./rnx2rtkp -t -p 0 -g ${OPTS1} ${INPUT11} > test12.pos || exit

echo 13
./rnx2rtkp -t -p 0 ${OPTS1} ${INPUT11} > test13.pos || exit

echo 14
./rnx2rtkp -t -p 0 -u ${OPTS1} ${INPUT11} > test14.pos || exit

echo 15
./rnx2rtkp -t -p 0 -d 9 ${OPTS1} ${INPUT11} > test15.pos || exit

echo 16
./rnx2rtkp -t -p 0 -s , ${OPTS1} ${INPUT11} > test16.pos || exit

echo 17
./rnx2rtkp -t -b -e ${OPTS1} ${INPUT11} ${INPUT12} > test17.pos || exit

echo 18
./rnx2rtkp -t -c -e ${OPTS1} ${INPUT11} ${INPUT12} > test18.pos || exit

echo 19
./rnx2rtkp -t -h -e ${OPTS1} ${INPUT11} ${INPUT12} > test19.pos || exit

echo 20
./rnx2rtkp -t -p 4 -a ${OPTS1} ${INPUT11} ${INPUT12} > test20.pos || exit

echo 21
./rnx2rtkp ${INPUT11} ${INPUT12} > test21.pos || exit

echo 22
./rnx2rtkp -k opts1.conf ${INPUT11} ${INPUT12} > test22.pos || exit

echo 23
./rnx2rtkp -k opts2.conf ${INPUT11} ${INPUT12} > test23.pos || exit

echo 24
./rnx2rtkp -k opts3.conf ${INPUT11} ${INPUT12} -y 2 -o test24.pos || exit

echo 25
./rnx2rtkp -k opts4.conf ${INPUT11} ${INPUT12} -y 2 -o test25.pos || exit

echo Okay