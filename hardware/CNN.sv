module CNN(input logic clk, reset, write, read, chipselect, 
           input logic [15:0] writedata, 
           input logic [3:0] address,
           output logic [15:0] readdata);

    logic signed [15:0] img_data;
    logic [9:0] img_mem_addr_write;
    logic [7:0] ctrl;
    always_ff @(posedge clk) begin
        if(chipselect == 1'b1 && (write == 1'b1 || read == 1'b1)) begin
            case (address)
                4'h0 : ctrl <= writedata[7:0];
                4'h1 : readdata <= {8'b00000000, return_ctrl};
                4'h2 : img_mem_addr_write <= writedata[9:0];
                4'h3 : img_data <= writedata;
                4'h4 : readdata <= result_0;
                4'h5 : readdata <= result_1;
                4'h6 : readdata <= result_2;
                4'h7 : readdata <= result_3;
                4'h8 : readdata <= result_4;
                4'h9 : readdata <= result_5;
                4'ha : readdata <= result_6;
                4'hb : readdata <= result_7;
                4'hc : readdata <= result_8;
                4'hd : readdata <= result_9;
                default : readdata <= 0;
            endcase
        end
    end

logic [1:0] MAC_layer;
logic [7:0] return_ctrl;
logic pooling_layer, img_load, rMAC, MAC_enable, Conv1_layer, P1_layer, Conv2_layer, P2_layer, FC_layer, 
      img_mem_read_reset, conv1_mem_write_reset, conv1_mem_read_reset, conv1_k_mem_read_reset, P1_mem_read_reset, P1_mem_write_reset, 
      conv2_mem_write_reset, conv2_mem_read_reset, conv2_k_mem_read_reset, P2_mem_write_reset, P2_mem_read_reset, fc_mem_read_reset, 
      img_mem_read_done, conv1_mem_write_done, conv1_mem_read_done, conv1_k_mem_read_done, P1_mem_read_done, P1_mem_write_done, 
      conv2_mem_write_done, conv2_mem_read_done, conv2_k_mem_read_done, P2_mem_write_done, P2_mem_read_done, fc_mem_read_done;

CNN_ctrl CNN_ctrl(.*);

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  IMAGE DATA MEMORY
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

logic signed [15:0] img_mem_0_q_a, img_mem_0_q_b, img_mem_1_q_a, img_mem_1_q_b;
logic [9:0] img_mem_addr0_read, img_mem_addr0, img_mem_addr1, img_mem_addr2_read, img_mem_addr2, img_mem_addr3;

img_mem_read img_mem_read(.clk(clk), .reset(img_mem_read_reset), .enable(Conv1_layer), .addr0(img_mem_addr0_read), .addr1(img_mem_addr1), .addr2(img_mem_addr2_read), .addr3(img_mem_addr3), .done(img_mem_read_done));
mux_2to1 #(10) img_mem_addr_mux_0(.data_in_0(img_mem_addr_write), .data_in_1(img_mem_addr0_read), .sel(Conv1_layer), .data_out(img_mem_addr0));
mux_2to1 #(10) img_mem_addr_mux_1(.data_in_0(img_mem_addr_write), .data_in_1(img_mem_addr2_read), .sel(Conv1_layer), .data_out(img_mem_addr2));

//image memory. They are redundant to allow for 4 accesses
img_mem img_mem_0(.address_a(img_mem_addr0), .address_b(img_mem_addr1), .clock(clk), .data_a(img_data), .data_b(16'b0000000000000000), .wren_a(img_load), .wren_b(1'b0), .q_a(img_mem_0_q_a), .q_b(img_mem_0_q_b));
img_mem img_mem_1(.address_a(img_mem_addr2), .address_b(img_mem_addr3), .clock(clk), .data_a(img_data), .data_b(16'b0000000000000000), .wren_a(img_load), .wren_b(1'b0), .q_a(img_mem_1_q_a), .q_b(img_mem_1_q_b));

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  CONV1 OUTPUT MEMORY
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

logic signed [15:0] conv1_mem_0_0_data_a, conv1_mem_0_0_data_b, conv1_mem_0_1_data_a, conv1_mem_0_1_data_b, 
                    conv1_mem_1_0_data_a, conv1_mem_1_0_data_b, conv1_mem_1_1_data_a, conv1_mem_1_1_data_b, 
                    conv1_mem_2_0_data_a, conv1_mem_2_0_data_b, conv1_mem_2_1_data_a, conv1_mem_2_1_data_b, 
                    conv1_mem_3_0_data_a, conv1_mem_3_0_data_b, conv1_mem_3_1_data_a, conv1_mem_3_1_data_b, 
                    conv1_mem_4_0_data_a, conv1_mem_4_0_data_b, conv1_mem_4_1_data_a, conv1_mem_4_1_data_b, 
                    conv1_mem_5_0_data_a, conv1_mem_5_0_data_b, conv1_mem_5_1_data_a, conv1_mem_5_1_data_b, 
                    conv1_mem_0_0_q_a, conv1_mem_0_0_q_b, conv1_mem_0_1_q_a, conv1_mem_0_1_q_b, conv1_mem_0_2_q_a, conv1_mem_0_2_q_b, conv1_mem_0_3_q_a, conv1_mem_0_3_q_b, 
                    conv1_mem_1_0_q_a, conv1_mem_1_0_q_b, conv1_mem_1_1_q_a, conv1_mem_1_1_q_b, conv1_mem_1_2_q_a, conv1_mem_1_2_q_b, conv1_mem_1_3_q_a, conv1_mem_1_3_q_b, 
                    conv1_mem_2_0_q_a, conv1_mem_2_0_q_b, conv1_mem_2_1_q_a, conv1_mem_2_1_q_b, conv1_mem_2_2_q_a, conv1_mem_2_2_q_b, conv1_mem_2_3_q_a, conv1_mem_2_3_q_b, 
                    conv1_mem_3_0_q_a, conv1_mem_3_0_q_b, conv1_mem_3_1_q_a, conv1_mem_3_1_q_b, conv1_mem_3_2_q_a, conv1_mem_3_2_q_b, conv1_mem_3_3_q_a, conv1_mem_3_3_q_b, 
                    conv1_mem_4_0_q_a, conv1_mem_4_0_q_b, conv1_mem_4_1_q_a, conv1_mem_4_1_q_b, conv1_mem_4_2_q_a, conv1_mem_4_2_q_b, conv1_mem_4_3_q_a, conv1_mem_4_3_q_b, 
                    conv1_mem_5_0_q_a, conv1_mem_5_0_q_b, conv1_mem_5_1_q_a, conv1_mem_5_1_q_b, conv1_mem_5_2_q_a, conv1_mem_5_2_q_b, conv1_mem_5_3_q_a, conv1_mem_5_3_q_b;
logic [8:0] conv1_addr0_write, conv1_addr1_write, conv1_addr0_read, conv1_addr1_read, conv1_addr2_read, conv1_addr3_read, conv1_addr0w0r, conv1_addr0w2r, conv1_addr1w1r, conv1_addr1w3r;

conv1_mem_write conv1_mem_write(.clk(clk), .reset(conv1_mem_write_reset), .enable(Conv1_layer), .addr0(conv1_addr0_write), .addr1(conv1_addr1_write), .done(conv1_mem_write_done));
conv1_mem_read conv1_mem_read(.clk(clk), .reset(conv1_mem_read_reset), .enable(P1_layer), .addr0(conv1_addr0_read), .addr1(conv1_addr1_read), .addr2(conv1_addr2_read), .addr3(conv1_addr3_read), .done(conv1_mem_read_done));
mux_2to1 #(9) conv1_mem_addr_mux_0(.data_in_0(conv1_addr0_write), .data_in_1(conv1_addr0_read), .sel(P1_layer), .data_out(conv1_addr0w0r));
mux_2to1 #(9) conv1_mem_addr_mux_1(.data_in_0(conv1_addr0_write), .data_in_1(conv1_addr2_read), .sel(P1_layer), .data_out(conv1_addr0w2r));
mux_2to1 #(9) conv1_mem_addr_mux_2(.data_in_0(conv1_addr1_write), .data_in_1(conv1_addr1_read), .sel(P1_layer), .data_out(conv1_addr1w1r));
mux_2to1 #(9) conv1_mem_addr_mux_3(.data_in_0(conv1_addr1_write), .data_in_1(conv1_addr3_read), .sel(P1_layer), .data_out(conv1_addr1w3r));

