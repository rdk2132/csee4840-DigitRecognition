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
