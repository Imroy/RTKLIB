#!/bin/sh

cd `dirname $0`

echo 1
./rtkrcv -t 4 -m 52001 -t 4

echo 2
./rtkrcv -p 2105 -m 52001 || exit

#echo 3
#./rtkrcv -o rtk_pb.conf || exit

echo Okay