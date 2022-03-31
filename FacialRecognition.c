#include <stdio.h>
#include <stdlib.h>
#include "Layers.h"
#include "Parameters.h"
#include "Pool.h"
#include "convolution.h"
#include "fully_connected.h"

struct weights {
  float conv1_weights[NUM_KERNELS_1 * CONV_KERNEL_SIZE];
  float conv1_bias[NUM_KERNELS_1];
  float conv2_weights[NUM_KERNELS_2 * CONV_KERNEL_SIZE];
  float conv2_bias[NUM_KERNELS_2 * NUM_KERNELS_1 * CONV_KERNEL_SIZE];
  float fc_weights[NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE * NUM_CLASSES];
};

void classify(unsigned char* in_image, struct weights* w) {
  //We should have enough stack space for this on Linux, might just use malloc otherwise.
  //TODO: Is the order of weights in here the same as in keras?
  //TODO: Add code to load weights, input image
  //Some layers assume that their outputs are zeroed out, so do that here.
  float in_matrix [IMAGE_SIZE];
  float conv1_out [NUM_KERNELS_1 * CONV1_OUT_SIZE] = {0};
  float pool1_out [NUM_KERNELS_1 * CONV1_OUT_SIZE / POOL_SIZE / POOL_SIZE] = {0};
  float conv2_out [NUM_KERNELS_2 * CONV2_OUT_SIZE] = {0};
  float pool2_out [NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE] = {0};
  float classification_vector[NUM_CLASSES] = {0};
  for (int i = 0; i < IMAGE_SIZE; i++) {
    in_matrix[i] = in_image[i];
  }
  //not using bias for fc layer
  float fc_bias [NUM_CLASSES] = {0};

  conv_layer(in_matrix, conv1_out, w->conv1_bias, w->conv1_weights, 1, NUM_KERNELS_1, IMAGE_WIDTH);
  avg_pool(conv1_out, pool1_out, NUM_KERNELS_1 * CONV1_OUT_SIZE, CONV1_OUT_WIDTH);
  conv_layer(pool1_out, conv2_out, w->conv2_bias, w->conv2_weights, NUM_KERNELS_1, NUM_KERNELS_2, CONV1_OUT_WIDTH / 2);
  avg_pool(conv2_out, pool2_out, NUM_KERNELS_2 * CONV2_OUT_SIZE, CONV2_OUT_WIDTH);
  fully_connected(pool2_out, classification_vector, fc_bias, w->fc_weights, NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE, NUM_CLASSES);

  for (int i = 0; i < NUM_CLASSES; i++) {
    printf("Class %d probability: %f\n", i, classification_vector[i]);
  }
}

int main() {
    return 0;
}
