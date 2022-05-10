//Go through an 8x8 output image 3 times
// counter/addresser for Convolution 2 layer output memory write
module conv2_mem_write (input logic clk, reset, enable,
                        output logic [5:0] addr0,
                        output logic done);
    logic [1:0] count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 6'b000000;
            count <= 2'b00;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if(addr0 == 6'b111111) begin
                count <= count + 2'b01;
                addr0 <= 6'b000000;
            end
            else begin
                addr0 <= addr0 + 6'b000001;
            end
        end
    end
    
    always_comb begin
        if(count == 2'b10 && addr0 == 6'b111111) begin
            done = 1'b1;
        end
    end

endmodule