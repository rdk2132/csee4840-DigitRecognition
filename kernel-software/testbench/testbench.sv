module testbench (
    input logic clk,
	input logic reset,
    input chipselect,
    input logic [15:0] writedata,
    input logic [2:0] address,
	input logic write,
    output logic [15:0] outdata,
    output logic done
);
    logic [399:0] image;
    var counter = 0;

    always_ff @(posedge clk)
        if (reset) begin
            image <= 0;
            done <= 0;
        end
        else if (chipselect && write) begin
            case (address)
            5'h3: begin
                image[counter+15:counter] <= writedata;
                counter = counter + 16;
                if (counter == 400) done <= 1;
            end
            endcase
        end



endmodule