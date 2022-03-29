#ifndef _FULLY_CONNECTED_H
#define  _FULLY_CONNECTED_H

#define MAX(a, b) (a > b ? a : b)
/*
* src: the 1-d flattened array of all image features
* dst: the array neurons in the next layer for which we are calculating
* weights: the weights of each connection (if the previous layer is 
size 192 and the next layer is 10 this weight vector is of length 1920)
* bias: the bias of each neuron in the next layer (for a size 10 fully connected
layer this is of size 10)
*/


void fully_connected(float *src, float *dst, float *bias, float *weights, int src_size, int dst_size)
{
    for (int src_index = 0; src_index < (src_size); src_index++) { // calculate the neuron vals w/o bias
        for (int dest_index = 0; dest_index < (dst_size); dest_index++) {
            dst[dest_index] += weights[(src_index * dst_size) + dest_index] * src[src_index];
        }
    }

    //add in the bias and apply the activation function
    // will use relu here but could use sigmoid

    for (int dst_index = 0; dst_index < (dst_size); dst_index++) {
        dst[dst_index] = MAX(0, dst[dst_index] + bias[dst_index]);
    }
}

#endif
