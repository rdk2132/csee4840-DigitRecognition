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
        endcase
    end
endmodule

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
        endcase
    end
endmodule

module mux_2to1 (parameter WORD_SIZE = 16)
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

module demux_1to2 (parameter WORD_SIZE = 16)
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