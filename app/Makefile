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
SRC_OBJS = preceph.o rtcm.o rtcm2.o rtcm3.o rtcm3e.o rtkcmn.o sbas.o
RCV_OBJS = binex.o crescent.o gw10.o javad.o novatel.o nvs.o\
	skytraq.o ss2.o rt17.o ublox.o

# Objects for each program
CONVBIN_OBJS = convrnx.o ephemeris.o ionex.o qzslex.o pntpos.o rcvraw.o rinex.o
POS2KML_OBJS = convkml.o geoid.o solution.o
RNX2RTKP_OBJS = ephemeris.o geoid.o ionex.o lambda.o options.o postpos.o ppp.o ppp_ar.o qzslex.o pntpos.o rinex.o rtkpos.o solution.o
RTKRCV_OBJS = ephemeris.o geoid.o ionex.o lambda.o options.o ppp.o ppp_ar.o qzslex.o pntpos.o rcvraw.o rinex.o rtkpos.o rtksvr.o stream.o solution.o
STR2STR_OBJS = geoid.o rcvraw.o stream.o streamsvr.o solution.o

PROGS = convbin/convbin pos2kml/pos2kml rnx2rtkp/rnx2rtkp rtkrcv/rtkrcv str2str/str2str

all : $(PROGS)

convbin/convbin   : convbin/convbin.o $(patsubst %.o,$(SRC)/%.o, $(SRC_OBJS) $(CONVBIN_OBJS)) $(patsubst %.o,$(SRC)/rcv/%.o, $(RCV_OBJS))

pos2kml/pos2kml   : pos2kml/pos2kml.o $(patsubst %.o,$(SRC)/%.o, $(SRC_OBJS) $(POS2KML_OBJS))

rnx2rtkp/rnx2rtkp : rnx2rtkp/rnx2rtkp.o $(patsubst %.o,$(SRC)/%.o, $(SRC_OBJS) $(RNX2RTKP_OBJS))

rtkrcv/rtkrcv     : rtkrcv/rtkrcv.o $(patsubst %.o,$(SRC)/%.o, $(SRC_OBJS) $(RTKRCV_OBJS)) $(patsubst %.o,$(SRC)/rcv/%.o, $(RCV_OBJS))
	$(CC) -o $@ $^ $(LDLIBS) -lpthread

str2str/str2str   : str2str/str2str.o $(patsubst %.o,$(SRC)/%.o, $(SRC_OBJS) $(STR2STR_OBJS)) $(patsubst %.o,$(SRC)/rcv/%.o, $(RCV_OBJS))
	$(CC) -o $@ $^ $(LDLIBS) -lpthread

%.o   : %.c $(SRC)/rtklib.h
	$(CC) $(CFLAGS) -I$(SRC) $(OPTS) -o $@ -c $<

clean :
	rm -fv $(patsubst %.o,$(SRC)/%.o, $(SRC_OBJS) $(CONVBIN_OBJS) $(POS2KML_OBJS) $(RNX2RTKP_OBJS) $(RTKRCV_OBJS) $(STR2STR_OBJS))
	rm -fv $(patsubst %.o,$(SRC)/rcv/%.o, $(RCV_OBJS))
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
