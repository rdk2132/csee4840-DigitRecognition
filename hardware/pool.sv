module avg2x2
  #(parameter 
      WORD_SIZE = 16)
  (input logic signed [WORD_SIZE - 1:0] a0,
   input logic signed [WORD_SIZE - 1:0] a1,
   input logic signed [WORD_SIZE - 1:0] b0,
   input logic signed [WORD_SIZE - 1:0] b1,
   output logic signed [WORD_SIZE - 1:0] poolavg);
  //TODO: Right shifting negative number may or may not work
  assign poolavg = (a0 + a1 + b0 + b1) >> 2;
  //TODO: This may or may not work due to two's complement, arithmetic right shift >>> should work
  //logic signed [WORD_SIZE - 1:0] imm;
  //assign imm = (a0 + a1 + b0 + b1);
  //assign poolavg = {imm[WORD_SIZE - 1], 2'b0, imm[WORD_SIZE - 4 : 0]};
endmodule


module pool (input logic clk, enable, read_write, cv1m_cv2m,
             input logic [15:0] data_a, data_b,
             input logic [9:0] address_a_conv1, address_b_conv1,
             input logic [9:0] address_a_conv2, address_b_conv2, 
             output logic [15:0] out_p1_0, out_p1_1, out_p2_0, out_p2_1);
  
  
  reg [15:0] reg1, reg2;
  reg count;
  logic [5:0] address_a_conv1_mux, address_b_conv1_mux, 
              address_a_conv2_mux, address_b_conv2_mux,
              address_a_count, address_b_count;

  logic [15:0] q_a_conv1, q_a_conv2, q_b_conv1, q_b_conv2, poolavg;

  avg2x2 avg (.a0(data_a), .a1(data_b), .b0(reg1), .b1(reg2), .poolavg);

  conv1_mem_read c1mr(.clk, );
  conv2_mem_read c2mr(.clk, );

  //memcounter work at half clock speed to acount for loading values
  P1_mem_write p1mw(.clk(count), );
  P2_mem_write p2mw(.clk(count), );

  conv1_mem conv1_mem_1(.address_a(address_a_conv1_mux),
                        .address_b(address_b_comv1_mux),
                        .clock(clk),
                        .data_a,
                        .data_b,
                        .rden_a(!read_write),
                        .rden_b(!read_write),
                        .wren_a(read_write & enable),
                        .wren_b(read_write & enable),
                        .q_a(q_a_conv_1),
                        .q_b(q_b_conv_1));

  conv1_mem conv1_mem_1(.address_a(address_a_conv2_mux),
                        .address_b(address_b_conv2_mux),
                        .clock(clk),
                        .data_a,
                        .data_b,
                        .rden_a(!read_write),
                        .rden_b(!read_write),
                        .wren_a(read_write & enable),
                        .wren_b(read_write & enable),
                        .q_a(q_a_conv_2),
                        .q_b(q_b_conv_2));

  initial begin
    address_a_feed = 0;
    address_b_feed = 0;
    reg1 = 0;
    reg2 = 0;
    count = 0;
  end

  always_ff @(posedge clk) begin
    //determine if you should calc or write
    if(read_write) begin
      address_a_feed = address_b;
      address_b_feed = address_b;
    end
    //calc if enabled
    else if(enable)begin
      address_a_feed = address_a_count;
      address_b_feed = address_b_count;

      //load values into regester if off clock
      if(!count) begin
        
      end

      //calculate output and write to memory
      else begin
        
      end

      //flip count at end
      count  = !count;
    end

  end

endmodule

