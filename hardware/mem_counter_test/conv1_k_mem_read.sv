// counter/addresser for Convolution 1 layer weight memory read (done)
module conv1_k_mem_read (input logic clk, reset, enable, 
                        output logic [5:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 6'b000000;
            addr1 <= 6'b011001;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 6'b000001;
            addr1 <= addr1 + 6'b000001;
        end
    end

    always_comb begin
        if(addr1 == 6'b110001) begin
            done = 1'b1;
        end
    end

endmodule