//Conv1 output image 0. Each stores half of the image to allow for 8 accesses. _0 _2 and _1 _3 are redundant
conv1_mem conv1_mem_0_0(.address_a(conv1_addr0w0r), .address_b(conv1_addr1w1r), .clock(clk), .data_a(conv1_mem_0_0_data_a), .data_b(conv1_mem_0_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_0_0_q_a), .q_b(conv1_mem_0_0_q_b));
conv1_mem conv1_mem_0_1(.address_a(conv1_addr0w0r), .address_b(conv1_addr1w1r), .clock(clk), .data_a(conv1_mem_0_1_data_a), .data_b(conv1_mem_0_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_0_1_q_a), .q_b(conv1_mem_0_1_q_b));
conv1_mem conv1_mem_0_2(.address_a(conv1_addr0w2r), .address_b(conv1_addr1w3r), .clock(clk), .data_a(conv1_mem_0_0_data_a), .data_b(conv1_mem_0_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_0_2_q_a), .q_b(conv1_mem_0_2_q_b));
conv1_mem conv1_mem_0_3(.address_a(conv1_addr0w2r), .address_b(conv1_addr1w3r), .clock(clk), .data_a(conv1_mem_0_1_data_a), .data_b(conv1_mem_0_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_0_3_q_a), .q_b(conv1_mem_0_3_q_b));
//Conv1 output image 1. Each stores half of the image to allow for 8 accesses. _0 _2 and _1 _3 are redundant
conv1_mem conv1_mem_1_0(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_1_0_data_a), .data_b(conv1_mem_1_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_1_0_q_a), .q_b(conv1_mem_1_0_q_b));
conv1_mem conv1_mem_1_1(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_1_1_data_a), .data_b(conv1_mem_1_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_1_1_q_a), .q_b(conv1_mem_1_1_q_b));
conv1_mem conv1_mem_1_2(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_1_0_data_a), .data_b(conv1_mem_1_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_1_2_q_a), .q_b(conv1_mem_1_2_q_b));
conv1_mem conv1_mem_1_3(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_1_1_data_a), .data_b(conv1_mem_1_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_1_3_q_a), .q_b(conv1_mem_1_3_q_b));
//Conv1 output image 2. Each stores half of the image to allow for 8 accesses. _0 _2 and _1 _3 are redundant
conv1_mem conv1_mem_2_0(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_2_0_data_a), .data_b(conv1_mem_2_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_2_0_q_a), .q_b(conv1_mem_2_0_q_b));
conv1_mem conv1_mem_2_1(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_2_1_data_a), .data_b(conv1_mem_2_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_2_1_q_a), .q_b(conv1_mem_2_1_q_b));
conv1_mem conv1_mem_2_2(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_2_0_data_a), .data_b(conv1_mem_2_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_2_2_q_a), .q_b(conv1_mem_2_2_q_b));
conv1_mem conv1_mem_2_3(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_2_1_data_a), .data_b(conv1_mem_2_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_2_3_q_a), .q_b(conv1_mem_2_3_q_b));
//Conv1 output image 3. Each stores half of the image to allow for 8 accesses. _0 _2 and _1 _3 are redundant
conv1_mem conv1_mem_3_0(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_3_0_data_a), .data_b(conv1_mem_3_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_3_0_q_a), .q_b(conv1_mem_3_0_q_b));
conv1_mem conv1_mem_3_1(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_3_1_data_a), .data_b(conv1_mem_3_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_3_1_q_a), .q_b(conv1_mem_3_1_q_b));
conv1_mem conv1_mem_3_2(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_3_0_data_a), .data_b(conv1_mem_3_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_3_2_q_a), .q_b(conv1_mem_3_2_q_b));
conv1_mem conv1_mem_3_3(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_3_1_data_a), .data_b(conv1_mem_3_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_3_3_q_a), .q_b(conv1_mem_3_3_q_b));
//Conv1 output image 4. Each stores half of the image to allow for 8 accesses. _0 _2 and _1 _3 are redundant
conv1_mem conv1_mem_4_0(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_4_0_data_a), .data_b(conv1_mem_4_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_4_0_q_a), .q_b(conv1_mem_4_0_q_b));
conv1_mem conv1_mem_4_1(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_4_1_data_a), .data_b(conv1_mem_4_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_4_1_q_a), .q_b(conv1_mem_4_1_q_b));
conv1_mem conv1_mem_4_2(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_4_0_data_a), .data_b(conv1_mem_4_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_4_2_q_a), .q_b(conv1_mem_4_2_q_b));
conv1_mem conv1_mem_4_3(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_4_1_data_a), .data_b(conv1_mem_4_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_4_3_q_a), .q_b(conv1_mem_4_3_q_b));
//Conv1 output image 5. Each stores half of the image to allow for 8 accesses. _0 _2 and _1 _3 are redundant
conv1_mem conv1_mem_5_0(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_5_0_data_a), .data_b(conv1_mem_5_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_5_0_q_a), .q_b(conv1_mem_5_0_q_b));
conv1_mem conv1_mem_5_1(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_5_1_data_a), .data_b(conv1_mem_5_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_5_1_q_a), .q_b(conv1_mem_5_1_q_b));
conv1_mem conv1_mem_5_2(.address_a(conv1_addr0w0r), .address_b(conv1_addr1_read), .clock(clk), .data_a(conv1_mem_5_0_data_a), .data_b(conv1_mem_5_0_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_5_2_q_a), .q_b(conv1_mem_5_2_q_b));
conv1_mem conv1_mem_5_3(.address_a(conv1_addr1w2r), .address_b(conv1_addr3_read), .clock(clk), .data_a(conv1_mem_5_1_data_a), .data_b(conv1_mem_5_1_data_b), .wren_a(Conv1_layer), .wren_b(Conv1_layer), .q_a(conv1_mem_5_3_q_a), .q_b(conv1_mem_5_3_q_b));

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  CONV1 KERNEL MEMORY
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

logic signed [15:0] conv1_k_g0_mem_q_a, conv1_k_g0_mem_q_b, conv1_k_g1_mem_q_a, conv1_k_g1_mem_q_b, conv1_k_g2_mem_q_a, conv1_k_g2_mem_q_b;
logic[5:0] conv1_k_mem_addr0_read, conv1_k_mem_addr1_read;

conv1_k_mem_read conv1_k_mem_read(.clk(clk), .reset(conv1_k_mem_read_reset), .enable(Conv1_layer), .addr0(conv1_k_mem_addr0_read), .addr1(conv1_k_mem_addr1_read), .done(conv1_k_mem_read_done));

//Memories for conv1 kernels. Each holds 2 25x25 kernels.
conv1_k_g0_mem conv1_k_g0_mem(.address_a(conv1_k_mem_addr0_read), .address_b(conv1_k_mem_addr1_read), .clock(clk), .q_a(conv1_k_g0_mem_q_a), .q_b(conv1_k_g0_mem_q_b));
conv1_k_g1_mem conv1_k_g1_mem(.address_a(conv1_k_mem_addr0_read), .address_b(conv1_k_mem_addr1_read), .clock(clk), .q_a(conv1_k_g1_mem_q_a), .q_b(conv1_k_g1_mem_q_b));
conv1_k_g2_mem conv1_k_g2_mem(.address_a(conv1_k_mem_addr0_read), .address_b(conv1_k_mem_addr1_read), .clock(clk), .q_a(conv1_k_g2_mem_q_a), .q_b(conv1_k_g2_mem_q_b));

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  P1 OUTPUT MEMORY
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

logic [7:0] p1_addr_0_read, p1_addr_0_write, p1_addr_1_write, p1_addr0w0r;
mux_2to1 #(8) p1_addr_mux_0(.data_in_0(p1_addr_0_write), .data_in_1(p1_addr_0_read), .sel(Conv2_layer), .data_out(p1_addr0w0r)); //mux to combine write and read addresses
P1_mem_read P1_mem_read(.clk(clk), .reset(P1_mem_read_reset), .enable(Conv2_layer), .addr0(p1_addr_0_read), .done(P1_mem_read_done));
P1_mem_write P1_mem_write(.clk(clk), .reset(P1_mem_write_reset), .enable(P1_layer), .addr0(p1_addr_0_write), .addr1(p1_addr_1_write), .done(P1_mem_write_done));

logic signed [15:0] p1_mem_0_data_a, p1_mem_0_data_b, p1_mem_1_data_a, p1_mem_1_data_b,
                    p1_mem_2_data_a, p1_mem_2_data_b, p1_mem_3_data_a, p1_mem_3_data_b,
                    p1_mem_4_data_a, p1_mem_4_data_b, p1_mem_5_data_a, p1_mem_5_data_b,
                    p1_mem_0_q_a, p1_mem_1_q_a, p1_mem_2_q_a, p1_mem_3_q_a, p1_mem_4_q_a, p1_mem_5_q_a;
//Memories for the 6 outputs of p1. Each is unique
p1_mem p1_mem_0(.address_a(p1_addr0w0r), .address_b(p1_addr_1_write), .clock(clk), .data_a(p1_mem_0_data_a), .data_b(p1_mem_0_data_b), .wren_a(P1_layer), .wren_b(P1_layer), .q_a(p1_mem_0_q_a), .q_b()); //q_b can be left open
p1_mem p1_mem_1(.address_a(p1_addr0w0r), .address_b(p1_addr_1_write), .clock(clk), .data_a(p1_mem_1_data_a), .data_b(p1_mem_1_data_b), .wren_a(P1_layer), .wren_b(P1_layer), .q_a(p1_mem_1_q_a), .q_b()); //q_b can be left open
p1_mem p1_mem_2(.address_a(p1_addr0w0r), .address_b(p1_addr_1_write), .clock(clk), .data_a(p1_mem_2_data_a), .data_b(p1_mem_2_data_b), .wren_a(P1_layer), .wren_b(P1_layer), .q_a(p1_mem_2_q_a), .q_b()); //q_b can be left open
p1_mem p1_mem_3(.address_a(p1_addr0w0r), .address_b(p1_addr_1_write), .clock(clk), .data_a(p1_mem_3_data_a), .data_b(p1_mem_3_data_b), .wren_a(P1_layer), .wren_b(P1_layer), .q_a(p1_mem_3_q_a), .q_b()); //q_b can be left open
p1_mem p1_mem_4(.address_a(p1_addr0w0r), .address_b(p1_addr_1_write), .clock(clk), .data_a(p1_mem_4_data_a), .data_b(p1_mem_4_data_b), .wren_a(P1_layer), .wren_b(P1_layer), .q_a(p1_mem_4_q_a), .q_b()); //q_b can be left open
p1_mem p1_mem_5(.address_a(p1_addr0w0r), .address_b(p1_addr_1_write), .clock(clk), .data_a(p1_mem_5_data_a), .data_b(p1_mem_5_data_b), .wren_a(P1_layer), .wren_b(P1_layer), .q_a(p1_mem_5_q_a), .q_b()); //q_b can be left open

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  CONV2 OUTPUT MEMORY
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

