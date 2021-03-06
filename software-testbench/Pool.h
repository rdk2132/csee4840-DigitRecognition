#ifndef POOL_H
#define POOL_H
#include <string.h>
#include "Parameters.h"

//max pooling and fixed point support are not needed at this time.
#if 0
//TODO: Maybe we'll switch to just integers, but plan with fixed point for
//now. This header will need to define the fixed point type and some
//functions. Otherwise just use int or perhaps unsigned char types.
#include "FixedPoint.h"

//Implement 2x2 pooling for now – different pooling or adding padding is
//not difficult to do
#define POOL_SIZE 2

//TODO: Consider https://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax for branchless max operation in hardware

//This will compile and work correctly as long as fixed_t is an alias for
//an integer type
#define MAX(a, b) (a > b ? a : b)
//TODO: Is pooling 3D or just some of the other layers? Switch to
//fixed_t** in that case and add outer loop for layers
//TODO: Could return the output if memory allocation is allowed in
//here, handle it elsewhere for now.
void max_pool(fixed_t* in, fixed_t* out) {
  //DATA_WIDTH_POOL needs to be defined in Parameters.h
  const int out_width = DATA_WIDTH_POOL / POOL_SIZE;

  for (int i = 0; i < out_width; i++) {
    for (int j = 0; j < out_width; j++) {
      //TODO: If there are negative values we may need to adjust this
      //and the max operation.
      fixed_t max = 0;
      //Helps de-clutter the in array access
      int start_idx = POOL_SIZE * (i * DATA_WIDTH_POOL + j);
      for (int k = 0; k < POOL_SIZE; k++) {
        for (int l = 0; l < POOL_SIZE; l++) {
          max = MAX(max, in[start_idx + k * DATA_WIDTH_POOL + l]);
        }
      }
      out[i * out_width + j] = max;
    }
  }
  //Could alternatively do this, which is simpler but would be slow
  //with a non po2 pool size due to division.
  /*memset(out, 0, out_width * out_width * sizeof(fixed_t));
  for (int i = 0; i < DATA_WIDTH_POOL; i++) {
    for (int j = 0; j < DATA_WIDTH_POOL; j++) {
      out[(i / DATA_WIDTH_POOL) * out_width + (j / DATA_WIDTH_POOL)] =
        MAX(out[(i / DATA_WIDTH_POOL) * out_width + (j / DATA_WIDTH_POOL)],         in[i * DATA_WIDTH_POOL + j]);
    }
  }*/
}

//TODO: Could also develop a struct based interface instead where
//parameters are passed to struct, e.g.
//Pool layer4(3);
//...
//fixed_t* pooled_data = layer4.process(relu_data);
#endif

#define POOL_SIZE 2

//Need src_row_size to know where to read information from consecutive rows. Number of channels is not needed
void avg_pool(fixed_t* in, fixed_t* out, int src_size, int src_row_size) {
  for (int i = 0; i < src_size / src_row_size / POOL_SIZE; i++) {
    for (int j = 0; j < src_row_size / POOL_SIZE; j++) {
      fixed_t sum = 0;
      for (int k = 0; k < POOL_SIZE; k++) {
        for (int l = 0; l < POOL_SIZE; l++) {
          sum += in[(i * POOL_SIZE + k) * (src_row_size) + j * POOL_SIZE + l];
          if (in[(i * POOL_SIZE + k) * (src_row_size) + j * POOL_SIZE + l] > 0) {
            //fprintf(stderr, "pool %d %d: %d\n", i * (src_row_size / POOL_SIZE) + j, (i * POOL_SIZE + k) * (src_row_size) + j * POOL_SIZE + l, in[(i * POOL_SIZE + k) * (src_row_size) + j * POOL_SIZE + l]);
          }
        }
      }
      out[i * (src_row_size / POOL_SIZE) + j] = sum / POOL_SIZE / POOL_SIZE;
    }
  }
}

#endif

