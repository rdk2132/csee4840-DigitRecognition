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
  float classification_vector[NUM_CLASSES];
  //not using bias for fc layer
  float fc_bias [NUM_CLASSES];

  for (int i = 0; i < NUM_CLASSES; i++) {
    classification_vector[i] = 0.0;
    fc_bias[i] = 0.0;
  }
  for (int i = 0; i < IMAGE_SIZE; i++) {
    in_matrix[i] = in_image[i];
  }

  conv_layer(in_matrix, conv1_out, w->conv1_bias, w->conv1_weights, 1, NUM_KERNELS_1, IMAGE_WIDTH);
  avg_pool(conv1_out, pool1_out, NUM_KERNELS_1 * CONV1_OUT_SIZE, CONV1_OUT_WIDTH);
  conv_layer(pool1_out, conv2_out, w->conv2_bias, w->conv2_weights, NUM_KERNELS_1, NUM_KERNELS_2, CONV1_OUT_WIDTH / 2);
  avg_pool(conv2_out, pool2_out, NUM_KERNELS_2 * CONV2_OUT_SIZE, CONV2_OUT_WIDTH);
  fully_connected(pool2_out, classification_vector, fc_bias, w->fc_weights, NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE, NUM_CLASSES);

  float max = 0.0;
  unsigned max_index = 0;
  for (int i = 0; i < NUM_CLASSES; i++) {
    //printf("Class %d probability: %f\n", i, classification_vector[i]);
    if (classification_vector[i] > max) {
      max = classification_vector[i];
      max_index = i;
    }
  }
  printf("Classified as %u\n", max_index);
}

void fill(const char* file, float* dst, unsigned size) {
  FILE* fp = fopen(file, "rb");
  if (!fp) {
    fprintf(stderr, "Could not read %s\n", file);
  }
  fread(dst, sizeof(float), size, fp);
  fclose(fp);
}

int main() {
  struct weights wt;
  fill("conv1_weights.bin", wt.conv1_weights, NUM_KERNELS_1 * CONV_KERNEL_SIZE);
  fill("conv1_bias.bin", wt.conv1_bias, NUM_KERNELS_1);
  fill("conv2_weights.bin", wt.conv2_weights, NUM_KERNELS_2 * NUM_KERNELS_1 * CONV_KERNEL_SIZE);
  fill("conv2_bias.bin", wt.conv2_bias, NUM_KERNELS_2);
  fill("fc_weights.bin", wt.fc_weights, NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE * NUM_CLASSES);
#define NUM_IMAGES 32
#define IMAGE_METADATA_OFFSET 16
#define LABEL_METADATA_OFFSET 8
  unsigned char in_image[IMAGE_SIZE * NUM_IMAGES + IMAGE_METADATA_OFFSET] = {0};
  unsigned char in_labels[NUM_IMAGES + LABEL_METADATA_OFFSET] = {0};
  fill("t10k-images-idx3-ubyte", in_image, (NUM_IMAGES * IMAGE_SIZE + IMAGE_METADATA_OFFSET) / sizeof(float));
  fill("t10k-labels-idx1-ubyte", in_labels, (NUM_IMAGES + LABEL_METADATA_OFFSET) / sizeof(float));
  for (int i = 0; i < NUM_IMAGES; i++) {
    classify(&(in_image[i * IMAGE_SIZE + IMAGE_METADATA_OFFSET]), &wt);
    printf("Actual label: %u\n", in_labels[i + LABEL_METADATA_OFFSET]);
  }
  return 0;
}