logic [5:0] conv2_addr0_write, conv2_addr0_read, conv2_addr1_read, conv2_addr2_read, conv2_addr3_read, conv2_addr0w0r, conv2_addr0w2r;
logic [1:0] conv2_count;
conv2_mem_write conv2_mem_write(.clk(clk), .reset(conv2_mem_write_reset), .enable(Conv2_layer), .addr0(conv2_addr0_write), .count(conv2_count), .done(conv2_mem_write_done));
conv2_mem_read conv2_mem_read(.clk(clk), .reset(conv2_mem_read_reset), .enable(P2_layer), .addr0(conv2_addr0_read), .addr1(conv2_addr1_read), .addr2(conv2_addr2_read), .addr3(conv2_addr3_read), .done(conv2_mem_read_done));
mux_2to1 #(6) conv2_mem_addr_mux_0(.data_in_0(conv2_addr0_write), .data_in_1(conv2_addr0_read), .sel(P2_layer), .data_out(conv2_addr0w0r));
mux_2to1 #(6) conv2_mem_addr_mux_1(.data_in_0(conv2_addr0_write), .data_in_1(conv2_addr2_read), .sel(P2_layer), .data_out(conv2_addr0w2r));

logic signed [15:0] conv2_mem_0_data, conv2_mem_1_data, conv2_mem_2_data, conv2_mem_3_data, 
                    conv2_mem_4_data, conv2_mem_5_data, conv2_mem_6_data, conv2_mem_7_data, 
                    conv2_mem_8_data, conv2_mem_9_data, conv2_mem_10_data, conv2_mem_11_data, 
                    conv2_mem_0_0_q_a, conv2_mem_0_0_q_b, conv2_mem_0_1_q_a, conv2_mem_0_1_q_b, 
                    conv2_mem_1_0_q_a, conv2_mem_1_0_q_b, conv2_mem_1_1_q_a, conv2_mem_1_1_q_b, 
                    conv2_mem_2_0_q_a, conv2_mem_2_0_q_b, conv2_mem_2_1_q_a, conv2_mem_2_1_q_b, 
                    conv2_mem_3_0_q_a, conv2_mem_3_0_q_b, conv2_mem_3_1_q_a, conv2_mem_3_1_q_b, 
                    conv2_mem_4_0_q_a, conv2_mem_4_0_q_b, conv2_mem_4_1_q_a, conv2_mem_4_1_q_b, 
                    conv2_mem_5_0_q_a, conv2_mem_5_0_q_b, conv2_mem_5_1_q_a, conv2_mem_5_1_q_b,
                    conv2_mem_6_0_q_a, conv2_mem_6_0_q_b, conv2_mem_6_1_q_a, conv2_mem_6_1_q_b, 
                    conv2_mem_7_0_q_a, conv2_mem_7_0_q_b, conv2_mem_7_1_q_a, conv2_mem_7_1_q_b, 
                    conv2_mem_8_0_q_a, conv2_mem_8_0_q_b, conv2_mem_8_1_q_a, conv2_mem_8_1_q_b, 
                    conv2_mem_9_0_q_a, conv2_mem_9_0_q_b, conv2_mem_9_1_q_a, conv2_mem_9_1_q_b, 
                    conv2_mem_10_0_q_a, conv2_mem_10_0_q_b, conv2_mem_10_1_q_a, conv2_mem_10_1_q_b, 
                    conv2_mem_11_0_q_a, conv2_mem_11_0_q_b, conv2_mem_11_1_q_a, conv2_mem_11_1_q_b;

//Conv2 output 0. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_0_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_0_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_0_0_q_a), .q_b(conv2_mem_0_0_q_b));
conv2_mem conv2_mem_0_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_0_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_0_1_q_a), .q_b(conv2_mem_0_1_q_b));
//Conv2 output 1. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_1_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_1_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_1_0_q_a), .q_b(conv2_mem_1_0_q_b));
conv2_mem conv2_mem_1_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_1_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_1_1_q_a), .q_b(conv2_mem_1_1_q_b));
//Conv2 output 2. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_2_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_2_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_2_0_q_a), .q_b(conv2_mem_2_0_q_b));
conv2_mem conv2_mem_2_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_2_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_2_1_q_a), .q_b(conv2_mem_2_1_q_b));
//Conv2 output 3. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_3_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_3_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_3_0_q_a), .q_b(conv2_mem_3_0_q_b));
conv2_mem conv2_mem_3_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_3_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_3_1_q_a), .q_b(conv2_mem_3_1_q_b));
//Conv2 output 4. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_4_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_4_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_4_0_q_a), .q_b(conv2_mem_4_0_q_b));
conv2_mem conv2_mem_4_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_4_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_4_1_q_a), .q_b(conv2_mem_4_1_q_b));
//Conv2 output 5. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_5_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_5_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_5_0_q_a), .q_b(conv2_mem_5_0_q_b));
conv2_mem conv2_mem_5_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_5_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_5_1_q_a), .q_b(conv2_mem_5_1_q_b));
//Conv2 output 6. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_6_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_6_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_6_0_q_a), .q_b(conv2_mem_6_0_q_b));
conv2_mem conv2_mem_6_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_6_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_6_1_q_a), .q_b(conv2_mem_6_1_q_b));
//Conv2 output 7. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_7_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_7_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_7_0_q_a), .q_b(conv2_mem_7_0_q_b));
conv2_mem conv2_mem_7_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_7_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_7_1_q_a), .q_b(conv2_mem_7_1_q_b));
//Conv2 output 8. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_8_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_8_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_8_0_q_a), .q_b(conv2_mem_8_0_q_b));
conv2_mem conv2_mem_8_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_8_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_8_1_q_a), .q_b(conv2_mem_8_1_q_b));
//Conv2 output 9. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_9_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_9_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_9_0_q_a), .q_b(conv2_mem_9_0_q_b));
conv2_mem conv2_mem_9_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_9_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_9_1_q_a), .q_b(conv2_mem_9_1_q_b));
//Conv2 output 10. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_10_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_10_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_10_0_q_a), .q_b(conv2_mem_10_0_q_b));
conv2_mem conv2_mem_10_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_10_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_10_1_q_a), .q_b(conv2_mem_10_1_q_b));
//Conv2 output 11. They are redundant to allow for 4 accesses
conv2_mem conv2_mem_11_0(.address_a(conv2_addr0w0r), .address_b(conv2_addr1_read), .clock(clk), .data_a(conv2_mem_11_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_11_0_q_a), .q_b(conv2_mem_11_0_q_b));
conv2_mem conv2_mem_11_1(.address_a(conv2_addr0w2r), .address_b(conv2_addr3_read), .clock(clk), .data_a(conv2_mem_11_data), .data_b(16'b0000000000000000), .wren_a(Conv2_layer), .wren_b(1'b0), .q_a(conv2_mem_11_1_q_a), .q_b(conv2_mem_11_1_q_b));

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  CONV2 KERNEL MEMORY
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

logic[7:0] conv2_k_mem_addr0_read, conv2_k_mem_addr1_read;
conv2_k_mem_read conv2_k_mem_read(.clk(clk), .reset(conv2_k_mem_read_reset), .enable(Conv2_layer), .addr0(conv2_k_mem_addr0_read), .addr1(conv2_k_mem_addr1_read), .done(conv2_k_mem_read_done));

logic signed [15:0] conv2_k_g0_mem_q_a, conv2_k_g0_mem_q_b, conv2_k_g1_mem_q_a, conv2_k_g1_mem_q_b, 
                    conv2_k_g2_mem_q_a, conv2_k_g2_mem_q_b, conv2_k_g3_mem_q_a, conv2_k_g3_mem_q_b, 
                    conv2_k_g4_mem_q_a, conv2_k_g4_mem_q_b, conv2_k_g5_mem_q_a, conv2_k_g5_mem_q_b, 
                    conv2_k_g6_mem_q_a, conv2_k_g6_mem_q_b, conv2_k_g7_mem_q_a, conv2_k_g7_mem_q_b, 
                    conv2_k_g8_mem_q_a, conv2_k_g8_mem_q_b, conv2_k_g9_mem_q_a, conv2_k_g9_mem_q_b, 
                    conv2_k_g10_mem_q_a, conv2_k_g10_mem_q_b, conv2_k_g11_mem_q_a, conv2_k_g11_mem_q_b;
//Memories for conv2 kernels. Each holds 6 25x25 kernels.
conv2_k_g0_mem conv2_k_g0_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g0_mem_q_a), .q_b(conv2_k_g0_mem_q_b));
conv2_k_g1_mem conv2_k_g1_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g1_mem_q_a), .q_b(conv2_k_g1_mem_q_b));
conv2_k_g2_mem conv2_k_g2_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g2_mem_q_a), .q_b(conv2_k_g2_mem_q_b));
conv2_k_g3_mem conv2_k_g3_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g3_mem_q_a), .q_b(conv2_k_g3_mem_q_b));
conv2_k_g4_mem conv2_k_g4_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g4_mem_q_a), .q_b(conv2_k_g4_mem_q_b));
conv2_k_g5_mem conv2_k_g5_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g5_mem_q_a), .q_b(conv2_k_g5_mem_q_b));
conv2_k_g6_mem conv2_k_g6_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g6_mem_q_a), .q_b(conv2_k_g6_mem_q_b));
conv2_k_g7_mem conv2_k_g7_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g7_mem_q_a), .q_b(conv2_k_g7_mem_q_b));
conv2_k_g8_mem conv2_k_g8_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g8_mem_q_a), .q_b(conv2_k_g8_mem_q_b));
conv2_k_g9_mem conv2_k_g9_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g9_mem_q_a), .q_b(conv2_k_g9_mem_q_b));
conv2_k_g10_mem conv2_k_g10_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g10_mem_q_a), .q_b(conv2_k_g10_mem_q_b));
conv2_k_g11_mem conv2_k_g11_mem(.address_a(conv2_k_mem_addr0_read), .address_b(conv2_k_mem_addr1_read), .clock(clk), .q_a(conv2_k_g11_mem_q_a), .q_b(conv2_k_g11_mem_q_b));

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  P2 OUTPUT MEMORY
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

