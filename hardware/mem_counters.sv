// img_mem_write    : 
// img_mem_read     : 
// conv1_k_mem_read : done
// conv1_mem_write  : 
// conv1_mem_read   : 
// P1_mem_write     : 
// P1_mem_read      : 
// conv2_k_mem_read : 
// conv2_mem_write  : 
// conv2_mem_read   : 
// P2_mem_write     : 
// P2_mem_read      : 
// fc_mem_read      : done

// counter/addresser for input image memory write
module img_mem_write (input logic clk, reset, enable,
                        output logic [9:0] addr0,  
                        output logic done);

    always_ff @(posedge clk) begin
        if (reset == 1'b1) begin
            addr0 <= 10'b0000000000;
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

// counter/addresser for input image memory read
module img_mem_read (input logic clk, reset, enable,
                        output logic [9:0] addr0, addr1, addr2, addr3, 
                        output logic done);

    always_ff @(posedge clk) begin
        if (reset == 1'b1) begin
            addr0 <=;
            addr1 <=;
            addr2 <=;
            addr3 <=;
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

// counter/addresser for Convolution 1 layer weight memory read
module conv1_k_mem_read (input logic clk, reset, enable, 
                        output reg [5:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk) begin
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
        if(addr1 == 6'b110001)
            done = 1'b1;
    end

endmodule

// counter/addresser for Convolution 1 layer output memory write
module conv1_mem_write (input logic clk, reset, enable,
                        output logic [9:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for Convolution 1 layer output memory read
module conv1_mem_read (input logic clk, reset, enable,
                        output logic [9:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for pooling 1 layer output memory write
module P1_mem_write (input logic clk, reset, enable,
                        output logic [7:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for pooling 1 layer output memory read
module P1_mem_read (input logic clk, reset, enable,
                        output logic [7:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for Convolution 2 layer weight memory read
module conv2_k_mem_read (input logic clk, reset, enable,
                        output logic [4:0] addr0, addr1
                        output logic done);

    logic[1:0] section
    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for Convolution 2 layer output memory write
module conv2_mem_write (input logic clk, reset, enable,
                        output logic [6:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for Convolution 2 layer output memory read
module conv2_mem_read (input logic clk, reset, enable,
                        output logic [6:0] addr0, addr1
                        output logic done);

    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for pooling 2 layer output memory write
module P2_mem_write (input logic clk, reset, enable,
                        output logic [4:0] addr0, addr1, addr2, addr3,
                        output logic done);

    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for pooling 2 layer output memory read
module P2_mem_read (input logic clk, reset, enable,
                        output logic [4:0] addr0, addr1, addr2, addr3,
                        output logic done);

    always_ff @(posedge clk) begin
        if (enable == 1'b1 & done == 1'b0) begin

        end
    end
endmodule

// counter/addresser for Fully connected layer weight memory read
module fc_mem_read (input logic clk, reset, enable, 
                        output reg [8:0] addr0, addr1, 
                        output logic done);

    always_ff @(posedge clk) begin
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