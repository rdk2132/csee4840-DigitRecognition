/*
 * Tester for device driver for cnn
 */

#include "../software-testbench/Parameters.h"
#include <stdio.h>

int cnn_fd;



int main()
{
    cnn_arg_t cnn_data;
    static const char filename[] = "/dev/cnn_fpga";
    static const fixed_t image[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    

    printf("Starting device driver test\n");

    if ((cnn_fd = open(filename, O_RDWR)) == -1) {
        fprintf(stderr, "Could not open %s\n", filename);
        return -1;
    }

    return 0;
}
