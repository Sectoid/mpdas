VERSION = 0.3.0

CXX	?= g++
OBJ	= main.o md5.o utils.o mpd.o audioscrobbler.o cache.o config.o
OUT	= mpdas
PREFIX ?= /usr/local
MANPREFIX ?= ${PREFIX}/man/man1
CONFIG ?= $(PREFIX)/etc
DESTDIR ?=

CXXFLAGS	+= `pkg-config --cflags libmpd libcurl` 
LIBS		= `pkg-config --libs libmpd libcurl`

CXXFLAGS	+= -DCONFDIR="\"$(CONFIG)\"" -DVERSION="\"$(VERSION)\""


all: $(OUT)

.cpp.o:
	@echo [CXX] $<
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

$(OUT): $(OBJ)
	@echo [LD] $@
	@$(CXX) $(LDFLAGS) $(OBJ) $(LIBS) -o $(OUT)

clean:
	rm -rf $(OBJ) $(OUT)

install: all
	install -D mpdas $(DESTDIR)${PREFIX}/bin/mpdas
	install -D -m 644 mpdas.1 $(DESTDIR)${MANPREFIX}/mpdas.1
	install -D -m 644 mpdasrc.example $(DESTDIR)${CONFIG}/mpdasrc

uninstall:
	-rm ${PREFIX}/bin/mpdas
	-rm ${MANPREFIX}/mpdas.1
	-rm ${CONFIG}/mpdasrc
