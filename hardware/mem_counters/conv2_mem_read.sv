// counter/addresser for Convolution 2 layer output memory read (done)
module conv2_mem_read (input logic clk, reset, enable,
                        output logic [5:0] addr0, addr1, addr2, addr3,
                        output logic done);

    logic [1:0] count;
    logic [3:0] delay;

    always_ff @(negedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 6'b000000;
            addr1 <= 6'b000001;
            addr2 <= 6'b001000;
            addr3 <= 6'b001001;
            count <= 2'b00;
            delay <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if(delay == 4'b0000) begin
                if(count == 2'b11) begin
                    count <= 2'b00;
                    addr0 <= addr0 + 6'b001010;
                    addr1 <= addr1 + 6'b001010;
                    addr2 <= addr2 + 6'b001010;
                    addr3 <= addr3 + 6'b001010;
                end
                else begin
                    addr0 <= addr0 + 6'b000010;
                    addr1 <= addr1 + 6'b000010;
                    addr2 <= addr2 + 6'b000010;
                    addr3 <= addr3 + 6'b000010;
                    count <= count + 2'b01;
                end
            end
            else begin
                delay <= delay + 4'b0001;
            end
        end
    end

    always_comb begin
        if( addr3 == 6'b111111) begin 
            done = 1'b1;
        end
        else begin 
            done = 1'b0;
        end
    end 
endmodule
