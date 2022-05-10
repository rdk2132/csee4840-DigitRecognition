module testbench ( 
    input logic clk,
	input logic reset,
    input chipselect,
    input logic [3:0] address,
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
        .q(readdata));
 
    always_ff @(posedge clk) begin
        if (reset) begin
            raddr <= 5'd0;
            waddr <= 5'd0;
        end
        else if (chipselect && (write | read)) begin
            case (address)
                4'h0: readdata <= done;
                4'h1: state <= writedata;
                4'h2: waddr <= waddr + 5'd1;
                4'h3: raddr <= 5'h1;
                4'h4: raddr <= 5'h2;
                4'h5: raddr <= 5'h3;
                4'h6: raddr <= 5'h4;
                4'h7: raddr <= 5'h5;
                4'h8: raddr <= 5'h6;
                4'h9: raddr <= 5'h7;
                4'ha: raddr <= 5'h8;
                4'hb: raddr <= 5'h9;
                4'hc: raddr <= 5'h0;
                default: raddr <= 0;
            endcase
        end

        if (waddr == 5'd25) begin
            waddr <= 5'd0;
        end
    end

endmodule
