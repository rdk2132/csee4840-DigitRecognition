//Pooling module that takes the avg of 4 inputs
module pooling(input logic signed [15:0] a_0, a_1, b_0, b_1, 
              output logic signed [15:0] out);
    
    always_comb begin
        out = (a_0 + a_1 + b_0 + b_1) >> 2;
    end
endmodule