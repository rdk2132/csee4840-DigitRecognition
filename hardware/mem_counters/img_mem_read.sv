//img_mem_read is responsible for one conv1 output image and uses four output addresses in parallel. Each processes a quarter of the image, the offset between addresses is 28 * 24 / 4 = 168
// counter/addresser for input image memory read
module img_mem_read (input logic clk, reset, enable,
                     output logic [9:0] addr0, addr1, addr2, addr3, 
                     output logic done);

    //kernel row and column count
    logic [2:0] rowcount, columncount;
    //counter for position within image row
    logic [4:0] i_count;
    logic [3:0] delay;

    always_ff @(negedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            addr1 <= 10'b0010101000;
            addr2 <= 10'b0101010000;
            addr3 <= 10'b0111111000;
            i_count <= 5'b00000;
            delay <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if(delay == 4'b0000) begin
                if (i_count == 5'b10111 && rowcount == 3'b100 && columncount == 3'b100) begin
                    //done with applying the kernel over an entire image row, go to the next row
                    //Move addresses 4 rows up, 27 pixels back and 1 row down, i.e. -111
                    i_count <= 5'b00000;
                    columncount <= 3'b000;
                    rowcount <= 3'b000;
                    addr0 <= addr0 - 10'b0001101111;
                    addr1 <= addr1 - 10'b0001101111;
                    addr2 <= addr2 - 10'b0001101111;
                    addr3 <= addr3 - 10'b0001101111;
                end
                else if (rowcount == 3'b100 && columncount == 3'b100) begin
                    //done with a position for the kernel, move forward to the next position. Move 4 rows up, 4 pixels back and 1 pixel forward, i.e. -115
                    columncount <= 3'b000;
                    rowcount <= 3'b000;
                    addr0 <= addr0 - 10'b0001110011;
                    addr1 <= addr1 - 10'b0001110011;
                    addr2 <= addr2 - 10'b0001110011;
                    addr3 <= addr3 - 10'b0001110011;
                    i_count <= i_count + 5'b00001;
                end
                else if (columncount == 3'b100) begin
                    //kernel row has been processed, move addresses one row down and 4 pixels back, i.e. + 24
                    columncount <= 3'b000;
                    rowcount <= rowcount + 3'b001;
                    addr0 <= addr0 + 10'b0000011000;
                    addr1 <= addr1 + 10'b0000011000;
                    addr2 <= addr2 + 10'b0000011000;
                    addr3 <= addr3 + 10'b0000011000;
                end
                else begin
                    addr0 <= addr0 + 10'b0000000001;
                    addr1 <= addr1 + 10'b0000000001;
                    addr2 <= addr2 + 10'b0000000001;
                    addr3 <= addr3 + 10'b0000000001;
                    columncount <= columncount + 3'b001;
                end
            end
            else begin
                delay <= delay + 4'b0001;
            end
        end
    end
    always_comb begin
        if(addr3 == 10'b1100001111) begin
            done = 1'b1;
        end
        else begin
            done = 1'b0;
        end
    end
endmodule
