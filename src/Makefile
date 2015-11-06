CC=g++
LIBS=`pkg-config --cflags python-3.4`
LINK_LIBS=`pkg-config --libs python-3.4`
CPPFLAGS=$(LIBS) -Wall -Wextra -pedantic -ggdb -c -std=c++11 
DEP=interpolacion.o

all: tp

tp: tp.o $(DEP)
	$(CC) tp.o $(DEP) $(LINK_LIBS) -o tp

%.o: %.cpp
	$(CC) $(CPPFLAGS) $< -o $@

clean:
	rm -f *.o
	rm -f tp
