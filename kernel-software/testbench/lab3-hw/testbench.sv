module testbench ( 
    input logic clk,
	input logic reset,
    input chipselect,
    input logic [2:0] address,
    input logic read,
	input logic write,
    input logic [15:0] writedata,
    output logic [15:0] readdata
);
    logic [4:0] waddr, raddr;

    twoport4 memory(
            .clk(clk),
            .ra(raddr),
            .wa(waddr),
            .write(write),
            .d(writedata),
            .q(readdata)
            );
    
    always_ff @(posedge clk) begin
        if (reset) begin
            raddr <= 5'd0;
            waddr <= 5'd0;
        end
        else if (chipselect && (write | read)) begin
            case (address)
                3'h2: waddr <= waddr + 5'd1;
                3'h3: raddr <= raddr + 5'd1;
            endcase
        end
        if (raddr == 5'd11)
            raddr <= 5'd0;

        if (waddr == 5'd26)
            waddr <= 5'd0;
    end
endmodule
