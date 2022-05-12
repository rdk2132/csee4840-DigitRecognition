//cycle through 4x4 input images 12 times
// counter/addresser for pooling 2 layer output memory read
module P2_mem_read (input logic clk, reset, enable,
                        output logic [3:0] addr0, count, 
                        output logic done);

    logic [3:0] delay;

    always_ff @(negedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            count <= 4'b0000;
            addr0 <= 4'b0000;
            delay <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if (delay == 4'b0000) begin
                if(addr0 == 4'b1111) begin
                    count <= count + 4'b0001;
                    addr0 <= 4'b0000;
                end
                else begin
                    addr0 <= addr0 + 4'b0001;
                end
            end
            else begin
                delay <= delay + 4'b0001;
            end
        end
    end

    always_comb begin
        if(count == 4'b1011 && addr0 == 4'b1111) begin
            done = 1'b1;
        end
        else begin
            done = 1'b0;
        end
    end

endmodule