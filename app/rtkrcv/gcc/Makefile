# makefile for rtkrcv

BINDIR = /usr/local/bin
SRC    = ../../../src

# for beagleboard
#CTARGET= -mfpu=neon -mfloat-abi=softfp -ffast-math
CTARGET= -DENAGLO -DENAGAL -DENAQZS -DNFREQ=3

CFLAGS += -Wall -ansi -pedantic -Wno-unused-but-set-variable -I$(SRC) -DTRACE $(CTARGET) -g
LDLIBS  = -lm -lrt -lpthread

all        : rtkrcv

SRC_OBJS = rtkcmn.o rtksvr.o rtkpos.o geoid.o solution.o lambda.o\
	sbas.o stream.o rcvraw.o rtcm.o preceph.o options.o pntpos.o ppp.o ppp_ar.o\
	ephemeris.o rinex.o rtcm2.o rtcm3.o rtcm3e.o ionex.o qzslex.o
RCV_OBJS = novatel.o ublox.o ss2.o crescent.o skytraq.o gw10.o javad.o nvs.o binex.o\
	rt17.o

rtkrcv: rtkrcv.o $(SRC_OBJS) $(RCV_OBJS)

rtkrcv.o   : ../rtkrcv.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) ../rtkrcv.c

%.o   : $(SRC)/%.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) $<

%.o   : $(SRC)/rcv/%.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) $<

install:
	cp rtkrcv $(BINDIR)

test1:
	./rtkrcv -t 4 -m 52001 -t 4

test2:
	./rtkrcv -p 2105 -m 52001

test3:
	./rtkrcv -o ../rtk_pb.conf

clean:
	rm -f rtkrcv rtkrcv.nav *.o *.out *.trace

