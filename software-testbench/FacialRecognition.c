#include <stdio.h>
#include <stdlib.h>
#include "Parameters.h"
#include "Pool.h"
#include "convolution.h"
#include "fully_connected.h"

struct weights {
  fixed_t conv1_weights[NUM_KERNELS_1 * CONV_KERNEL_SIZE];
  fixed_t conv1_bias[NUM_KERNELS_1];
  fixed_t conv2_weights[NUM_KERNELS_2 * CONV_KERNEL_SIZE];
  fixed_t conv2_bias[NUM_KERNELS_2 * NUM_KERNELS_1 * CONV_KERNEL_SIZE];
  fixed_t fc_weights[NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE * NUM_CLASSES];
};

unsigned classify(unsigned char* in_image, struct weights* w) {
  //We should have enough stack space for this on Linux, might just use malloc otherwise.
  //TODO: Is the order of weights in here the same as in keras?
  //TODO: Add code to load weights, input image
  //Some layers assume that their outputs are zeroed out, so do that here.
  fixed_t in_matrix [IMAGE_SIZE];
  fixed_t conv1_out [NUM_KERNELS_1 * CONV1_OUT_SIZE] = {0};
  fixed_t pool1_out [NUM_KERNELS_1 * CONV1_OUT_SIZE / POOL_SIZE / POOL_SIZE] = {0};
  fixed_t conv2_out [NUM_KERNELS_2 * CONV2_OUT_SIZE] = {0};
  fixed_t pool2_out [NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE] = {0};
  fixed_t classification_vector[NUM_CLASSES] = {0};

  for (int i = 0; i < IMAGE_SIZE; i++) {
    in_matrix[i] = ((fixed_t)in_image[i]) * FIXED_SCALE;
  }
  conv_layer(in_matrix, conv1_out, w->conv1_bias, w->conv1_weights, 1, NUM_KERNELS_1, IMAGE_WIDTH);
  avg_pool(conv1_out, pool1_out, NUM_KERNELS_1 * CONV1_OUT_SIZE, CONV1_OUT_WIDTH);
  conv_layer(pool1_out, conv2_out, w->conv2_bias, w->conv2_weights, NUM_KERNELS_1, NUM_KERNELS_2, CONV1_OUT_WIDTH / 2);
  avg_pool(conv2_out, pool2_out, NUM_KERNELS_2 * CONV2_OUT_SIZE, CONV2_OUT_WIDTH);
  fully_connected(pool2_out, classification_vector, w->fc_weights, NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE, NUM_CLASSES);

  fixed_t max = FIXED_MIN;
  unsigned max_index = 0;
  for (int i = 0; i < NUM_CLASSES; i++) {
    printf("Class %d probability: %.9g\n", i, 1 / (1 + exp(-1.0 * ((double)classification_vector[i]) / FIXED_SCALE)));
    if (classification_vector[i] > max) {
      max = classification_vector[i];
      max_index = i;
    }
  }
  printf("Classified as %u\n", max_index);
  return max_index;
}

void fill(const char* file, void* dst, unsigned size) {
  FILE* fp = fopen(file, "rb");
  if (!fp) {
    fprintf(stderr, "Could not read %s\n", file);
  }
  fread(dst, sizeof(float), size, fp);
  fclose(fp);
}

void fill_fixed(const char* file, fixed_t* dst, unsigned size) {
  FILE* fp = fopen(file, "rb");
  if (!fp) {
    fprintf(stderr, "Could not read %s\n", file);
  }
  float imm[size];
  fread(imm, sizeof(float), size, fp);
  fclose(fp);
  for (unsigned i = 0; i < size; i++) {
    dst[i] = (fixed_t)roundf(imm[i] * FIXED_SCALE);
  }
}

int main() {
  struct weights wt;
  fixed_t conv1_weights[CONV_KERNEL_SIZE * NUM_KERNELS_1];
  fixed_t conv2_weights[CONV_KERNEL_SIZE * NUM_KERNELS_1 * NUM_KERNELS_2];
  fill_fixed("../mnist/conv1_weights.bin", conv1_weights, NUM_KERNELS_1 * CONV_KERNEL_SIZE);
  fill_fixed("../mnist/conv1_bias.bin", wt.conv1_bias, NUM_KERNELS_1);
  fill_fixed("../mnist/conv2_weights.bin", conv2_weights, NUM_KERNELS_2 * NUM_KERNELS_1 * CONV_KERNEL_SIZE);
  fill_fixed("../mnist/conv2_bias.bin", wt.conv2_bias, NUM_KERNELS_2);
  fill_fixed("../mnist/fc_weights.bin", wt.fc_weights, NUM_KERNELS_2 * CONV2_OUT_SIZE / POOL_SIZE / POOL_SIZE * NUM_CLASSES);

  //need to transpose some weights, keras puts them in a order that's hard to work with
  for(int out = 0; out < NUM_KERNELS_1; out++) {
    for (int i = 0; i < CONV_KERNEL_SIZE; i++) {
      wt.conv1_weights[out * CONV_KERNEL_SIZE + i] = conv1_weights[(i * NUM_KERNELS_1) + out];
    }
  }
  for(int in = 0; in < NUM_KERNELS_1; in++) {
    for(int out = 0; out < NUM_KERNELS_2; out++) {
      for (int i = 0; i < CONV_KERNEL_SIZE; i++) {
        wt.conv2_weights[(in * NUM_KERNELS_2 + out) * CONV_KERNEL_SIZE + i] = conv2_weights[(i * NUM_KERNELS_2 * NUM_KERNELS_1) + in * NUM_KERNELS_2 + out];
      }
    }
  }

#define NUM_IMAGES 32
#define IMAGE_METADATA_OFFSET 16
#define LABEL_METADATA_OFFSET 8
  unsigned char in_image[IMAGE_SIZE * NUM_IMAGES + IMAGE_METADATA_OFFSET] = {0};
  unsigned char in_labels[NUM_IMAGES + LABEL_METADATA_OFFSET] = {0};
  fill("../mnist/t10k-images-idx3-ubyte", (void*)in_image, (NUM_IMAGES * IMAGE_SIZE + IMAGE_METADATA_OFFSET) / sizeof(float));
  fill("../mnist/t10k-labels-idx1-ubyte", (void*)in_labels, (NUM_IMAGES + LABEL_METADATA_OFFSET) / sizeof(float));
  unsigned correct_classifications = 0;
  for (int i = 0; i < NUM_IMAGES; i++) {
    unsigned prediction = classify(&(in_image[i * IMAGE_SIZE + IMAGE_METADATA_OFFSET]), &wt);
    printf("Actual label: %u\n", in_labels[i + LABEL_METADATA_OFFSET]);
    correct_classifications += (in_labels[i + LABEL_METADATA_OFFSET] == prediction);
  }
  fprintf(stderr, "Correct classifications: %u / %u\n", correct_classifications, NUM_IMAGES);
  return 0;
}