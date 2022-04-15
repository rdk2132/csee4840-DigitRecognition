#ifndef _FULLY_CONNECTED_H
#define  _FULLY_CONNECTED_H

#include "math.h"

/*
* src: the 1-d flattened array of all image features
* dst: the array neurons in the next layer for which we are calculating
* weights: the weights of each connection (if the previous layer is 
size 192 and the next layer is 10 this weight vector is of length 1920)
* bias: the bias of each neuron in the next layer (for a size 10 fully connected
layer this is of size 10)
*/

void fully_connected(fixed_t *src, fixed_t *dst, const fixed_t *weights, int src_size, int dst_size)
{
    //TODO: Make the number of in images a parameter instead of a magic number
    //TODO: Need to transform order of the input data as the weights expect a different order.
    //TODO: might be somewhat inaccurate due to float type
    for (int dest_index = 0; dest_index < (dst_size); dest_index++) {
      for (int image = 0; image < 12; image++) {
        for (int pos = 0; pos < src_size / 12; pos++) {
          dst[dest_index] += ((weights[(pos * (12) + image) * dst_size + dest_index] * src[image * (src_size / 12) + pos]) >> FIXED_SCALE_LOG);
        }
      }
    }

    //Bias, sigmoid not needed on FPGA. We don't use bias, sigmoid is optional and may
    //be done in software for prettier classification values in console output.
}

#endif
