// counter/addresser for pooling 1 layer output memory write (done)
module P1_mem_write (input logic clk, reset, enable,
                        output logic [7:0] addr0, addr1,
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 8'b00000000;
            addr1 <= 8'b01001000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 8'b00000001;
            addr1 <= addr1 + 8'b00000001;
        end
    end
    
    always_comb begin
        //stop when addr1 == 12^2 - 1, i.e. we have processed the entire image
        if(addr1 == 8'b10001111) begin
            done = 1'b1;
        end
    end

endmodule