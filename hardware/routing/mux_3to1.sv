module mux_3to1 #(parameter WORD_SIZE = 16) 
                 (input logic [WORD_SIZE - 1 : 0] data_in_0, data_in_1, data_in_2,
                  input logic [1:0] sel, 
                  output logic [WORD_SIZE - 1 : 0] data_out);

    always_comb begin
        case (sel)
            2'b00: data_out = data_in_0;
            2'b01: data_out = data_in_1;
            2'b10: data_out = data_in_2;
            default: data_out = 16'b0000000000000000;
        endcase
    end
endmodule
