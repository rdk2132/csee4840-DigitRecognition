#ifndef PARAMETER_H
#define PARAMETER_H

#ifdef __KERNEL__
#include <linux/ioctl.h>
#include <linux/limits.h>
#else
#include <limits.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#endif

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
#define FIXED_SCALE_LOG 4
#define FIXED_SCALE (1 << FIXED_SCALE_LOG)
#define FIXED_MIN (fixed_t)(SHRT_MIN)

typedef struct {
  fixed_t in_image[IMAGE_SIZE];
  fixed_t classification_vector[NUM_CLASSES];
} cnn_arg_t;

#define CNN_IO_FILE "/dev/cnn"
#define CNN_DRIVER_MAGIC 'q'
#define CNN_CLASSIFY _IOWR(CNN_DRIVER_MAGIC, 1, cnn_arg_t*)
#endif