//wires that go from P2 memories/addressers
logic [3:0] P2_mem_sel; //wire that will control the muxes that make sure the P2 memory is read squentially block by block
logic signed [15:0] P2_mem_0_data, P2_mem_1_data, P2_mem_2_data, P2_mem_3_data, P2_mem_4_data, P2_mem_5_data, 
                    P2_mem_6_data, P2_mem_7_data, P2_mem_8_data, P2_mem_9_data, P2_mem_10_data, P2_mem_11_data, 
                    P2_mem_0_q, P2_mem_1_q, P2_mem_2_q, P2_mem_3_q, P2_mem_4_q, P2_mem_5_q, 
                    P2_mem_6_q, P2_mem_7_q, P2_mem_8_q, P2_mem_9_q, P2_mem_10_q, P2_mem_11_q; //q lines for p2 memory block
logic [3:0] P2_addr0_write, P2_addr0_read, P2_addr0w0r; //wires for addressing

//addressers for writing and reading the P2 memories
P2_mem_write P2_mem_write(.clk(clk), .reset(P2_mem_write_reset), .enable(P2_layer), .addr0(P2_addr0_write), .done(P2_mem_write_done));
P2_mem_read P2_mem_read(.clk(clk), .reset(P2_mem_read_reset), .enable(FC_layer), .addr0(P2_addr0_read), .count(P2_mem_sel), .done(P2_mem_read_done));
mux_2to1 #(4) P2_addr_mux_0(.data_in_0(P2_addr0_write), .data_in_1(P2_addr0_read), .sel(FC_layer), .data_out(P2_addr0w0r)); //mux to combine write and read addresses

//Memories for the 12 outputs of p2. Each is unique
p2_mem p2_mem_0(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_0_data), .wren(P2_layer), .q(P2_mem_0_q));
p2_mem p2_mem_1(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_1_data), .wren(P2_layer), .q(P2_mem_1_q));
p2_mem p2_mem_2(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_2_data), .wren(P2_layer), .q(P2_mem_2_q));
p2_mem p2_mem_3(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_3_data), .wren(P2_layer), .q(P2_mem_3_q));
p2_mem p2_mem_4(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_4_data), .wren(P2_layer), .q(P2_mem_4_q));
p2_mem p2_mem_5(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_5_data), .wren(P2_layer), .q(P2_mem_5_q));
p2_mem p2_mem_6(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_6_data), .wren(P2_layer), .q(P2_mem_6_q));
p2_mem p2_mem_7(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_7_data), .wren(P2_layer), .q(P2_mem_7_q));
p2_mem p2_mem_8(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_8_data), .wren(P2_layer), .q(P2_mem_8_q));
p2_mem p2_mem_9(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_9_data), .wren(P2_layer), .q(P2_mem_9_q));
p2_mem p2_mem_10(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_10_data), .wren(P2_layer), .q(P2_mem_10_q));
p2_mem p2_mem_11(.address(P2_addr0w0r), .clock(clk), .data(P2_mem_11_data), .wren(P2_layer), .q(P2_mem_11_q));

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  FC WEIGHT MEMORY
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

//wires for FC memories
logic signed [15:0] fc_g0_mem_q_a, fc_g0_mem_q_b, fc_g1_mem_q_a, fc_g1_mem_q_b, fc_g2_mem_q_a, fc_g2_mem_q_b, fc_g3_mem_q_a, fc_g3_mem_q_b, fc_g4_mem_q_a, fc_g4_mem_q_b;
logic [8:0] fc_mem_addr0_read, fc_mem_addr1_read;

//addressers for writing and reading the FC weight memories
fc_mem_read fc_mem_read(.clk(clk), .reset(fc_mem_read_reset), .enable(FC_layer), .addr0(fc_mem_addr0_read), .addr1(fc_mem_addr1_read), .done(fc_mem_read_done));

//Memories for FC weights. Each holds 2 neurons's 192 weights(384 in total)
fc_g0_mem fc_g0_mem(.address_a(fc_mem_addr0_read), .address_b(fc_mem_addr1_read), .clock(clk), .q_a(fc_g0_mem_q_a), .q_b(fc_g0_mem_q_b));
fc_g1_mem fc_g1_mem(.address_a(fc_mem_addr0_read), .address_b(fc_mem_addr1_read), .clock(clk), .q_a(fc_g1_mem_q_a), .q_b(fc_g1_mem_q_b));
fc_g2_mem fc_g2_mem(.address_a(fc_mem_addr0_read), .address_b(fc_mem_addr1_read), .clock(clk), .q_a(fc_g2_mem_q_a), .q_b(fc_g2_mem_q_b));
fc_g3_mem fc_g3_mem(.address_a(fc_mem_addr0_read), .address_b(fc_mem_addr1_read), .clock(clk), .q_a(fc_g3_mem_q_a), .q_b(fc_g3_mem_q_b));
fc_g4_mem fc_g4_mem(.address_a(fc_mem_addr0_read), .address_b(fc_mem_addr1_read), .clock(clk), .q_a(fc_g4_mem_q_a), .q_b(fc_g4_mem_q_b));

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  MAC
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

//signals for input to MACs and to connect the MACs to the after MACs
logic signed [15:0] MAC_in_data_0, MAC_in_data_1, MAC_in_data_2, MAC_in_data_3, MAC_in_data_4, MAC_in_data_5, 
                    MAC_in_data_6, MAC_in_data_7, MAC_in_data_8, MAC_in_data_9, MAC_in_data_10, MAC_in_data_11, 
                    MAC_in_data_12, MAC_in_data_13, MAC_in_data_14, MAC_in_data_15, MAC_in_data_16, MAC_in_data_17, 
                    MAC_in_data_18, MAC_in_data_19, MAC_in_data_20, MAC_in_data_21, MAC_in_data_22, MAC_in_data_23, 
                    MAC_in_para_0, MAC_in_para_1, MAC_in_para_2, MAC_in_para_3, MAC_in_para_4, MAC_in_para_5, 
                    MAC_in_para_6, MAC_in_para_7, MAC_in_para_8, MAC_in_para_9, MAC_in_para_10, MAC_in_para_11, 
                    MAC_in_para_12, MAC_in_para_13, MAC_in_para_14, MAC_in_para_15, MAC_in_para_16, MAC_in_para_17, 
                    MAC_in_para_18, MAC_in_para_19, MAC_in_para_20, MAC_in_para_21, MAC_in_para_22, MAC_in_para_23,
                    FC_in_data_0,  FC_in_data_1,  FC_in_data_2,  FC_in_data_3,  FC_in_data_4,  FC_in_data_5, 
                    FC_in_data_6,  FC_in_data_7,  FC_in_data_8,  FC_in_data_9,  FC_in_data_10,  FC_in_data_11, 
                    FC_in_data_12,  FC_in_data_13,  FC_in_data_14,  FC_in_data_15,  FC_in_data_16,  FC_in_data_17, 
                    FC_in_data_18,  FC_in_data_19,  FC_in_data_20,  FC_in_data_21,  FC_in_data_22,  FC_in_data_23,
                    out_conv2_0, out_conv2_1, out_conv2_2, out_conv2_3,
                    after_MAC_0_out_0, after_MAC_0_out_1, after_MAC_0_out_2, after_MAC_0_out_3, after_MAC_0_out_4, 
                    after_MAC_0_out_5, after_MAC_1_out_0, after_MAC_1_out_1, after_MAC_1_out_2, after_MAC_1_out_3; 
logic signed [31:0] conv2_bias_0, conv2_bias_1, conv2_bias_2, conv2_bias_3,
                    MAC_out_0, MAC_out_1, MAC_out_2, MAC_out_3, MAC_out_4, MAC_out_5,
                    MAC_out_6, MAC_out_7, MAC_out_8, MAC_out_9, MAC_out_10, MAC_out_11, 
                    MAC_out_12, MAC_out_13, MAC_out_14, MAC_out_15, MAC_out_16, MAC_out_17, 
                    MAC_out_18, MAC_out_19, MAC_out_20, MAC_out_21, MAC_out_22, MAC_out_23;

//Data muxes for FC layer. Responsible for making sure each input is read sequentially by all MACs
mux_12to1 data_mux_12to1_0(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q), 
                           .sel(P2_mem_sel), .data_out(FC_in_data_0));
mux_12to1 data_mux_12to1_1(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q), 
                           .sel(P2_mem_sel), .data_out(FC_in_data_1));
mux_12to1 data_mux_12to1_2(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_2));
mux_12to1 data_mux_12to1_3(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_3));
mux_12to1 data_mux_12to1_4(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_4));
mux_12to1 data_mux_12to1_5(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_5));
mux_12to1 data_mux_12to1_6(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_6));
mux_12to1 data_mux_12to1_7(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_7));
mux_12to1 data_mux_12to1_8(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_8));
mux_12to1 data_mux_12to1_9(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_9));
mux_12to1 data_mux_12to1_10(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                           .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                           .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                           .sel(P2_mem_sel), .data_out(FC_in_data_10));
mux_12to1 data_mux_12to1_11(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_11));
mux_12to1 data_mux_12to1_12(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_12));
mux_12to1 data_mux_12to1_13(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_13));
mux_12to1 data_mux_12to1_14(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_14));
mux_12to1 data_mux_12to1_15(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_15));
mux_12to1 data_mux_12to1_16(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_16));
mux_12to1 data_mux_12to1_17(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_17));
mux_12to1 data_mux_12to1_18(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_18));
mux_12to1 data_mux_12to1_19(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_19));
mux_12to1 data_mux_12to1_20(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_20));
mux_12to1 data_mux_12to1_21(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_21));
mux_12to1 data_mux_12to1_22(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_22));
mux_12to1 data_mux_12to1_23(.data_in_0(P2_mem_0_q), .data_in_1(P2_mem_1_q), .data_in_2(P2_mem_2_q), .data_in_3(P2_mem_3_q), 
                            .data_in_4(P2_mem_4_q), .data_in_5(P2_mem_5_q), .data_in_6(P2_mem_6_q), .data_in_7(P2_mem_7_q), 
                            .data_in_8(P2_mem_8_q), .data_in_9(P2_mem_9_q), .data_in_10(P2_mem_10_q), .data_in_11(P2_mem_11_q),  
                            .sel(P2_mem_sel), .data_out(FC_in_data_23));

