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

// counter/addresser for input image memory write (done)
module img_mem_write (input logic clk, reset, enable, next, 
                      output reg [9:0] addr0,  
                      output logic done, ack);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
        end
        else if (enable == 1'b1 & done == 1'b0) begin
            addr0 <= addr0 + 1;
            ack <= 1'b1;
        end
        else if(next == 1'b1 & ack == 1'b1) begin
            ack <= 1'b0;
    end

    always_comb begin
        if(addr0 == 10'b1100010000) begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for input image memory read
module img_mem_read (input logic clk, reset, enable,
                     output reg [9:0] addr0, addr1, addr2, addr3, 
                     output logic done);

    logic [2:0] rowcount, columncount;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            addr1 <= 10'b0010101000;
            addr2 <= 10'b0101010000;
            addr3 <= 10'b0111111000;
        end
        else if (enable == 1'b1 & done == 1'b0) begin

        end
    end

    always_comb begin
        if(addr3 == == 10'b1100010000) begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Convolution 1 layer weight memory read (done)
module conv1_k_mem_read (input logic clk, reset, enable, 
                        output reg [5:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 6'b000000;
            addr1 <= 6'b011001;
        end
        else if (enable == 1'b1 & done == 1'b0) begin
            addr0 <= addr1 + 1;
            addr1 <= addr2 + 1;
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
                        output reg [9:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            addr1 <= 10'b0010010000;
        end
        else if (enable == 1'b1 & done == 1'b0) begin
            addr0 <= addr0 + 1;
            addr1 <= addr1 + 1;
        end
    end

    always_comb begin
        if(addr1 == 10'b1001000000) begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Convolution 1 layer output memory read (done?)
module conv1_mem_read (input logic clk, reset, enable,
                        output reg [9:0] addr0, addr1, addr2, addr3, 
                        output logic done);

    reg [3:0] row, count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
            addr1 <= 10'b0000000001;
            addr2 <= 10'b0000011000;
            addr3 <= 10'b0000011001;
            row <= 4'b0000;
            count <= 4'b0000;
        end
        else if (enable == 1'b1 & done == 1'b0) begin
            if(count == 4'b1100) begin
                row <= row + 1;
                count <= 4'b0000;
            end
            addr0 <= addr0 + 2 + (row * 24);
            addr1 <= addr1 + 2 + (row * 24);
            addr2 <= addr2 + 2 + (row * 24);
            addr3 <= addr3 + 2 + (row * 24);
            count <= count + 1;
        end
    end
    
    always_comb begin
        if(addr3 == 10'b1001000000) begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for pooling 1 layer output memory write (done)
module P1_mem_write (input logic clk, reset, enable,
                        output reg [7:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 8'b00000000;
            addr1 <= 8'b00000001;
        end
        else if (enable == 1'b1 & done == 1'b0) begin
            addr0 <= addr0 + 2;
            addr1 <= addr1 + 2;
        end
    end
    
    always_comb begin
        if(addr1 == 8'b10010000) begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for pooling 1 layer output memory read
module P1_mem_read (input logic clk, reset, enable,
                        output reg [7:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <=;
            addr1 <=;
        end
        else if (enable == 1'b1 & done == 1'b0) begin

        end
    end
    
    always_comb begin
        if() begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Convolution 2 layer weight memory read
module conv2_k_mem_read (input logic clk, reset, enable,
                        output reg [4:0] addr0, addr1
                        output logic done);

    logic[1:0] section
    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <=;
            addr1 <=;
        end
        else if (enable == 1'b1 & done == 1'b0) begin

        end
    end
    
    always_comb begin
        if() begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Convolution 2 layer output memory write
module conv2_mem_write (input logic clk, reset, enable,
                        output reg [6:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <=;
            addr1 <=;
        end
        else if (enable == 1'b1 & done == 1'b0) begin

        end
    end
    
    always_comb begin
        if() begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Convolution 2 layer output memory read
module conv2_mem_read (input logic clk, reset, enable,
                       output reg [6:0] addr0, addr1
                       output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <=;
            addr1 <=;
        end
        else if (enable == 1'b1 & done == 1'b0) begin

        end
    end
    
    always_comb begin
        if() begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for pooling 2 layer output memory write
module P2_mem_write (input logic clk, reset, enable,
                        output reg [4:0] addr0, addr1, addr2, addr3,
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <=;
            addr1 <=;
        end
        else if (enable == 1'b1 & done == 1'b0) begin

        end
    end
    
    always_comb begin
        if() begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for pooling 2 layer output memory read
module P2_mem_read (input logic clk, reset, enable,
                        output reg [4:0] addr0, addr1, addr2, addr3,
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <=;
            addr1 <=;
        end
        else if (enable == 1'b1 & done == 1'b0) begin

        end
    end
    
    always_comb begin
        if() begin
            done = 1'b1;
        end
    end

endmodule

// counter/addresser for Fully connected layer weight memory read (done)
module fc_mem_read (input logic clk, reset, enable, 
                        output reg [8:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            addr0 <= 9'b000000000;
            addr1 <= 9'b011000000;
        end
        else if (enable == 1'b1 & done == 1'b0) begin
            addr0 <= addr0 + 1;
            addr1 <= addr1 + 1;
        end
    end

    always_comb begin
        if(addr1 == 9'b101111111)
            done = 1'b1;
    end

endmodule