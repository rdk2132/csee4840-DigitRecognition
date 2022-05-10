module mux_12to1 (input logic [15:0] data_in_0, data_in_1, data_in_2, data_in_3, data_in_4, data_in_5, 
                                     data_in_6, data_in_7, data_in_8, data_in_9, data_in_10, data_in_11, 
                  input logic [3:0] sel, 
                  output logic [15:0] data_out);

    always_comb begin
        case (sel)
            4'b0000: data_out = data_in_0;
            4'b0001: data_out = data_in_1;
            4'b0010: data_out = data_in_2;
            4'b0011: data_out = data_in_3;
            4'b0100: data_out = data_in_4;
            4'b0101: data_out = data_in_5;
            4'b0110: data_out = data_in_6;
            4'b0111: data_out = data_in_7;
            4'b1000: data_out = data_in_8;
            4'b1001: data_out = data_in_9;
            4'b1010: data_out = data_in_10;
            4'b1011: data_out = data_in_11;
            default: data_out = 16'b0000000000000000;
        endcase
    end
endmodule
