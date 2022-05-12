// counter/addresser for pooling 1 layer output memory write (done)
module P1_mem_write (input logic clk, reset, enable,
                        output logic [7:0] addr0, addr1,
                        output logic done);

    logic [3:0] delay;

    always_ff @(negedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 8'b00000000;
            addr1 <= 8'b01001000;
            delay <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if(delay == 4'b0001) begin
                addr0 <= addr0 + 8'b00000001;
                addr1 <= addr1 + 8'b00000001;
            end
            else begin
                delay <= delay + 4'b0001;
            end
        end
    end
    
    always_comb begin
        if(addr1 == 8'b10001111) begin
            done = 1'b1;
        end
        else begin
            done = 1'b0;
        end
    end

endmodule
