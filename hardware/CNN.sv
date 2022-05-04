module CNN();

//image memory. They are redundant to allow for 4 accesses
img_mem img_mem_0();
img_mem img_mem_1();

//Conv1 output image 0. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_0_0();
conv1_mem conv1_mem_0_1();
conv1_mem conv1_mem_0_2();
conv1_mem conv1_mem_0_3();
//Conv1 output image 1. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_1_0();
conv1_mem conv1_mem_1_1();
conv1_mem conv1_mem_1_2();
conv1_mem conv1_mem_1_3();
//Conv1 output image 2. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_2_0();
conv1_mem conv1_mem_2_1();
conv1_mem conv1_mem_2_2();
conv1_mem conv1_mem_2_3();
//Conv1 output image 3. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_3_0();
conv1_mem conv1_mem_3_1();
conv1_mem conv1_mem_3_2();
conv1_mem conv1_mem_3_3();
//Conv1 output image 4. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_4_0();
conv1_mem conv1_mem_4_1();
conv1_mem conv1_mem_4_2();
conv1_mem conv1_mem_4_3();
//Conv1 output image 5. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_5_0();
conv1_mem conv1_mem_5_1();
conv1_mem conv1_mem_5_2();
conv1_mem conv1_mem_5_3();

//Memories for conv1 kernels. Each holds 2 25x25 kernels.
conv1_k_g0_mem conv1_k_g0_mem();
conv1_k_g1_mem conv1_k_g1_mem();
conv1_k_g2_mem conv1_k_g2_mem();

//Memories for the 6 outputs of p1. Each is unique
p1_mem p1_mem_0();
p1_mem p1_mem_1();
p1_mem p1_mem_2();
p1_mem p1_mem_3();
p1_mem p1_mem_4();
p1_mem p1_mem_5();

//Conv2 output 0. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_0_0();
conv2_mem conv2_mem_0_1();
//Conv2 output 1. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_1_0();
conv2_mem conv2_mem_1_1();
//Conv2 output 2. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_2_0();
conv2_mem conv2_mem_2_1();
//Conv2 output 3. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_3_0();
conv2_mem conv2_mem_3_1();
//Conv2 output 4. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_4_0();
conv2_mem conv2_mem_4_1();
//Conv2 output 5. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_5_0();
conv2_mem conv2_mem_5_1();
//Conv2 output 6. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_6_0();
conv2_mem conv2_mem_6_1();
//Conv2 output 7. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_7_0();
conv2_mem conv2_mem_7_1();
//Conv2 output 8. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_8_0();
conv2_mem conv2_mem_8_1();
//Conv2 output 9. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_9_0();
conv2_mem conv2_mem_9_1();
//Conv2 output 10. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_10_0();
conv2_mem conv2_mem_10_1();
//Conv2 output 11. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_11_0();
conv2_mem conv2_mem_11_1();

//Memories for conv2 kernels. Each holds 6 25x25 kernels.
conv2_k_g0_mem conv2_k_g0_mem();
conv2_k_g1_mem conv2_k_g1_mem();
conv2_k_g2_mem conv2_k_g2_mem();
conv2_k_g3_mem conv2_k_g3_mem();
conv2_k_g4_mem conv2_k_g4_mem();
conv2_k_g5_mem conv2_k_g5_mem();
conv2_k_g6_mem conv2_k_g6_mem();
conv2_k_g7_mem conv2_k_g7_mem();
conv2_k_g8_mem conv2_k_g8_mem();
conv2_k_g9_mem conv2_k_g9_mem();
conv2_k_g10_mem conv2_k_g10_mem();
conv2_k_g11_mem conv2_k_g011mem();

//Memories for the 12 outputs of p2. Each is unique
p_2_mem p_2_mem_0();
p_2_mem p_2_mem_1();
p_2_mem p_2_mem_2();
p_2_mem p_2_mem_3();
p_2_mem p_2_mem_4();
p_2_mem p_2_mem_5();
p_2_mem p_2_mem_6();
p_2_mem p_2_mem_7();
p_2_mem p_2_mem_8();
p_2_mem p_2_mem_9();
p_2_mem p_2_mem_10();
p_2_mem p_2_mem_11();

//Memories for FC weights. Each holds 2 neurons's 192 weights(384 in total)
fc_g0_mem fc_g0_mem();
fc_g1_mem fc_g1_mem();
fc_g2_mem fc_g2_mem();
fc_g3_mem fc_g3_mem();
fc_g4_mem fc_g4_mem();

endmodule