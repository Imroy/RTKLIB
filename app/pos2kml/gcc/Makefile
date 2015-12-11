# makefile for pos2kml

BINDIR = /usr/local/bin
SRC    = ../../../src
CFLAGS += -Wall -ansi -pedantic -I$(SRC) -DTRACE
LDLIBS  = -lm -lrt

SRC_OBJS = convkml.o solution.o geoid.o rtkcmn.o preceph.o

ps2kml : pos2kml.o $(SRC_OBJS)

pos2kml.o  : ../pos2kml.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) ../pos2kml.c

%.o  : $(SRC)/%.c $(SRC)/rtklib.h
	$(CC) -c $(CFLAGS) $<

install:
	cp pos2kml $(BINDIR)

clean:
	rm -f pos2kml pos2kml.exe *.o
