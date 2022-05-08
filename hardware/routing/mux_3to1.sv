module mux_3to1 (input logic [15:0] data_in_0, data_in_1, data_in_2, 
                 input logic [1:0] sel, 
                 output logic [15:0] data_out);

    always_comb begin
        case (sel)
            2'b00: data_out = data_in_0;
            2'b01: data_out = data_in_1;
            2'b10: data_out = data_in_2;
        endcase
    end
endmodule