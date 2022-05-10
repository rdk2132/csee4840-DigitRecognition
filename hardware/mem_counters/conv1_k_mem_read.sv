// counter/addresser for Convolution 1 layer weight memory read (done)
module conv1_k_mem_read (input logic clk, reset, enable, 
                        output logic [5:0] addr0, addr1, 
                        output logic done);

    logic [3:0] delay;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 6'b000000;
            addr1 <= 6'b011001;
            delay <= 4'b0000;
            done <= 0;
        end
        else if (enable == 1'b1 && done == 1'b0 && delay == 4'b0000) begin
            addr0 <= addr0 + 6'b000001;
            addr1 <= addr1 + 6'b000001;
        end
        else if(addr1 == 6'b110001) begin
            done <= 1'b1;
        end
        else if (enable == 1'b1) begin
            delay <= delay + 4'b0001;
        end
    end
endmodule
