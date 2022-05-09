module demux_1to3 (input logic [15:0] data_in,
                   input logic [1:0] sel,
                   output logic [15:0] data_out_0, data_out_1, data_out_2);

    always_comb begin
        case (sel)
            2'd0: data_out_0 = data_in;
            2'd1: data_out_1 = data_in;
            2'd2: data_out_2 = data_in;
            default: data_out_0 = 16'h0000;
        endcase
    end
endmodule
