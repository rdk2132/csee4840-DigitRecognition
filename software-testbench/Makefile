CC = gcc
CXX = g++
INCLUDES =
#TODO add back -DUSE_FPGA
CFLAGS = -g -std=c99 -W -Wall $(INCLUDES)
CXXFLAGS = -g -W -Wall $(INCLUDES)
LDFLAGS = -lm

.PHONY: default
default: FacialRecognition

FacialRecognition: FacialRecognition.o
	${CC} ${CFLAGS} FacialRecognition.o ${LDFLAGS} -o FacialRecognition

FacialRecognition.o: Parameters.h Pool.h fully_connected.h convolution.h


.PHONY: clean
clean:
	rm -rf *.o *~ FacialRecognition a.out


.PHONY: all
all: clean default
