//list of muxes and demuxes needed. Can be added to as they all follow a similar pattern

//4to1 mux
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
            default: data_out = 0;
        endcase
    end
endmodule

            default: data_out = 0;
module mux2to1 (parameter WORD_SIZE = 16)
               (input logic [WORD_SIZE - 1:0] data_in_0, data_in_1
                input logic sel
                output logic [WORD_SIZE - 1:0] data_out);
    alway_comb begin
        case (sel)
            1'd0: data_out = data_in_0;
            1'd1: data_out = data_in_1;
            default: data_out = 0;
        endcase
    end
endmodule

//1to4 demux
module demux1to4 (parameter WORD_SIZE = 16)
                 (input logic [WORD_SIZE - 1:0] data_in
                  input logic [1:0] sel
                  output logic [WORD_SIZE - 1:0] data_out_0, data_out_1, data_out_2, data_out_3);

    always_comb begin
        case (sel)
            2'd0: data_out_0 = data_in;
            2'd1: data_out_1 = data_in;
            2'd2: data_out_2 = data_in;
            2'd3: data_out_3 = data_in;
            default: data_out_0 = data_out_1 = data_out_2 = data_out_3 = 0;
        endcase
    end
endmodule

module demux1to2 (parameter WORD_SIZE = 16)
                 (input logic [WORD_SIZE - 1:0] data_in
                  input logic sel
                  output logic [WORD_SIZE - 1:0] data_out_0, data_out_1;

    always_comb begin
        case (sel)
            2'd0: data_out_0 = data_in;
            2'd1: data_out_1 = data_in;
            default: data_out_0 = data_out_1 = 0;
        endcase
    end
endmodule