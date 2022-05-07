// counter/addresser for Convolution 1 layer output memory read (done?)
module conv1_mem_read (input logic clk, reset, enable,
                        output logic [9:0] addr0, addr1, addr2, addr3, 
                        output logic done);

    logic [3:0] count;
    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            addr1 <= 10'b0000000001;
            addr2 <= 10'b0000011000;
            addr3 <= 10'b0000011001;
            count <= 4'b0000;
        end
        
        else if (enable == 1'b1 && done == 1'b0) begin
            if(count == 4'b1011) begin
                count <= 4'b0000;
                addr0 <= addr0 + 10'b0000011010;
                addr1 <= addr1 + 10'b0000011010;
                addr2 <= addr2 + 10'b0000011010;
                addr3 <= addr3 + 10'b0000011010;
            end
            else begin    
                addr0 <= addr0 + 10'b0000000010;
                addr1 <= addr1 + 10'b0000000010;
                addr2 <= addr2 + 10'b0000000010;
                addr3 <= addr3 + 10'b0000000010;
                count <= count + 4'b0001;
            end
        end
    end
    
    always_comb begin
        //stop when addr3 == 24^2 - 1, i.e. we have processed the entire image
        if(addr3 == 10'b1000111111) begin
            done = 1'b1;
        end
    end

endmodule