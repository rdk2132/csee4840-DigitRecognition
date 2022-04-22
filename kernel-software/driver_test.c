/*
 * Tester for device driver for cnn
 */

#include "/software-testbench/Parameters.h"

int cnn_fd;



int main()
{
    static const char filename[] = "/dev/cnn_fpga";

    printf("Starting device driver test\n");

    if ( cnn_fd = open(filename, O_RDWR) == -1) {
        fprintf(stderr, "Could not open %s\n", filename);
        return -1;
    }

}
