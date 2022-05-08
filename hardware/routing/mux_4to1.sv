module mux4to1 (parameter WORD_SIZE = 16)
               (input logic [WORD_SIZE - 1:0] data_in_0, data_in_1, data_in_2, data_in_3
                input logic [1:0] sel
                output logic [WORD_SIZE - 1:0] data_out);

    always_comb begin
        case (sel)
            2'd0: data_out = data_in_0;
            2'd1: data_out = data_in_1;
            2'd2: data_out = data_in_2;
            2'd3: data_out = data_in_3;
        endcase
    end
endmodule