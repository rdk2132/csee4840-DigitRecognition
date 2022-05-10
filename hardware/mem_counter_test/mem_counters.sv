// img_mem_write    : done
// img_mem_read     : 
// conv1_k_mem_read : done
// conv1_mem_write  : done
// conv1_mem_read   : done?
// P1_mem_write     : done
// P1_mem_read      : 
// conv2_k_mem_read : 
// conv2_mem_write  : 
// conv2_mem_read   : 
// P2_mem_write     : 
// P2_mem_read      : 
// fc_mem_read      : done

// counter/addresser for input image memory write (done) //NOT NEEDED
module img_mem_write (input logic clk, reset, enable, next, 
                      output logic [9:0] addr0,  
                      output logic done, ack);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 1;
            ack <= 1'b1;
        end
        else if(next == 1'b1 && ack == 1'b1) begin
            ack <= 1'b0;
        end
    end

    always_comb begin
        if(addr0 == 10'b1100001111) begin
            done = 1'b1;
        end
    end

endmodule

//img_mem_read is responsible for one conv1 output image and uses four output addresses in parallel. Each processes a quarter of the image, the offset between addresses is 28 * 24 / 4 = 168
// counter/addresser for input image memory read
module img_mem_read (input logic clk, reset, enable,
                     output logic [9:0] addr0, addr1, addr2, addr3, 
                     output logic done);

    //kernel row and column count
    logic [2:0] rowcount, columncount;
    //counter for position within image row
    logic [4:0] i_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            addr1 <= 10'b0010101000;
            addr2 <= 10'b0101010000;
            addr3 <= 10'b0111111000;
            i_count <= 5'b00000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if (i_count == 5'b10111 && rowcount == 3'b100 && columncount == 3'b100) begin
                //done with applying the kernel over an entire image row, go to the next row
                //Move addresses 4 rows up, 27 pixels back and 1 row down, i.e. -111
                i_count <= 5'b0000;
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
    end

    always_comb begin
        if(addr3 == 10'b1100001111) begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Convolution 1 layer weight memory read (done)
module conv1_k_mem_read (input logic clk, reset, enable, 
                        output logic [5:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 6'b000000;
            addr1 <= 6'b011001;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 6'b000001;
            addr1 <= addr1 + 6'b000001;
        end
    end

    always_comb begin
        if(addr1 == 6'b110001) begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Convolution 1 layer output memory write (done)
module conv1_mem_write (input logic clk, reset, enable,
                        output logic [9:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            addr1 <= 10'b0010010000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 10'b0000000001;
            addr1 <= addr1 + 10'b0000000001;
        end
    end

    always_comb begin
        if(addr1 == 10'b1000111111) begin
            done = 1'b1;
        end
    end

endmodule

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

//P1_mem_read is responsible for one conv2 output image and uses two output addresses in parallel. Each processes half of the image, the offset between addresses is 12 * 8 / 2 = 48
// counter/addresser for pooling 1 layer output memory read
module P1_mem_read (input logic clk, reset, enable,
                        output logic [7:0] addr0, addr1,
                        output logic done);
    //kernel row and column count
    logic [2:0] rowcount, columncount;
    //counter for position within image row
    logic [2:0] i_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 8'b00000000;
            addr1 <= 8'b00110000;
            i_count <= 3'b000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if (i_count == 3'b111 && rowcount == 3'b100 && columncount == 3'b100) begin
                //done with applying the kernel over an entire image row, go to the next row
                //Move addresses 4 rows up, 11 pixels back and 1 row down, i.e. -47
                i_count <= 3'b000;
                columncount <= 3'b000;
                rowcount <= 3'b000;
                addr0 <= addr0 - 8'b00101111;
                addr1 <= addr1 - 8'b00101111;
            end
            else if (rowcount == 3'b100 && columncount == 3'b100) begin
                //done with a position for the kernel, move forward to the next position. Move 4 rows up, 4 pixels back and 1 pixel forward, i.e. -51
                columncount <= 3'b000;
                rowcount <= 3'b000;
                addr0 <= addr0 - 8'b00110011;
                addr1 <= addr1 - 8'b00110011;
                i_count <= i_count + 3'b001;
            end
            else if (columncount == 3'b100) begin
                //kernel row has been processed, move addresses one row down and 4 pixels back, i.e. + 8
                columncount <= 3'b000;
                rowcount <= rowcount + 3'b001;
                addr0 <= addr0 + 8'b00001000;
                addr1 <= addr1 + 8'b00001000;
            end
            else begin
                addr0 <= addr0 + 8'b00000001;
                addr1 <= addr1 + 8'b00000001;
                columncount <= columncount + 3'b001;
            end
        end
    end
    
    always_comb begin
        if(addr1 == 8'b10001111) begin
            done = 1'b1;
        end
    end

endmodule

//Module used to provide access to 6 kernels with two counters at once
// counter/addresser for Convolution 2 layer weight memory read
module conv2_k_mem_read (input logic clk, reset, enable,
                        output logic [7:0] addr0, addr1,
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 8'b00000000;
            addr1 <= 8'b01001011;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 8'b00000001;
            addr1 <= addr1 + 8'b00000001;
        end
    end
    
    always_comb begin
        //Count until addr1 reaches end of 6th kernel, i.e. 6 * 25 - 1 = 149
        if(addr1 == 8'b10010101) begin
            done = 1'b1;
        end
    end

endmodule

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

// counter/addresser for Convolution 2 layer output memory read (done)
module conv2_mem_read (input logic clk, reset, enable,
                        output logic [5:0] addr0, addr1, addr2, addr3,
                        output logic done);

    logic [1:0] count;
    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 6'b000000;
            addr1 <= 6'b000001;
            addr2 <= 6'b001000;
            addr3 <= 6'b001001;
            count <= 2'b00;
        end

        else if (enable == 1'b1 && done == 1'b0) begin
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
    end
    
    always_comb begin
        //stop when addr3 == 8^2 - 1, i.e. we have processed the entire image
        if(addr3 == 6'b111111) begin
            done = 1'b1;
        end
    end

endmodule

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
        if(addr0 == 4'b1111) begin
            done = 1'b1;
        end
    end

endmodule

//cycle through 4x4 input images 12 times
// counter/addresser for pooling 2 layer output memory read
module P2_mem_read (input logic clk, reset, enable,
                        output logic [3:0] addr0,
                        output logic done);
    logic [3:0] count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            count <= 4'b0000;
            addr0 <= 4'b0000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            if(addr0 == 4'b1111) begin
                count <= count + 4'b0001;
                addr0 <= 4'b0000;
            end
            else begin
                addr0 <= addr0 + 4'b0001;
            end
        end
    end

    always_comb begin
        if(count == 4'b1011 && addr0 == 4'b1111) begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Fully connected layer weight memory read (done)
module fc_mem_read (input logic clk, reset, enable, 
                        output logic [8:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 9'b000000000;
            addr1 <= 9'b011000000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin
            addr0 <= addr0 + 9'b000000001;
            addr1 <= addr1 + 9'b000000001;
        end
    end

    always_comb begin
        if(addr1 == 9'b101111111)
            done = 1'b1;
    end

endmodule