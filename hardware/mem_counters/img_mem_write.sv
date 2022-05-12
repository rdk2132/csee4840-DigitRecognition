// counter/addresser for input image memory write (done) //NOT NEEDED
module img_mem_write (input logic clk, reset, enable, next, 
                      output logic [9:0] addr0,  
                      output logic done, ack);

    logic [3:0] delay;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            delay <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0 && delay == 4'b0001) begin
            addr0 <= addr0 + 1;
            ack <= 1'b1;
        end
        else if(next == 1'b1 && ack == 1'b1) begin
            ack <= 1'b0;
        end
        else begin
            delay <= delay + 4'b0001;
        end
    end

    always_comb begin
        if(addr0 == 10'b1100001111) begin
            done = 1'b1;
        end
    end

endmodule