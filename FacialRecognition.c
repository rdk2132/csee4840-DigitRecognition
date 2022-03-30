#include <stdio.h>
#include <stdlib.h>
#include "Layers.h"
#include "Parameters.h"
#include "Pool.h"

void classify(unsigned char* in_image) {
  //We should have enough stack space for this on Linux, might just use malloc otherwise.
  //TODO: Some layers assume that their outputs are zeroed out. Make sure that layers are changed so they zero them out.
  float* in_matrix [IMAGE_SIZE];
  float conv1_out [NUM_KERNELS * CONV1_OUT_SIZE];
  float pool1_out [NUM_KERNELS * CONV1_OUT_SIZE / POOL_SIZE / POOL_SIZE];
  float conv2_out [NUM_KERNELS * CONV2_OUT_SIZE];
  float pool2_out [NUM_KERNELS * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE];
  float classification_vector[NUM_CLASSES];
  for (int i = 0; i < IMAGE_SIZE; i++) {
    in_matrix[i] = in_image[i];
  }

  conv_layer(in_matrix, conv1_out, float *bias, float *weights, int num_src, int num_dst, IMAGE_WIDTH);
  avg_pool(conv1_out, pool1_out, NUM_KERNELS * CONV0_OUT_SIZE, CONV0_OUT_WIDTH);
  conv_layer(pool1_out, conv2_out, float *bias, float *weights, int num_src, int num_dst, int src_size);
  avg_pool(conv2_out, pool2_out, NUM_KERNELS * CONV2_OUT_SIZE, int src_row_size);
  fully_connected(pool2_out, classification_vector, float *bias, float *weights, int src_size, NUM_CLASSES);

  for (int i = 0; i < NUM_CLASSES; i++) {
    printf("Class %d probability: %f\n", i, classification_vector[i]);
  }
}

int main() {
    return 0;
}
