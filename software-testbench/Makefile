CC = g++
CXX = g++
INCLUDES =
#TODO add back -DUSE_FPGA
CFLAGS = -g -std=gnu++11 -W -Wall $(INCLUDES)
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
