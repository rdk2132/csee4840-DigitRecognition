module CNN();

//image memory. They are redundant to allow for 4 accesses
img_mem img_mem_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
img_mem img_mem_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());

//Conv1 output image 0. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_0_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_0_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_0_2(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_0_3(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv1 output image 1. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_1_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_1_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_1_2(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_1_3(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv1 output image 2. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_2_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_2_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_2_2(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_2_3(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv1 output image 3. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_3_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_3_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_3_2(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_3_3(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv1 output image 4. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_4_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_4_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_4_2(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_4_3(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv1 output image 5. Each stores half of the image to allow for 8 accesses. _0 _1 and _2 _3 are redundant
conv1_mem conv1_mem_5_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_5_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_5_2(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv1_mem conv1_mem_5_3(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());

//Memories for conv1 kernels. Each holds 2 25x25 kernels.
conv1_k_g0_mem conv1_k_g0_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv1_k_g1_mem conv1_k_g1_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv1_k_g2_mem conv1_k_g2_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());

//Memories for the 6 outputs of p1. Each is unique
p1_mem p1_mem_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p1_mem p1_mem_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p1_mem p1_mem_2(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p1_mem p1_mem_3(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p1_mem p1_mem_4(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p1_mem p1_mem_5(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());

//Conv2 output 0. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_0_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_0_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 1. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_1_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_1_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 2. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_2_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_2_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 3. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_3_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_3_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 4. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_4_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_4_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 5. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_5_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_5_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 6. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_6_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_6_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 7. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_7_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_7_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 8. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_8_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_8_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 9. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_9_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_9_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 10. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_10_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_10_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
//Conv2 output 11. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_11_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
conv2_mem conv2_mem_11_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());

//Memories for conv2 kernels. Each holds 6 25x25 kernels.
conv2_k_g0_mem conv2_k_g0_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g1_mem conv2_k_g1_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g2_mem conv2_k_g2_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g3_mem conv2_k_g3_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g4_mem conv2_k_g4_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g5_mem conv2_k_g5_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g6_mem conv2_k_g6_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g7_mem conv2_k_g7_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g8_mem conv2_k_g8_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g9_mem conv2_k_g9_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g10_mem conv2_k_g10_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
conv2_k_g11_mem conv2_k_g011mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());

//Memories for the 12 outputs of p2. Each is unique
p_2_mem p_2_mem_0(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_1(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_2(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_3(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_4(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_5(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_6(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_7(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_8(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_9(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_10(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());
p_2_mem p_2_mem_11(.address_a(), .address_b(), .clock(clk), .data_a(), .data_b(), .rden_a(), .rden_b(), .wren_a(), .wren_b(), .q_a(), .q_b());

//Memories for FC weights. Each holds 2 neurons's 192 weights(384 in total)
fc_g0_mem fc_g0_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
fc_g1_mem fc_g1_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
fc_g2_mem fc_g2_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
fc_g3_mem fc_g3_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());
fc_g4_mem fc_g4_mem(.address_a(), .address_b(), .clock(clk), .rden_a(), .rden_b(), .q_a(), .q_b());

endmodule