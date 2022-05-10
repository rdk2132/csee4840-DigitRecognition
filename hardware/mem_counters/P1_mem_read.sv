//P1_mem_read is responsible for one conv2 output image and uses two output addresses in parallel. Each processes half of the image, the offset between addresses is 12 * 8 / 2 = 48
// counter/addresser for pooling 1 layer output memory read
module P1_mem_read (input logic clk, reset, enable,
                        output logic [7:0] addr0, 
                        output logic done);
    //kernel row and column count
    logic [2:0] rowcount, columncount;
    //counter for position within image row
    logic [2:0] i_count;
    logic [3:0] delay;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 8'b00000000;
            i_count <= 3'b000;
            delay <= 4'b0000;
            done <= 1'b0;
        end
        else if (enable == 1'b1 && done == 1'b0 && delay == 4'b0000) begin
            if (i_count == 3'b111 && rowcount == 3'b100 && columncount == 3'b100) begin
                //done with applying the kernel over an entire image row, go to the next row
                //Move addresses 4 rows up, 11 pixels back and 1 row down, i.e. -47
                i_count <= 3'b000;
                columncount <= 3'b000;
                rowcount <= 3'b000;
                addr0 <= addr0 - 8'b00101111;
            end
            else if (rowcount == 3'b100 && columncount == 3'b100) begin
                //done with a position for the kernel, move forward to the next position. Move 4 rows up, 4 pixels back and 1 pixel forward, i.e. -51
                columncount <= 3'b000;
                rowcount <= 3'b000;
                addr0 <= addr0 - 8'b00110011;
                i_count <= i_count + 3'b001;
            end
            else if (columncount == 3'b100) begin
                //kernel row has been processed, move addresses one row down and 4 pixels back, i.e. + 8
                columncount <= 3'b000;
                rowcount <= rowcount + 3'b001;
                addr0 <= addr0 + 8'b00001000;
            end
            else begin
                addr0 <= addr0 + 8'b00000001;
                columncount <= columncount + 3'b001;
            end
        end
        else if (enable == 1'b1) begin
            delay <= delay + 4'b0001;
        end
        if(addr0 == 8'b10001111) begin
            done <= 1'b1;
        end
    end
endmodule
