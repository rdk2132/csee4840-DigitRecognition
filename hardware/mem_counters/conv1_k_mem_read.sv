// counter/addresser for Convolution 1 layer weight memory read (done)
module conv1_k_mem_read (input logic clk, reset, enable, 
                        output logic [5:0] addr0, addr1, 
                        output logic done);

    logic [3:0] delay;
    //TODO
    logic [5:0] count;
    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 6'b000000;
            addr1 <= 6'b011001;
            delay <= 4'b0000;
            count <= 6'b000000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if(delay == 4'b0000) begin
                if (addr1 == 6'b110001) begin
                  count <= count + 6'b000001;
                  addr0 <= 0;
                  addr1 <= 6'b011001;
                end
                else begin
                  addr0 <= addr0 + 6'b000001;
                  addr1 <= addr1 + 6'b000001;
                end
            end
            else begin
                delay <= delay + 4'b0001;
            end
        end
    end

    always_comb begin
        if(count == 6'b111111 && addr1 == 6'b110001) begin
            done = 1'b1;
        end
        else begin
            done = 1'b0;
        end
    end

endmodule