//Muxes to control the inputs to the MACs based on layer
mux_3to1 data_mux_3to1_0(.data_in_0(img_mem_0_q_a), .data_in_1(p1_mem_0_q_a), .data_in_2(FC_in_data_0), .sel(MAC_layer), .data_out(MAC_in_data_0));
mux_3to1 data_mux_3to1_1(.data_in_0(img_mem_0_q_a), .data_in_1(p1_mem_1_q_a), .data_in_2(FC_in_data_1), .sel(MAC_layer), .data_out(MAC_in_data_1));
mux_3to1 data_mux_3to1_2(.data_in_0(img_mem_0_q_a), .data_in_1(p1_mem_2_q_a), .data_in_2(FC_in_data_2), .sel(MAC_layer), .data_out(MAC_in_data_2));
mux_3to1 data_mux_3to1_3(.data_in_0(img_mem_0_q_a), .data_in_1(p1_mem_3_q_a), .data_in_2(FC_in_data_3), .sel(MAC_layer), .data_out(MAC_in_data_3));
mux_3to1 data_mux_3to1_4(.data_in_0(img_mem_0_q_a), .data_in_1(p1_mem_4_q_a), .data_in_2(FC_in_data_4), .sel(MAC_layer), .data_out(MAC_in_data_4));
mux_3to1 data_mux_3to1_5(.data_in_0(img_mem_0_q_a), .data_in_1(p1_mem_5_q_a), .data_in_2(FC_in_data_5), .sel(MAC_layer), .data_out(MAC_in_data_5));
mux_3to1 data_mux_3to1_6(.data_in_0(img_mem_0_q_b), .data_in_1(p1_mem_0_q_a), .data_in_2(FC_in_data_6), .sel(MAC_layer), .data_out(MAC_in_data_6));
mux_3to1 data_mux_3to1_7(.data_in_0(img_mem_0_q_b), .data_in_1(p1_mem_1_q_a), .data_in_2(FC_in_data_7), .sel(MAC_layer), .data_out(MAC_in_data_7));
mux_3to1 data_mux_3to1_8(.data_in_0(img_mem_0_q_b), .data_in_1(p1_mem_2_q_a), .data_in_2(FC_in_data_8), .sel(MAC_layer), .data_out(MAC_in_data_8));
mux_3to1 data_mux_3to1_9(.data_in_0(img_mem_0_q_b), .data_in_1(p1_mem_3_q_a), .data_in_2(FC_in_data_9), .sel(MAC_layer), .data_out(MAC_in_data_9));
mux_3to1 data_mux_3to1_10(.data_in_0(img_mem_0_q_b), .data_in_1(p1_mem_4_q_a), .data_in_2(FC_in_data_10), .sel(MAC_layer), .data_out(MAC_in_data_10));
mux_3to1 data_mux_3to1_11(.data_in_0(img_mem_0_q_b), .data_in_1(p1_mem_5_q_a), .data_in_2(FC_in_data_11), .sel(MAC_layer), .data_out(MAC_in_data_11));
mux_3to1 data_mux_3to1_12(.data_in_0(img_mem_1_q_a), .data_in_1(p1_mem_0_q_a), .data_in_2(FC_in_data_12), .sel(MAC_layer), .data_out(MAC_in_data_12));
mux_3to1 data_mux_3to1_13(.data_in_0(img_mem_1_q_a), .data_in_1(p1_mem_1_q_a), .data_in_2(FC_in_data_13), .sel(MAC_layer), .data_out(MAC_in_data_13));
mux_3to1 data_mux_3to1_14(.data_in_0(img_mem_1_q_a), .data_in_1(p1_mem_2_q_a), .data_in_2(FC_in_data_14), .sel(MAC_layer), .data_out(MAC_in_data_14));
mux_3to1 data_mux_3to1_15(.data_in_0(img_mem_1_q_a), .data_in_1(p1_mem_3_q_a), .data_in_2(FC_in_data_15), .sel(MAC_layer), .data_out(MAC_in_data_15));
mux_3to1 data_mux_3to1_16(.data_in_0(img_mem_1_q_a), .data_in_1(p1_mem_4_q_a), .data_in_2(FC_in_data_16), .sel(MAC_layer), .data_out(MAC_in_data_16));
mux_3to1 data_mux_3to1_17(.data_in_0(img_mem_1_q_a), .data_in_1(p1_mem_5_q_a), .data_in_2(FC_in_data_17), .sel(MAC_layer), .data_out(MAC_in_data_17));
mux_3to1 data_mux_3to1_18(.data_in_0(img_mem_1_q_b), .data_in_1(p1_mem_0_q_a), .data_in_2(FC_in_data_18), .sel(MAC_layer), .data_out(MAC_in_data_18));
mux_3to1 data_mux_3to1_19(.data_in_0(img_mem_1_q_b), .data_in_1(p1_mem_1_q_a), .data_in_2(FC_in_data_19), .sel(MAC_layer), .data_out(MAC_in_data_19));
mux_3to1 data_mux_3to1_20(.data_in_0(img_mem_1_q_b), .data_in_1(p1_mem_2_q_a), .data_in_2(FC_in_data_20), .sel(MAC_layer), .data_out(MAC_in_data_20));
mux_3to1 data_mux_3to1_21(.data_in_0(img_mem_1_q_b), .data_in_1(p1_mem_3_q_a), .data_in_2(FC_in_data_21), .sel(MAC_layer), .data_out(MAC_in_data_21));
mux_3to1 data_mux_3to1_22(.data_in_0(img_mem_1_q_b), .data_in_1(p1_mem_4_q_a), .data_in_2(FC_in_data_22), .sel(MAC_layer), .data_out(MAC_in_data_22));
mux_3to1 data_mux_3to1_23(.data_in_0(img_mem_1_q_b), .data_in_1(p1_mem_5_q_a), .data_in_2(FC_in_data_23), .sel(MAC_layer), .data_out(MAC_in_data_23));

