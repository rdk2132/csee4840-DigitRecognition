CC = gcc
CXX = g++
INCLUDES =
CFLAGS = -g -std=c99 -Wall $(INCLUDES)
CXXFLAGS = -g -Wall $(INCLUDES)
LDFLAGS = -lm

.PHONY: default
default: FacialRecognition

FacialRecognition: Layers.o

FacialRecognition.o: Layers.h Pool.h fully_connected.h convolution.h

Layers.o: Layers.h

.PHONY: clean
clean:
	rm -rf *.o *~ FacialRecognition a.out


.PHONY: all
all: clean default
