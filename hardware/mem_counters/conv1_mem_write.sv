// counter/addresser for Convolution 1 layer output memory write (done)
module conv1_mem_write (input logic clk, reset, enable,
                        output logic [8:0] addr0, addr1, 
                        output logic done);
    //Increment addresses every 25 cycles
    logic [3:0] delay;
    logic [4:0] clk_counter;

    always_ff @(negedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 9'b000000000;
            addr1 <= 9'b010010000;
            clk_counter <= 5'b00000;
            delay <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if(delay == 4'b0001) begin
                if (clk_counter == 5'b11000) begin
                    addr0 <= addr0 + 9'b0000000001;
                    addr1 <= addr1 + 9'b0000000001;
                    clk_counter <= 5'b00000;
                end
                else begin
                    clk_counter <= clk_counter + 5'b00001;
                end
            end
            else begin
                delay <= delay + 4'b0001;
            end
        end
    end

        always_comb begin
        if(addr1 == 9'b100011111) begin
            done = 1'b1;
        end
        else begin
            done = 1'b0;
        end
    end
endmodule
