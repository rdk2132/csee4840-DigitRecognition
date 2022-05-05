module ReLU_act
    #(parameter WORD_SIZE = 16)
    (input logic signed [WORD_SIZE -1]:0 in
    output logic signed [WORD_SIZE -1]:0 out);
    always_comb begin
        case(in[WORD_SIZE-1])
            1'b0: out = in;
            1'b1: out = 16'b0000000000000000
        endcase
    end
endmodule