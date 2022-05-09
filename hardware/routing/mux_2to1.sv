module mux_2to1 #(parameter WORD_SIZE = 16)
               (input logic [WORD_SIZE - 1:0] data_in_0, data_in_1,
                input logic sel,
                output logic [WORD_SIZE - 1:0] data_out);
    always_comb begin
        case (sel)
            1'd0: data_out = data_in_0;
            1'd1: data_out = data_in_1;
        endcase
    end
endmodule