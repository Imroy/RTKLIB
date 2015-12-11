# makefile for rnx2rtkp

BINDIR  = /usr/local/bin
SRC     = ../src

OPTS    = -DTRACE -DENAGLO -DENAQZS -DENAGAL -DNFREQ=3 -DNEXOBS=3

# for no lapack
CFLAGS  += -Wall -ansi -pedantic -Wno-unused-but-set-variable -g
LDLIBS  = -lm -lrt

#CFLAGS  += -Wall -ansi -pedantic -Wno-unused-but-set-variable -DLAPACK
#LDLIBS  = -lm -lrt -llapack -lblas

# for gprof
#CFLAGS  += -Wall -ansi -pedantic -Wno-unused-but-set-variable -DLAPACK -pg
#LDLIBS  = -lm -lrt -llapack -lblas -pg

# for mkl
#MKLDIR  = /opt/intel/mkl
#CFLAGS  += -ansi -pedantic -Wno-unused-but-set-variable -DMKL
#LDLIBS  = -L$(MKLDIR)/lib/intel64 -lm -lrt -lmkl_core -lmkl_intel_lp64 -lmkl_gnu_thread -liomp5 -lpthread

# Common objects for all programs
SRC_OBJS = $(patsubst %, $(SRC)/%.o, preceph rtcm rtcm2 rtcm3 rtcm3e rtkcmn sbas)
RCV_OBJS = $(patsubst %, $(SRC)/rcv/%.o, binex crescent gw10 javad novatel nvs\
	skytraq ss2 rt17 ublox)

# Objects for each program
CONVBIN_OBJS = $(patsubst %, $(SRC)/%.o, convrnx ephemeris ionex qzslex pntpos\
		rcvraw rinex)
POS2KML_OBJS = $(patsubst %, $(SRC)/%.o, convkml geoid solution)
RNX2RTKP_OBJS = $(patsubst %, $(SRC)/%.o, ephemeris geoid ionex lambda options\
		postpos ppp ppp_ar qzslex pntpos rinex rtkpos solution)
RTKRCV_OBJS = $(patsubst %, $(SRC)/%.o, ephemeris geoid ionex lambda options\
		ppp ppp_ar qzslex pntpos rcvraw rinex rtkpos rtksvr stream solution)
STR2STR_OBJS = $(patsubst %, $(SRC)/%.o, geoid rcvraw stream streamsvr solution)

PROGS = convbin/convbin pos2kml/pos2kml rnx2rtkp/rnx2rtkp rtkrcv/rtkrcv str2str/str2str

all : $(PROGS)

convbin/convbin   : convbin/convbin.o $(SRC_OBJS) $(CONVBIN_OBJS) $(RCV_OBJS)

pos2kml/pos2kml   : pos2kml/pos2kml.o $(SRC_OBJS) $(POS2KML_OBJS)

rnx2rtkp/rnx2rtkp : rnx2rtkp/rnx2rtkp.o $(SRC_OBJS) $(RNX2RTKP_OBJS)

rtkrcv/rtkrcv     : rtkrcv/rtkrcv.o $(SRC_OBJS) $(RTKRCV_OBJS) $(RCV_OBJS)
	$(CC) -o $@ $^ $(LDLIBS) -lpthread

str2str/str2str   : str2str/str2str.o $(SRC_OBJS) $(STR2STR_OBJS) $(RCV_OBJS)
	$(CC) -o $@ $^ $(LDLIBS) -lpthread

%.o   : %.c $(SRC)/rtklib.h
	$(CC) $(CFLAGS) -I$(SRC) $(OPTS) -o $@ -c $<

clean :
	rm -fv $(SRC_OBJS) $(CONVBIN_OBJS) $(POS2KML_OBJS) $(RNX2RTKP_OBJS) $(RTKRCV_OBJS) $(STR2STR_OBJS)
	rm -fv $(RCV_OBJS)
	rm -fv $(patsubst %,%.o, $(PROGS)) $(PROGS)
	rm -fv convbin/*.obs convbin/*.nav convbin/*.gnav convbin/*.hnav convbin/*.qnav convbin/*.sbs convbin/*.stackdump
	rm -fv rnx2rtkp/*.pos rnx2rtkp/*.pos.stat rnx2rtkp/*.trace
	rm -fv rtkrcv/*.out rtkrcv/*.trace
	rm -fv str2str/*.trace str2str/*.out

# Should be run as root e.g with sudo
install :
	install -t $(BINDIR) $(PROGS)

test: test_convbin test_rnx2rtkp test_str2str

test_convbin:
	convbin/test.sh

test_rnx2rtkp:
	rnx2rtkp/test.sh

# program hangs?
test_rtkrcv:
	rtkrcv/test.sh

test_str2str:
	str2str/test.sh

depend:
	touch .depend
	makedepend -f .depend -I $(SRC) $(SRC)/*.c $(SRC)/rcv/*.c convbin/*.c pos2kml/*.c rnx2rtkp/*.c rtkrcv/*.c str2str/*.c 2> /dev/null

ifneq ($(wildcard .depend),)
include .depend
endif
