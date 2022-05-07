// counter/addresser for Convolution 1 layer output memory write (done)
module conv1_mem_write (input logic clk, reset, enable,
                        output logic [9:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            addr1 <= 10'b0010010000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 10'b0000000001;
            addr1 <= addr1 + 10'b0000000001;
        end
    end

    always_comb begin
        if(addr1 == 10'b1000111111) begin
            done = 1'b1;
        end
    end

endmodule