//Muxes to make sure proper input parameter based on the correct ROM. 1 for conv1, 1 for conv2, 1 for fc.
mux_3to1 para_mux_3to1_0(.data_in_0(conv1_k_g0_mem_q_a), .data_in_1(conv2_k_g0_mem_q_a), .data_in_2(fc_g0_mem_q_a), .sel(MAC_layer), .data_out(MAC_in_para_0));
mux_3to1 para_mux_3to1_1(.data_in_0(conv1_k_g0_mem_q_b), .data_in_1(conv2_k_g0_mem_q_b), .data_in_2(fc_g0_mem_q_b), .sel(MAC_layer), .data_out(MAC_in_para_1));
mux_3to1 para_mux_3to1_2(.data_in_0(conv1_k_g1_mem_q_a), .data_in_1(conv2_k_g1_mem_q_a), .data_in_2(fc_g1_mem_q_a), .sel(MAC_layer), .data_out(MAC_in_para_2));
mux_3to1 para_mux_3to1_3(.data_in_0(conv1_k_g1_mem_q_b), .data_in_1(conv2_k_g1_mem_q_b), .data_in_2(fc_g1_mem_q_b), .sel(MAC_layer), .data_out(MAC_in_para_3));
mux_3to1 para_mux_3to1_4(.data_in_0(conv1_k_g2_mem_q_a), .data_in_1(conv2_k_g2_mem_q_a), .data_in_2(fc_g2_mem_q_a), .sel(MAC_layer), .data_out(MAC_in_para_4));
mux_3to1 para_mux_3to1_5(.data_in_0(conv1_k_g2_mem_q_b), .data_in_1(conv2_k_g2_mem_q_b), .data_in_2(fc_g2_mem_q_b), .sel(MAC_layer), .data_out(MAC_in_para_5));
mux_3to1 para_mux_3to1_6(.data_in_0(conv1_k_g0_mem_q_a), .data_in_1(conv2_k_g3_mem_q_a), .data_in_2(fc_g3_mem_q_a), .sel(MAC_layer), .data_out(MAC_in_para_6));
mux_3to1 para_mux_3to1_7(.data_in_0(conv1_k_g0_mem_q_b), .data_in_1(conv2_k_g3_mem_q_b), .data_in_2(fc_g3_mem_q_b), .sel(MAC_layer), .data_out(MAC_in_para_7));
mux_3to1 para_mux_3to1_8(.data_in_0(conv1_k_g1_mem_q_a), .data_in_1(conv2_k_g4_mem_q_a), .data_in_2(fc_g4_mem_q_a), .sel(MAC_layer), .data_out(MAC_in_para_8));
mux_3to1 para_mux_3to1_9(.data_in_0(conv1_k_g1_mem_q_b), .data_in_1(conv2_k_g4_mem_q_b), .data_in_2(fc_g4_mem_q_b), .sel(MAC_layer), .data_out(MAC_in_para_9));
mux_3to1 para_mux_3to1_10(.data_in_0(conv1_k_g2_mem_q_a), .data_in_1(conv2_k_g5_mem_q_a), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_10));
mux_3to1 para_mux_3to1_11(.data_in_0(conv1_k_g2_mem_q_b), .data_in_1(conv2_k_g5_mem_q_b), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_11));
mux_3to1 para_mux_3to1_12(.data_in_0(conv1_k_g0_mem_q_a), .data_in_1(conv2_k_g6_mem_q_a), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_12));
mux_3to1 para_mux_3to1_13(.data_in_0(conv1_k_g0_mem_q_b), .data_in_1(conv2_k_g6_mem_q_b), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_13));
mux_3to1 para_mux_3to1_14(.data_in_0(conv1_k_g1_mem_q_a), .data_in_1(conv2_k_g7_mem_q_a), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_14));
mux_3to1 para_mux_3to1_15(.data_in_0(conv1_k_g1_mem_q_b), .data_in_1(conv2_k_g7_mem_q_b), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_15));
mux_3to1 para_mux_3to1_16(.data_in_0(conv1_k_g2_mem_q_a), .data_in_1(conv2_k_g8_mem_q_a), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_16));
mux_3to1 para_mux_3to1_17(.data_in_0(conv1_k_g2_mem_q_b), .data_in_1(conv2_k_g8_mem_q_b), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_17));
mux_3to1 para_mux_3to1_18(.data_in_0(conv1_k_g0_mem_q_a), .data_in_1(conv2_k_g9_mem_q_a), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_18));
mux_3to1 para_mux_3to1_19(.data_in_0(conv1_k_g0_mem_q_b), .data_in_1(conv2_k_g9_mem_q_b), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_19));
mux_3to1 para_mux_3to1_20(.data_in_0(conv1_k_g1_mem_q_a), .data_in_1(conv2_k_g10_mem_q_a), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_20));
mux_3to1 para_mux_3to1_21(.data_in_0(conv1_k_g1_mem_q_b), .data_in_1(conv2_k_g10_mem_q_b), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_21));
mux_3to1 para_mux_3to1_22(.data_in_0(conv1_k_g2_mem_q_a), .data_in_1(conv2_k_g11_mem_q_a), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_22));
mux_3to1 para_mux_3to1_23(.data_in_0(conv1_k_g2_mem_q_b), .data_in_1(conv2_k_g11_mem_q_b), .data_in_2(16'b0000000000000000), .sel(MAC_layer), .data_out(MAC_in_para_23));

//bias muxes
mux_3to1 #(32) bias_mux_3to1_0(.data_in_0(32'b00000000000000000000000000000011), .data_in_1(32'b00000000000000000000000000000011), .data_in_2(32'b00000000000000000000000000000011), .sel(conv2_count), .data_out(conv2_bias_0));
mux_3to1 #(32) bias_mux_3to1_1(.data_in_0(32'b11111111111111111111111111111110), .data_in_1(32'b00000000000000000000000000000000), .data_in_2(32'b00000000000000000000000000000010), .sel(conv2_count), .data_out(conv2_bias_1));
mux_3to1 #(32) bias_mux_3to1_2(.data_in_0(32'b00000000000000000000000000000001), .data_in_1(32'b00000000000000000000000000000001), .data_in_2(32'b11111111111111111111111111111111), .sel(conv2_count), .data_out(conv2_bias_2));
mux_3to1 #(32) bias_mux_3to1_3(.data_in_0(32'b00000000000000000000000000000011), .data_in_1(32'b00000000000000000000000000000010), .data_in_2(32'b11111111111111111111111111111111), .sel(conv2_count), .data_out(conv2_bias_3));

//24 MAC modules
MAC MAC_0(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_0), .B(MAC_in_para_0), .out(MAC_out_0));
MAC MAC_1(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_1), .B(MAC_in_para_1), .out(MAC_out_1));
MAC MAC_2(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_2), .B(MAC_in_para_2), .out(MAC_out_2));
MAC MAC_3(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_3), .B(MAC_in_para_3), .out(MAC_out_3));
MAC MAC_4(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_4), .B(MAC_in_para_4), .out(MAC_out_4));
MAC MAC_5(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_5), .B(MAC_in_para_5), .out(MAC_out_5));
MAC MAC_6(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_6), .B(MAC_in_para_6), .out(MAC_out_6));
MAC MAC_7(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_7), .B(MAC_in_para_7), .out(MAC_out_7));
MAC MAC_8(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_8), .B(MAC_in_para_8), .out(MAC_out_8));
MAC MAC_9(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_9), .B(MAC_in_para_9), .out(MAC_out_9));
MAC MAC_10(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_10), .B(MAC_in_para_10), .out(MAC_out_10));
MAC MAC_11(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_11), .B(MAC_in_para_11), .out(MAC_out_11));
MAC MAC_12(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_12), .B(MAC_in_para_12), .out(MAC_out_12));
MAC MAC_13(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_13), .B(MAC_in_para_13), .out(MAC_out_13));
MAC MAC_14(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_14), .B(MAC_in_para_14), .out(MAC_out_14));
MAC MAC_15(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_15), .B(MAC_in_para_15), .out(MAC_out_15));
MAC MAC_16(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_16), .B(MAC_in_para_16), .out(MAC_out_16));
MAC MAC_17(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_17), .B(MAC_in_para_17), .out(MAC_out_17));
MAC MAC_18(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_18), .B(MAC_in_para_18), .out(MAC_out_18));
MAC MAC_19(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_19), .B(MAC_in_para_19), .out(MAC_out_19));
MAC MAC_20(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_20), .B(MAC_in_para_20), .out(MAC_out_20));
MAC MAC_21(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_21), .B(MAC_in_para_21), .out(MAC_out_21));
MAC MAC_22(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_22), .B(MAC_in_para_22), .out(MAC_out_22));
MAC MAC_23(.clk(clk), .enable(MAC_enable), .reset(rMAC), .MAC_layer(MAC_layer), .A(MAC_in_data_23), .B(MAC_in_para_23), .out(MAC_out_23));

