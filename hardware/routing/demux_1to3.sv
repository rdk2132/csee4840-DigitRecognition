module demux_1to3 (input logic [15:0] data_in,
                   input logic [1:0] sel,
                   output logic [15:0] data_out_0, data_out_1, data_out_2);

    always_comb begin
        case (sel)
            2'd0: begin
                data_out_0 = data_in;
                data_out_1 = 16'b0000000000000000;
                data_out_2 = 16'b0000000000000000;
            end
            2'd1: begin
                data_out_0 = 16'b0000000000000000;
                data_out_1 = data_in;
                data_out_2 = 16'b0000000000000000;
            end
            2'd2: begin 
                data_out_0 = 16'b0000000000000000;
                data_out_1 = 16'b0000000000000000;
                data_out_2 = data_in;
            end
            default: begin
                data_out_0 = 16'b0000000000000000;
                data_out_1 = 16'b0000000000000000;
                data_out_2 = 16'b0000000000000000;
            end
        endcase
    end
endmodule
