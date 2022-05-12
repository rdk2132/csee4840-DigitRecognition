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
    FILE* f_pointers[5];
      for (int i = 0; i < 5; i++) {
        std::string fname = "fc_g" + std::to_string(i) + ".txt";
        f_pointers[i] = fopen(fname.c_str(), "wb");
      }


      for (unsigned file = 0; file < 5; file++) {
        //first go through
        for (int k = 0; k < 2; k++) {
          unsigned out_class = file * 2 + k;
          for (int in_image = 0; in_image < 12; in_image++) {
            for (unsigned i = 0; i < 16; i++) {
              unsigned location = (i * (12) + in_image) * dst_size + out_class;
              unsigned short value;
              memcpy(&value, &weights[location], 2);
              fprintf(f_pointers[file], "%04x\n", value);
            }
          }
        }
      }
      for (int i = 0; i < 5; i++) {
        fclose(f_pointers[i]);
      }




    //TODO: Make the number of in images a parameter instead of a magic number
    //TODO: Need to transform order of the input data as the weights expect a different order.
    //TODO: might be somewhat inaccurate due to float type
    for (int dest_index = 0; dest_index < (dst_size); dest_index++) {
      for (int i = 0; i < 12 * 16; i++) {
      }
      for (int image = 0; image < 12; image++) {
        for (int pos = 0; pos < src_size / 12; pos++) {
          if (image == 0) {
            fprintf(stderr, "weight %d %d: %d\n", dest_index, pos, weights[(pos * (12) + image) * dst_size + dest_index]);
            //fprintf(stderr, "%d: w %d val %d\n", image * (src_size / 12) + pos, weights[(pos * (12) + image) * dst_size + dest_index], src[image * (src_size / 12) + pos]);
          }
          dst[dest_index] += ((weights[(pos * (12) + image) * dst_size + dest_index] * src[image * (src_size / 12) + pos]) >> FIXED_SCALE_LOG);
        }
      }
    }

    //Bias, sigmoid not needed on FPGA. We don't use bias, sigmoid is optional and may
    //be done in software for prettier classification values in console output.
}

#endif
