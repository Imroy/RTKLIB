BINDIR  = /usr/local/bin

OPTS    = -DTRACE -DENAGLO -DENAQZS -DENAGAL -DNFREQ=3 -DNEXOBS=3 -DMAXOBS=128

# for no lapack
CFLAGS  += -Wall -ansi -pedantic -Wno-unused-but-set-variable -g
F77FLAGS += -ffixed-line-length-132
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
SRC_OBJS = $(patsubst %, src/%.o, preceph rtcm rtcm2 rtcm3 rtcm3e rtkcmn sbas)
RCV_OBJS = $(patsubst %, src/rcv/%.o, binex crescent gw10 javad novatel nvs\
	skytraq ss2 rt17 ublox sirf)

# Objects for each program
CONVBIN_OBJS = $(patsubst %, src/%.o, convrnx ephemeris ionex qzslex pntpos\
		rcvraw rinex)
POS2KML_OBJS = $(patsubst %, src/%.o, convkml geoid solution)
RNX2RTKP_OBJS = $(patsubst %, src/%.o, ephemeris geoid ionex lambda options\
		postpos ppp ppp_ar qzslex pntpos rinex rtkpos solution)
RTKRCV_OBJS = $(patsubst %, src/%.o, ephemeris geoid ionex lambda options\
		ppp ppp_ar qzslex pntpos rcvraw rinex rtkpos rtksvr stream solution)
STR2STR_OBJS = $(patsubst %, src/%.o, geoid rcvraw stream streamsvr solution)
GENSTEC_OBJS = $(patsubst %, src/%.o, rtkcmn ephemeris rinex)
RNX2RTCM_OBJS = $(patsubst %, src/%.o, rinex)
SIMOBS_OBJS = $(patsubst %, src/%.o, rinex rtkcmn)

PROGS = app/convbin/convbin app/pos2kml/pos2kml app/rnx2rtkp/rnx2rtkp\
	app/rtkrcv/rtkrcv app/str2str/str2str util/rnx2rtcm/rnx2rtcm\
	util/gencrc/gencrc util/gencrc/genxor util/gencrc/genmsk\
	util/geniono/genstec util/simobs/simobs

all : $(PROGS)

app/convbin/convbin   : app/convbin/convbin.o $(SRC_OBJS) $(CONVBIN_OBJS) $(RCV_OBJS)

app/pos2kml/pos2kml   : app/pos2kml/pos2kml.o $(SRC_OBJS) $(POS2KML_OBJS)

app/rnx2rtkp/rnx2rtkp : app/rnx2rtkp/rnx2rtkp.o $(SRC_OBJS) $(RNX2RTKP_OBJS)

app/rtkrcv/rtkrcv     : app/rtkrcv/rtkrcv.o $(SRC_OBJS) $(RTKRCV_OBJS) $(RCV_OBJS)
	$(CC) -o $@ $^ $(LDLIBS) -lpthread

app/str2str/str2str   : app/str2str/str2str.o $(SRC_OBJS) $(STR2STR_OBJS) $(RCV_OBJS)
	$(CC) -o $@ $^ $(LDLIBS) -lpthread

util/rnx2rtcm/rnx2rtcm : util/rnx2rtcm/rnx2rtcm.o $(SRC_OBJS) $(RNX2RTCM_OBJS)
	$(CC) -o $@ $^ -lm

util/gencrc/gencrc : util/gencrc/gencrc.o
	$(CC) -o $@ $^ -lm

util/gencrc/genxor : util/gencrc/genxor.o
	$(CC) -o $@ $^ -lm

util/gencrc/genmsk : util/gencrc/genmsk.o
	$(CC) -o $@ $^ -lm

util/geniono/genstec : util/geniono/genstec.o
	$(CC) -o $@ $^ -lm

util/simobs/simobs : util/simobs/simobs.o $(SRC_OBJS) $(SIMOBS_OBJS)
	$(CC) -o $@ $^ -lm

%.o   : %.c src/rtklib.h
	$(CC) $(CFLAGS) -Isrc $(OPTS) -o $@ -c $<

clean :
	rm -fv $(SRC_OBJS) $(CONVBIN_OBJS) $(POS2KML_OBJS) $(RNX2RTKP_OBJS) $(RTKRCV_OBJS) $(STR2STR_OBJS)
	rm -fv $(RCV_OBJS)
	rm -fv $(patsubst %,%.o, $(PROGS)) $(PROGS)
	rm -fv app/convbin/*.obs app/convbin/*.nav app/convbin/*.gnav app/convbin/*.hnav app/convbin/*.qnav app/convbin/*.sbs app/convbin/*.stackdump
	rm -fv app/rnx2rtkp/*.pos app/rnx2rtkp/*.pos.stat app/rnx2rtkp/*.trace
	rm -fv app/rtkrcv/*.out app/rtkrcv/*.trace
	rm -fv app/str2str/*.trace app/str2str/*.out
	rm -fv util/gencrc/crc16.c util/gencrc/crc24.c util/gencrc/xor.c util/gencrc/msk.c
	rm -fv util/rnx2rtcm/*.trace

# Should be run as root e.g with sudo
install :
	install -t $(BINDIR) $(PROGS)

test: test_convbin test_rnx2rtkp test_str2str test_gencrc test_rnx2rtcm test_simobs

test_convbin:
	app/convbin/test.sh

test_rnx2rtkp:
	app/rnx2rtkp/test.sh

# program hangs?
test_rtkrcv:
	app/rtkrcv/test.sh

test_str2str:
	app/str2str/test.sh

test_gencrc:
	util/gencrc/test.sh

test_geniono:
	util/geniono/test.sh

test_rnx2rtcm:
	util/rnx2rtcm/test.sh

test_simobs:
	util/simobs/test.sh

depend:
	touch .depend
	makedepend -f .depend -I src src/*.c src/rcv/*.c app/convbin/*.c app/pos2kml/*.c app/rnx2rtkp/*.c app/rtkrcv/*.c app/str2str/*.c 2> /dev/null

ifneq ($(wildcard .depend),)
include .depend
endif
