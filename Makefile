all: app

build/Makefile: seven-square.pro seven-square.qrc
	mkdir -p build
	(cd build && qmake -o Makefile ../seven-square.pro)

src/keymap-generated.h: src/keycodes.h
	./contributes/generate-keymap.sh

app: build/Makefile src/keymap-generated.h
	(cd build && make)

install:
	mkdir -p ${HOME}/local/DIR/sevensquare/usr/bin/
	cp -vf build/seven-square ${HOME}/local/DIR/sevensquare/usr/bin/
	cd ${HOME}/local/DIR/
	xstow sevensquare

clean:
	(cd build && make clean)
