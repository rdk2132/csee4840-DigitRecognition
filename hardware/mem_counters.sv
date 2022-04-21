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
module c1W_mem_counter (input logic clk, start
                        output logic [4:0] addr1, addr2
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Convolution 1 layer bias memory
module c1B_mem_counter (input logic clk, start
                        output logic [2:0] addr1, addr2
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Convolution 1 layer output memory
module c1O_mem_counter (input logic clk, start
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
module c2W_mem_counter (input logic clk, start
                        output logic [4:0] addr1, addr2
                        output logic done);

    logic[1:0] section
    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Convolution 2 layer bias memory
module c2B_mem_counter (input logic clk, start
                        output logic [6:0] addr1, addr2
                        output logic done);

    logic[1:0] section
    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Convolution 2 layer output memory
module c2O_mem_counter (input logic clk, start
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
module FCW_mem_counter (input logic clk, start
                        output logic [10:0] addr1, addr2
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule

// counter/addresser for Fully connected layer bias memory (Might need serious thought)
module FCB_mem_counter (input logic clk, start
                        output logic [5:0] addr1, addr2
                        output logic done);

    always_ff @( posedge clk ) begin
        if (start & !done) begin

        end
    end
endmodule