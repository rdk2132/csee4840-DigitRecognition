// counter/addresser for pooling 2 layer output memory write (done)
module P2_mem_write (input logic clk, reset, enable,
                        output logic [3:0] addr0,
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 4'b0001;
        end
    end
    
    always_comb begin
        //stop when addr1 == 4^2 - 1, i.e. we have processed the entire image
        if(addr1 == 4'b1111) begin
            done = 1'b1;
        end
    end

endmodule