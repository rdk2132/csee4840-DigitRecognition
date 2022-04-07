#ifndef PARAMETER_H
#define PARAMETER_H
#include <limits.h>
#define FIXED_POINT_SIZE
#define IMAGE_WIDTH 28
#define IMAGE_SIZE (IMAGE_WIDTH * IMAGE_WIDTH)
#define POOL_SIZE 2
#define CONV_KERNEL_SIZE (5 * 5)

#define NUM_CLASSES 10
#define NUM_KERNELS_1 6
#define NUM_KERNELS_2 12
#define CONV1_OUT_WIDTH (IMAGE_WIDTH - 4)
#define CONV1_OUT_SIZE (CONV1_OUT_WIDTH * CONV1_OUT_WIDTH)
#define CONV2_OUT_WIDTH (CONV1_OUT_WIDTH / POOL_SIZE - 4)
#define CONV2_OUT_SIZE (CONV2_OUT_WIDTH * CONV2_OUT_WIDTH)

typedef short fixed_t;
#define FIXED_SCALE_LOG 5
#define FIXED_SCALE (1 << FIXED_SCALE_LOG)
#define FIXED_MIN (fixed_t)(SHRT_MIN)
#endif
