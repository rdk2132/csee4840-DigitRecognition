// counter/addresser for Fully connected layer weight memory read (done)
module fc_mem_read (input logic clk, reset, enable, 
                        output logic [8:0] addr0, addr1, 
                        output logic done);

    logic [3:0] delay;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 9'b000000000;
            addr1 <= 9'b011000000;
            delay <= 4'b0000;
            done <= 1'b0;
        end
        else if (enable == 1'b1 && done == 1'b0 && delay == 4'b0000) begin
            addr0 <= addr0 + 9'b000000001;
            addr1 <= addr1 + 9'b000000001;
        end
        else if(addr1 == 9'b101111111) begin
            done = 1'b1;
        end
        else if (enable == 1'b1) begin
            delay <= delay + 4'b0001;
        end
    end

endmodule