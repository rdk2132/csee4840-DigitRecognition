CC = gcc
CXX = g++
INCLUDES =
CFLAGS = -g -Wall $(INCLUDES)
CXXFLAGS = -g -Wall $(INCLUDES)


.PHONY: default
default: FacialRecognition

FacialRecognition: Layers.o

FacialRecognition.o: Layers.h

Layers.o: Layers.h

.PHONY: clean
clean:
	rm -rf *.o *~ FacialRecognition a.out


.PHONY: all
all: clean default