//The after MAC does all subsequent operations needed after the MAC depending on the layer. ReLU, combination, biases, shifting, etc.
after_MAC after_MAC_0(.MAC_layer(MAC_layer), .MAC_out_0(MAC_out_0), .MAC_out_1(MAC_out_1), .MAC_out_2(MAC_out_2), .MAC_out_3(MAC_out_3), 
                      .MAC_out_4(MAC_out_4), .MAC_out_5(MAC_out_5), .bias_0(32'b11111111111111111111111111110100), .bias_1(32'b11111111111111111111111111110010), .bias_2(32'b11111111111111111111111111110111),
                      .bias_3(32'b11111111111111111111111111111100), .bias_4(32'b11111111111111111111111111111100), .bias_5(32'b00000000000000000000000000000100), .conv2_bias(conv2_bias_0), .out_0(after_MAC_0_out_0),
                      .out_1(after_MAC_0_out_1), .out_2(after_MAC_0_out_2), .out_3(after_MAC_0_out_3), .out_4(after_MAC_0_out_4), .out_5(after_MAC_0_out_5), .out_conv2(out_conv2_0));
after_MAC after_MAC_1(.MAC_layer(MAC_layer), .MAC_out_0(MAC_out_6), .MAC_out_1(MAC_out_7), .MAC_out_2(MAC_out_8), .MAC_out_3(MAC_out_9), 
                      .MAC_out_4(MAC_out_10), .MAC_out_5(MAC_out_11), .bias_0(32'b11111111111111111111111111110100), .bias_1(32'b11111111111111111111111111110010), .bias_2(32'b11111111111111111111111111110111),
                      .bias_3(32'b11111111111111111111111111111100), .bias_4(32'b11111111111111111111111111111100), .bias_5(32'b00000000000000000000000000000100), .conv2_bias(conv2_bias_1), .out_0(after_MAC_1_out_0),
                      .out_1(after_MAC_1_out_1), .out_2(after_MAC_1_out_2), .out_3(after_MAC_1_out_3), .out_4(conv1_mem_4_0_data_b), .out_5(conv1_mem_5_0_data_b), .out_conv2(out_conv2_1));
after_MAC after_MAC_2(.MAC_layer(MAC_layer), .MAC_out_0(MAC_out_12), .MAC_out_1(MAC_out_13), .MAC_out_2(MAC_out_14), .MAC_out_3(MAC_out_15), 
                      .MAC_out_4(MAC_out_16), .MAC_out_5(MAC_out_17), .bias_0(32'b11111111111111111111111111110100), .bias_1(32'b11111111111111111111111111110010), .bias_2(32'b11111111111111111111111111110111),
                      .bias_3(32'b11111111111111111111111111111100), .bias_4(32'b11111111111111111111111111111100), .bias_5(32'b00000000000000000000000000000100), .conv2_bias(conv2_bias_2), .out_0(conv1_mem_0_1_data_a),
                      .out_1(conv1_mem_1_1_data_a), .out_2(conv1_mem_2_1_data_a), .out_3(conv1_mem_3_1_data_a), .out_4(conv1_mem_4_1_data_a), .out_5(conv1_mem_5_1_data_a), .out_conv2(out_conv2_2));
after_MAC after_MAC_3(.MAC_layer(MAC_layer), .MAC_out_0(MAC_out_18), .MAC_out_1(MAC_out_19), .MAC_out_2(MAC_out_20), .MAC_out_3(MAC_out_21), 
                      .MAC_out_4(MAC_out_22), .MAC_out_5(MAC_out_23), .bias_0(32'b11111111111111111111111111110100), .bias_1(32'b11111111111111111111111111110010), .bias_2(32'b11111111111111111111111111110111),
                      .bias_3(32'b11111111111111111111111111111100), .bias_4(32'b11111111111111111111111111111100), .bias_5(32'b00000000000000000000000000000100), .conv2_bias(conv2_bias_3), .out_0(conv1_mem_0_1_data_b),
                      .out_1(conv1_mem_1_1_data_b), .out_2(conv1_mem_2_1_data_b), .out_3(conv1_mem_3_1_data_b), .out_4(conv1_mem_4_1_data_b), .out_5(conv1_mem_5_1_data_b), .out_conv2(out_conv2_3));

logic signed [15:0] result_0, result_1, result_2, result_3, result_4, result_5, result_6, result_7, result_8, result_9;

demux_1to2 out_conv1_fc_demux_0(.data_in(after_MAC_0_out_0), .sel(FC_layer), .data_out_0(conv1_mem_0_0_data_a), .data_out_1(result_0));
demux_1to2 out_conv1_fc_demux_1(.data_in(after_MAC_0_out_1), .sel(FC_layer), .data_out_0(conv1_mem_1_0_data_a), .data_out_1(result_1));
demux_1to2 out_conv1_fc_demux_2(.data_in(after_MAC_0_out_2), .sel(FC_layer), .data_out_0(conv1_mem_2_0_data_a), .data_out_1(result_2));
demux_1to2 out_conv1_fc_demux_3(.data_in(after_MAC_0_out_3), .sel(FC_layer), .data_out_0(conv1_mem_3_0_data_a), .data_out_1(result_3));
demux_1to2 out_conv1_fc_demux_4(.data_in(after_MAC_0_out_4), .sel(FC_layer), .data_out_0(conv1_mem_4_0_data_a), .data_out_1(result_4));
demux_1to2 out_conv1_fc_demux_5(.data_in(after_MAC_0_out_5), .sel(FC_layer), .data_out_0(conv1_mem_5_0_data_a), .data_out_1(result_5));
demux_1to2 out_conv1_fc_demux_6(.data_in(after_MAC_1_out_0), .sel(FC_layer), .data_out_0(conv1_mem_0_0_data_b), .data_out_1(result_6));
demux_1to2 out_conv1_fc_demux_7(.data_in(after_MAC_1_out_1), .sel(FC_layer), .data_out_0(conv1_mem_1_0_data_b), .data_out_1(result_7));
demux_1to2 out_conv1_fc_demux_8(.data_in(after_MAC_1_out_2), .sel(FC_layer), .data_out_0(conv1_mem_2_0_data_b), .data_out_1(result_8));
demux_1to2 out_conv1_fc_demux_9(.data_in(after_MAC_1_out_3), .sel(FC_layer), .data_out_0(conv1_mem_3_0_data_b), .data_out_1(result_9));

demux_1to3 out_conv2_demux_0(.data_in(out_conv2_0), .sel(conv2_count), .data_out_0(conv2_mem_0_data), .data_out_1(conv2_mem_4_data), .data_out_2(conv2_mem_8_data)); //out img 0, 4, 8
demux_1to3 out_conv2_demux_1(.data_in(out_conv2_1), .sel(conv2_count), .data_out_0(conv2_mem_1_data), .data_out_1(conv2_mem_5_data), .data_out_2(conv2_mem_9_data)); //out img 1, 5, 9
demux_1to3 out_conv2_demux_2(.data_in(out_conv2_2), .sel(conv2_count), .data_out_0(conv2_mem_2_data), .data_out_1(conv2_mem_6_data), .data_out_2(conv2_mem_10_data)); //out img 2, 6, 10
demux_1to3 out_conv2_demux_3(.data_in(out_conv2_3), .sel(conv2_count), .data_out_0(conv2_mem_3_data), .data_out_1(conv2_mem_7_data), .data_out_2(conv2_mem_11_data)); //out img 3, 7, 11

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------------------------------------------------
//
//  POOLING (DONE)
//
//------------------------------------------------------------------------------------------------------------------------------------------------------

logic signed [15:0] pooling_0_a0, pooling_0_a1, pooling_0_b0, pooling_0_b1, 
                    pooling_1_a0, pooling_1_a1, pooling_1_b0, pooling_1_b1, 
                    pooling_2_a0, pooling_2_a1, pooling_2_b0, pooling_2_b1, 
                    pooling_3_a0, pooling_3_a1, pooling_3_b0, pooling_3_b1, 
                    pooling_4_a0, pooling_4_a1, pooling_4_b0, pooling_4_b1, 
                    pooling_5_a0, pooling_5_a1, pooling_5_b0, pooling_5_b1, 
                    pooling_6_a0, pooling_6_a1, pooling_6_b0, pooling_6_b1, 
                    pooling_7_a0, pooling_7_a1, pooling_7_b0, pooling_7_b1, 
                    pooling_8_a0, pooling_8_a1, pooling_8_b0, pooling_8_b1, 
                    pooling_9_a0, pooling_9_a1, pooling_9_b0, pooling_9_b1, 
                    pooling_10_a0, pooling_10_a1, pooling_10_b0, pooling_10_b1, 
                    pooling_11_a0, pooling_11_a1, pooling_11_b0, pooling_11_b1,
                    pooling_0_out, pooling_1_out, pooling_2_out, pooling_3_out,
                    pooling_4_out, pooling_5_out, pooling_6_out, pooling_7_out,
                    pooling_8_out, pooling_9_out, pooling_10_out, pooling_11_out; 
mux_2to1 pooling_mux_0_a0(.data_in_0(conv1_mem_0_0_q_a), .data_in_1(conv2_mem_0_0_q_a), .sel(pooling_layer), .data_out(pooling_0_a0));
mux_2to1 pooling_mux_0_a1(.data_in_0(conv1_mem_0_0_q_b), .data_in_1(conv2_mem_0_0_q_b), .sel(pooling_layer), .data_out(pooling_0_a1));
mux_2to1 pooling_mux_0_b0(.data_in_0(conv1_mem_0_1_q_a), .data_in_1(conv2_mem_0_1_q_a), .sel(pooling_layer), .data_out(pooling_0_b0));
mux_2to1 pooling_mux_0_b1(.data_in_0(conv1_mem_0_1_q_b), .data_in_1(conv2_mem_0_1_q_b), .sel(pooling_layer), .data_out(pooling_0_b1));
mux_2to1 pooling_mux_1_a0(.data_in_0(conv1_mem_0_2_q_a), .data_in_1(conv2_mem_1_0_q_a), .sel(pooling_layer), .data_out(pooling_1_a0));
mux_2to1 pooling_mux_1_a1(.data_in_0(conv1_mem_0_2_q_b), .data_in_1(conv2_mem_1_0_q_b), .sel(pooling_layer), .data_out(pooling_1_a1));
mux_2to1 pooling_mux_1_b0(.data_in_0(conv1_mem_0_3_q_a), .data_in_1(conv2_mem_1_1_q_a), .sel(pooling_layer), .data_out(pooling_1_b0));
mux_2to1 pooling_mux_1_b1(.data_in_0(conv1_mem_0_3_q_b), .data_in_1(conv2_mem_1_1_q_b), .sel(pooling_layer), .data_out(pooling_1_b1));
mux_2to1 pooling_mux_2_a0(.data_in_0(conv1_mem_1_0_q_a), .data_in_1(conv2_mem_2_0_q_a), .sel(pooling_layer), .data_out(pooling_2_a0));
mux_2to1 pooling_mux_2_a1(.data_in_0(conv1_mem_1_0_q_b), .data_in_1(conv2_mem_2_0_q_b), .sel(pooling_layer), .data_out(pooling_2_a1));
mux_2to1 pooling_mux_2_b0(.data_in_0(conv1_mem_1_1_q_a), .data_in_1(conv2_mem_2_1_q_a), .sel(pooling_layer), .data_out(pooling_2_b0));
mux_2to1 pooling_mux_2_b1(.data_in_0(conv1_mem_1_1_q_b), .data_in_1(conv2_mem_2_1_q_b), .sel(pooling_layer), .data_out(pooling_2_b1));
mux_2to1 pooling_mux_3_a0(.data_in_0(conv1_mem_1_2_q_a), .data_in_1(conv2_mem_3_0_q_a), .sel(pooling_layer), .data_out(pooling_3_a0));
mux_2to1 pooling_mux_3_a1(.data_in_0(conv1_mem_1_2_q_b), .data_in_1(conv2_mem_3_0_q_b), .sel(pooling_layer), .data_out(pooling_3_a1));
mux_2to1 pooling_mux_3_b0(.data_in_0(conv1_mem_1_3_q_a), .data_in_1(conv2_mem_3_1_q_a), .sel(pooling_layer), .data_out(pooling_3_b0));
mux_2to1 pooling_mux_3_b1(.data_in_0(conv1_mem_1_3_q_b), .data_in_1(conv2_mem_3_1_q_b), .sel(pooling_layer), .data_out(pooling_3_b1));
mux_2to1 pooling_mux_4_a0(.data_in_0(conv1_mem_2_0_q_a), .data_in_1(conv2_mem_4_0_q_a), .sel(pooling_layer), .data_out(pooling_4_a0));
mux_2to1 pooling_mux_4_a1(.data_in_0(conv1_mem_2_0_q_b), .data_in_1(conv2_mem_4_0_q_b), .sel(pooling_layer), .data_out(pooling_4_a1));
mux_2to1 pooling_mux_4_b0(.data_in_0(conv1_mem_2_1_q_a), .data_in_1(conv2_mem_4_1_q_a), .sel(pooling_layer), .data_out(pooling_4_b0));
mux_2to1 pooling_mux_4_b1(.data_in_0(conv1_mem_2_1_q_b), .data_in_1(conv2_mem_4_1_q_b), .sel(pooling_layer), .data_out(pooling_4_b1));
mux_2to1 pooling_mux_5_a0(.data_in_0(conv1_mem_2_2_q_a), .data_in_1(conv2_mem_5_0_q_a), .sel(pooling_layer), .data_out(pooling_5_a0));
mux_2to1 pooling_mux_5_a1(.data_in_0(conv1_mem_2_2_q_b), .data_in_1(conv2_mem_5_0_q_b), .sel(pooling_layer), .data_out(pooling_5_a1));
mux_2to1 pooling_mux_5_b0(.data_in_0(conv1_mem_2_3_q_a), .data_in_1(conv2_mem_5_1_q_a), .sel(pooling_layer), .data_out(pooling_5_b0));
mux_2to1 pooling_mux_5_b1(.data_in_0(conv1_mem_2_3_q_b), .data_in_1(conv2_mem_5_1_q_b), .sel(pooling_layer), .data_out(pooling_5_b1));
mux_2to1 pooling_mux_6_a0(.data_in_0(conv1_mem_3_0_q_a), .data_in_1(conv2_mem_6_0_q_a), .sel(pooling_layer), .data_out(pooling_6_a0));
mux_2to1 pooling_mux_6_a1(.data_in_0(conv1_mem_3_0_q_b), .data_in_1(conv2_mem_6_0_q_b), .sel(pooling_layer), .data_out(pooling_6_a1));
mux_2to1 pooling_mux_6_b0(.data_in_0(conv1_mem_3_1_q_a), .data_in_1(conv2_mem_6_1_q_a), .sel(pooling_layer), .data_out(pooling_6_b0));
mux_2to1 pooling_mux_6_b1(.data_in_0(conv1_mem_3_1_q_b), .data_in_1(conv2_mem_6_1_q_b), .sel(pooling_layer), .data_out(pooling_6_b1));
mux_2to1 pooling_mux_7_a0(.data_in_0(conv1_mem_3_2_q_a), .data_in_1(conv2_mem_7_0_q_a), .sel(pooling_layer), .data_out(pooling_7_a0));
mux_2to1 pooling_mux_7_a1(.data_in_0(conv1_mem_3_2_q_b), .data_in_1(conv2_mem_7_0_q_b), .sel(pooling_layer), .data_out(pooling_7_a1));
mux_2to1 pooling_mux_7_b0(.data_in_0(conv1_mem_3_3_q_a), .data_in_1(conv2_mem_7_1_q_a), .sel(pooling_layer), .data_out(pooling_7_b0));
mux_2to1 pooling_mux_7_b1(.data_in_0(conv1_mem_3_3_q_b), .data_in_1(conv2_mem_7_1_q_b), .sel(pooling_layer), .data_out(pooling_7_b1));
mux_2to1 pooling_mux_8_a0(.data_in_0(conv1_mem_4_0_q_a), .data_in_1(conv2_mem_8_0_q_a), .sel(pooling_layer), .data_out(pooling_8_a0));
mux_2to1 pooling_mux_8_a1(.data_in_0(conv1_mem_4_0_q_b), .data_in_1(conv2_mem_8_0_q_b), .sel(pooling_layer), .data_out(pooling_8_a1));
mux_2to1 pooling_mux_8_b0(.data_in_0(conv1_mem_4_1_q_a), .data_in_1(conv2_mem_8_1_q_a), .sel(pooling_layer), .data_out(pooling_8_b0));
mux_2to1 pooling_mux_8_b1(.data_in_0(conv1_mem_4_1_q_b), .data_in_1(conv2_mem_8_1_q_b), .sel(pooling_layer), .data_out(pooling_8_b1));
mux_2to1 pooling_mux_9_a0(.data_in_0(conv1_mem_4_2_q_a), .data_in_1(conv2_mem_9_0_q_a), .sel(pooling_layer), .data_out(pooling_9_a0));
mux_2to1 pooling_mux_9_a1(.data_in_0(conv1_mem_4_2_q_b), .data_in_1(conv2_mem_9_0_q_b), .sel(pooling_layer), .data_out(pooling_9_a1));
mux_2to1 pooling_mux_9_b0(.data_in_0(conv1_mem_4_3_q_a), .data_in_1(conv2_mem_9_1_q_a), .sel(pooling_layer), .data_out(pooling_9_b0));
mux_2to1 pooling_mux_9_b1(.data_in_0(conv1_mem_4_3_q_b), .data_in_1(conv2_mem_9_1_q_b), .sel(pooling_layer), .data_out(pooling_9_b1));
mux_2to1 pooling_mux_10_a0(.data_in_0(conv1_mem_5_0_q_a), .data_in_1(conv2_mem_10_0_q_a), .sel(pooling_layer), .data_out(pooling_10_a0));
mux_2to1 pooling_mux_10_a1(.data_in_0(conv1_mem_5_0_q_b), .data_in_1(conv2_mem_10_0_q_b), .sel(pooling_layer), .data_out(pooling_10_a1));
mux_2to1 pooling_mux_10_b0(.data_in_0(conv1_mem_5_1_q_a), .data_in_1(conv2_mem_10_1_q_a), .sel(pooling_layer), .data_out(pooling_10_b0));
mux_2to1 pooling_mux_10_b1(.data_in_0(conv1_mem_5_1_q_b), .data_in_1(conv2_mem_10_1_q_b), .sel(pooling_layer), .data_out(pooling_10_b1));
mux_2to1 pooling_mux_11_a0(.data_in_0(conv1_mem_5_2_q_a), .data_in_1(conv2_mem_11_0_q_a), .sel(pooling_layer), .data_out(pooling_11_a0));
mux_2to1 pooling_mux_11_a1(.data_in_0(conv1_mem_5_2_q_b), .data_in_1(conv2_mem_11_0_q_b), .sel(pooling_layer), .data_out(pooling_11_a1));
mux_2to1 pooling_mux_11_b0(.data_in_0(conv1_mem_5_3_q_a), .data_in_1(conv2_mem_11_1_q_a), .sel(pooling_layer), .data_out(pooling_11_b0));
mux_2to1 pooling_mux_11_b1(.data_in_0(conv1_mem_5_3_q_b), .data_in_1(conv2_mem_11_1_q_b), .sel(pooling_layer), .data_out(pooling_11_b1));

//12 pooling modules to be used by pooling layers
pooling pooling_0(.a_0(pooling_0_a0), .a_1(pooling_0_a1), .b_0(pooling_0_b0), .b_1(pooling_0_b1), .out(pooling_0_out));
pooling pooling_1(.a_0(pooling_1_a0), .a_1(pooling_1_a1), .b_0(pooling_1_b0), .b_1(pooling_1_b1), .out(pooling_1_out));
pooling pooling_2(.a_0(pooling_2_a0), .a_1(pooling_2_a1), .b_0(pooling_2_b0), .b_1(pooling_2_b1), .out(pooling_2_out));
pooling pooling_3(.a_0(pooling_3_a0), .a_1(pooling_3_a1), .b_0(pooling_3_b0), .b_1(pooling_3_b1), .out(pooling_3_out));
pooling pooling_4(.a_0(pooling_4_a0), .a_1(pooling_4_a1), .b_0(pooling_4_b0), .b_1(pooling_4_b1), .out(pooling_4_out));
pooling pooling_5(.a_0(pooling_5_a0), .a_1(pooling_5_a1), .b_0(pooling_5_b0), .b_1(pooling_5_b1), .out(pooling_5_out));
pooling pooling_6(.a_0(pooling_6_a0), .a_1(pooling_6_a1), .b_0(pooling_6_b0), .b_1(pooling_6_b1), .out(pooling_6_out));
pooling pooling_7(.a_0(pooling_7_a0), .a_1(pooling_7_a1), .b_0(pooling_7_b0), .b_1(pooling_7_b1), .out(pooling_7_out));
pooling pooling_8(.a_0(pooling_8_a0), .a_1(pooling_8_a1), .b_0(pooling_8_b0), .b_1(pooling_8_b1), .out(pooling_8_out));
pooling pooling_9(.a_0(pooling_9_a0), .a_1(pooling_9_a1), .b_0(pooling_9_b0), .b_1(pooling_9_b1), .out(pooling_9_out));
pooling pooling_10(.a_0(pooling_10_a0), .a_1(pooling_10_a1), .b_0(pooling_10_b0), .b_1(pooling_10_b1), .out(pooling_10_out));
pooling pooling_11(.a_0(pooling_11_a0), .a_1(pooling_11_a1), .b_0(pooling_11_b0), .b_1(pooling_11_b1), .out(pooling_11_out));

demux_1to2 pooling_demux_out_0(.data_in(pooling_0_out), .sel(pooling_layer), .data_out_0(p1_mem_0_data_a), .data_out_1(P2_mem_0_data));
demux_1to2 pooling_demux_out_1(.data_in(pooling_1_out), .sel(pooling_layer), .data_out_0(p1_mem_0_data_b), .data_out_1(P2_mem_1_data));
demux_1to2 pooling_demux_out_2(.data_in(pooling_2_out), .sel(pooling_layer), .data_out_0(p1_mem_1_data_a), .data_out_1(P2_mem_2_data));
demux_1to2 pooling_demux_out_3(.data_in(pooling_3_out), .sel(pooling_layer), .data_out_0(p1_mem_1_data_b), .data_out_1(P2_mem_3_data));
demux_1to2 pooling_demux_out_4(.data_in(pooling_4_out), .sel(pooling_layer), .data_out_0(p1_mem_2_data_a), .data_out_1(P2_mem_4_data));
demux_1to2 pooling_demux_out_5(.data_in(pooling_5_out), .sel(pooling_layer), .data_out_0(p1_mem_2_data_b), .data_out_1(P2_mem_5_data));
demux_1to2 pooling_demux_out_6(.data_in(pooling_6_out), .sel(pooling_layer), .data_out_0(p1_mem_3_data_a), .data_out_1(P2_mem_6_data));
demux_1to2 pooling_demux_out_7(.data_in(pooling_7_out), .sel(pooling_layer), .data_out_0(p1_mem_3_data_b), .data_out_1(P2_mem_7_data));
demux_1to2 pooling_demux_out_8(.data_in(pooling_8_out), .sel(pooling_layer), .data_out_0(p1_mem_4_data_a), .data_out_1(P2_mem_8_data));
demux_1to2 pooling_demux_out_9(.data_in(pooling_9_out), .sel(pooling_layer), .data_out_0(p1_mem_4_data_b), .data_out_1(P2_mem_9_data));
demux_1to2 pooling_demux_out_10(.data_in(pooling_10_out), .sel(pooling_layer), .data_out_0(p1_mem_5_data_a), .data_out_1(P2_mem_10_data));
demux_1to2 pooling_demux_out_11(.data_in(pooling_11_out), .sel(pooling_layer), .data_out_0(p1_mem_5_data_b), .data_out_1(P2_mem_11_data));

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------

endmodule
