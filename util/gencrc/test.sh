#!/bin/sh

cd `dirname $0`

echo 1
./gencrc -16 > crc16.c || exit

echo 2
./gencrc -24 > crc24.c || exit

echo 3
./genxor > xor.c || exit

echo 4
./genmsk > msk.c || exit

echo Okay