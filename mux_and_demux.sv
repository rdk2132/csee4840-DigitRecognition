//list of muxes and demuxes needed. Can be added to as they all follow a similar pattern

//4to1 mux
module mux4to1 (input logic [15:0] data_in_0, data_in_1, data_in_2, data_in_3
                input logic [1:0] sel
                output logic [15:0] data_out);

    always_comb begin
        case (sel)
            2'd0: data_out = data_in_0;
            2'd1: data_out = data_in_1;
            2'd2: data_out = data_in_2;
            2'd3: data_out = data_in_3;
            default: data_out = 16'b0000000000000000;
        endcase
    end
endmodule

//1to4 demux
module demux1to4 (input logic [15:0] data_in
                  input logic [1:0] sel
                  output logic [15:0] data_out_0, data_out_1, data_out_2, data_out_3);

    always_comb begin
        case (sel)
            2'd0: data_out_0 = data_in;
            2'd1: data_out_1 = data_in;
            2'd2: data_out_2 = data_in;
            2'd3: data_out_3 = data_in;
            default: data_out_0 = data_out_1 = data_out_2 = data_out_3 = 16'b0000000000000000;
        endcase
    end
endmodule