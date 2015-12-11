# makefile for str2str

BINDIR = /usr/local/bin
SRC    = ../../../src

# for beagleboard
#CTARGET= -mfpu=neon -mfloat-abi=softfp -ffast-math
CTARGET=

OPTION = -DENAGLO -DENAGAL -DENAQZS -DENACMP -DTRACE -DNFREQ=3 -DNEXOBS=3
CFLAGS += -Wall -ansi -pedantic -Wno-unused-but-set-variable -I$(SRC) $(OPTION) $(CTARGET) -g
LDLIBS  = -lm -lrt -lpthread

all        : str2str

SRC_OBJS = stream.o rtkcmn.o solution.o sbas.o geoid.o\
	rcvraw.o rtcm.o rtcm2.o rtcm3.o rtcm3e.o preceph.o streamsvr.o
RCV_OBJS = novatel.o ublox.o ss2.o crescent.o skytraq.o gw10.o javad.o\
	nvs.o binex.o rt17.o

str2str: str2str.o $(SRC_OBJS) $(RCV_OBJS)

str2str.o  : ../str2str.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) ../str2str.c

%.o   : $(SRC)/%.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) $<

%.o   : $(SRC)/rcv/%.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) $<

install:
	cp str2str $(BINDIR)

#DEVICE=ttyACM0
DEVICE=ttyS1:115200:8:n:1:off
#DEVICE=ttyUSB0:115200:8:n:1:off

test1:
	./str2str -in serial://$(DEVICE) -out file://test1.out -t 2

test2:
	./str2str -in serial://$(DEVICE) -out tcpsvr://:2102 -c ../../../data/oem4_raw_10hz.cmd -t 5

test3:
	./str2str -in serial://$(DEVICE) -out ntrips://:sesam@localhost:8000/BUCU0 -c ../../../data/oem4_raw_10hz.cmd -t 5

test4:
	./str2str -in ../oem6_20121107.gps#nov -out oem6_20121107.rtcm3#rtcm3 -sta 123 -msg "1077(10),1087(10),1097(10),1107(10),1117(10),1019,1020"

test5:
	./str2str -in ../oem6_20121107.gps#nov -out oem6_20121107_gal.rtcm3#rtcm3 -msg "1097(10)"

test6:
	./str2str -in serial://ttyS54:115200#nov -out tcpsvr://:2103#rtcm3 -c ../../../data/oem4_raw_10hz.cmd

clean:
	rm -f str2str *.o *.out *.trace

