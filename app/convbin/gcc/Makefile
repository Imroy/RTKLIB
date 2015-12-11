#
# makefile for convbin
#

BINDIR = /usr/local/bin

SRC    = ../../../src

INCLUDE= -I$(SRC)
OPTIONS= -DTRACE -DENAGLO -DENAQZS -DENAGAL -DENACMP -DNFREQ=6 -DNEXOBS=3

CFLAGS += -ansi -pedantic -Wall -Wno-unused-but-set-variable $(INCLUDE) $(OPTIONS) -g

LDLIBS = -lm -lrt

SRC_OBJS = rtkcmn.o rinex.o sbas.o preceph.o rcvraw.o convrnx.o\
	rtcm.o rtcm2.o rtcm3.o rtcm3e.o pntpos.o ephemeris.o ionex.o qzslex.o
RCV_OBJS = novatel.o ss2.o ublox.o crescent.o skytraq.o gw10.o javad.o nvs.o\
	binex.o rt17.o

all  : convbin

convbin : convbin.o $(SRC_OBJS) $(RCV_OBJS)

convbin.o  : ../convbin.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) ../convbin.c

%.o   : $(SRC)/%.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) $<

%.o   : $(SRC)/rcv/%.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) $<

DATDIR = ../../../test/data/rcvraw

install:
	cp convbin $(BINDIR)

clean:
	rm -f convbin *.o *.obs *.nav *.gnav *.hnav *.qnav *.sbs *.stackdump

test : test1 test2 test3 test4 test5 test7 test8 test9 test10 test11 test12 test13
test : test14 test15

test1:
	./convbin -r nov $(DATDIR)/oemv_200911218.gps -ti 10 -d . -os
test2:
	./convbin -r hemis $(DATDIR)/cres_20080526.bin -ti 10 -d . -f 1 -od -os
test3:
	./convbin $(DATDIR)/ubx_20080526.ubx -o ubx_test.obs -d . -f 1 -ts 2008/5/26 6:00 -te 2008/5/26 6:10
test4:
	./convbin $(DATDIR)/ubx_20080526.ubx -n ubx_test.nav -d .
test5:
	./convbin $(DATDIR)/ubx_20080526.ubx -h ubx_test.hnav -s ubx_test.sbs -d . -x 129
test7:
	./convbin $(DATDIR)/testglo.rtcm2 -tr 2009/12/18 23:20 -d .
test8:
	./convbin $(DATDIR)/testglo.rtcm3 -os -tr 2009/12/18 23:20 -d .
test9:
	./convbin -v 3 -f 6 -r nov $(DATDIR)/oemv_200911218.gps -od -os -o rnx3_test.obs -n rnx3_test.nav -d .
test10:
	./convbin $(DATDIR)/testglo.rtcm3 -os -tr 2009/12/18 23:20 -d .
test11:
	./convbin $(DATDIR)/javad_20110115.jps -d out -c JAV1
test12:
	./convbin $(DATDIR)/javad_20110115.jps -d out -v 3.00 -f 3 -od -os
test13:
	./convbin $(DATDIR)/javad_20110115.jps -d out -o test13.obs -v 3 -hc test1 -hc test2 -hm MARKER -hn MARKERNO -ht MARKKERTYPE -ho OBSERVER/AGENCY -hr 1234/RECEIVER/V.0.1.2 -ha ANTNO/ANTENNA -hp 1234.567/8901.234/5678.901 -hd 0.123/0.234/0.567
test14:
	./convbin $(DATDIR)/javad_20110115.jps -d out -o test14.obs -v 3 -y S -y J -x 2 -x R19 -x R21
test15:
	./convbin $(DATDIR)/javad_20110115.jps -d out -o test15.obs -v 3 -ro "-GL1P -GL2C"
test16:
	./convbin $(DATDIR)/javad_20110115.jps -d out -o test15.obs -v 3 -ro "-GL1P -GL2C"
test17:
	./convbin $(DATDIR)/GMSD7_20121014.rtcm3 -tr 2012/10/14 0:00:00
test18:
	./convbin $(DATDIR)/GMSD7_20121014.rtcm3 -scan -v 3.01 -f 6 -od -os -tr 2012/10/14 0:00:00
test21:
	stty raw < /dev/ttyACM0
	./convbin -r ubx -o ubx.obs -n ubx.nav -s ubx.sbs -h ubx.hnav /dev/ttyACM0
