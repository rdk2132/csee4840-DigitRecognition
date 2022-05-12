// counter/addresser for Convolution 1 layer output memory read (done?)
module conv1_mem_read (input logic clk, reset, enable,
                        output logic [8:0] addr0, addr1, addr2, addr3, 
                        output logic done);

    logic [3:0] count, delay;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 9'b000000000;
            addr1 <= 9'b000000001;
            addr2 <= 9'b000011000;
            addr3 <= 9'b000011001;
            count <= 4'b0000;
            delay <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if(delay == 4'b0000) begin
                if(count == 4'b1011) begin
                    count <= 4'b0000;
                    addr0 <= addr0 + 9'b000011010;
                    addr1 <= addr1 + 9'b000011010;
                    addr2 <= addr2 + 9'b000011010;
                    addr3 <= addr3 + 9'b000011010;
                end
                else begin    
                    addr0 <= addr0 + 9'b000000010;
                    addr1 <= addr1 + 9'b000000010;
                    addr2 <= addr2 + 9'b000000010;
                    addr3 <= addr3 + 9'b000000010;
                    count <= count + 4'b0001;
                end
            end
            else begin
                delay <= delay + 4'b0001;
            end
        end
    end

    always_comb begin
        if(addr3 == 9'b100011111) begin
            done = 1'b1;
        end
        else begin
            done = 1'b0;
        end
    end
endmodule
