// counter/addresser for input image memory
module img_mem_counter (input logic clk, start
                        output logic [9:0] addr1, addr2
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Convolution 1 layer weight memory
module conv1_k_mem_counter (input logic clk, start, 
                        output reg [5:0] addr1 = 6'b000000, 
                        output reg [5:0] addr2 = 6'b011001, 
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin
            addr1 <= addr1 + 1;
            addr2 <= addr2 + 1;
        end
    end

    always_comb begin
        if(addr2 == 6'b110001)
            done = 1'b1;
    end
endmodule

// counter/addresser for Convolution 1 layer output memory
module conv1_mem_counter (input logic clk, start
                        output logic [9:0] addr1, addr2
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for pooling 1 layer output memory
module P1_mem_counter (input logic clk, start
                        output logic [7:0] addr1, addr2
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Convolution 2 layer weight memory
module conv2_k_mem_counter (input logic clk, start
                        output logic [4:0] addr1, addr2
                        output logic done);

    logic[1:0] section
    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Convolution 2 layer output memory
module conv2_mem_counter (input logic clk, start
                        output logic [6:0] addr1, addr2
                        output logic done);

    logic[1:0] section
    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for pooling 2 layer output memory
module P2_mem_counter (input logic clk, start
                        output logic [4:0] addr1, addr2
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Fully connected layer weight memory (Might need serious thought)
module fc_mem_counter (input logic clk, start, 
                        output reg [8:0] addr1 = 9'b000000000, 
                        output reg [8:0] addr2 = 9'b011000000, 
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin
            addr1 <= addr1 + 1;
            addr2 <= addr2 + 1;
        end
    end

    always_comb begin
        if(addr2 == 9'b101111111)
            done = 1'b1;
    end
endmodule