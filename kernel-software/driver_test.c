/*
 * Tester for device driver for cnn
 */

#include "../software-testbench/Parameters.h"
#include <stdio.h>
#include <string.h>

int cnn_fd;


void run_cnn(const fixed_t *image) {

  cnn_arg_t cnn_data;
  memcpy(&cnn_data, image, 25);

  if (ioctl(cnn_fd, CNN_CLASSIFY, cnn_data)) {
    perror("ioctl(CNN_CLASSIFY) failed");
    return;
  }
  
  for(int i = 0; i < NUM_CLASSES; i++)
    printf("output[%d]: %d\n", i, cnn_data.classification_vector[i]);
}

int main()
{
    static const char filename[] = "/dev/cnn_fpga";
    static const fixed_t image[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
               12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};
    

    printf("Starting device driver test\n");

    if ((cnn_fd = open(filename, O_RDWR)) == -1) {
        fprintf(stderr, "Could not open %s\n", filename);
        return -1;
    }

    run_cnn(image);

    return 0;
}
