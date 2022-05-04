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
    logic [15:0] waddr, raddr;
    logic wren, done;

    testMem memory(
            .clock(clk),
            .data(writedata),
            .rdaddress(raddr),
            .wraddress(waddr),
            .wren(wren),
            .q(readdata)
            );
    
    always_ff @(posedge clk) begin
        if (reset) begin
            done <= 0;
            wren <= 0;
            raddr <= 16'd0;
            waddr <= 16'd0;
        end
        else if (chipselect && (write | read)) begin
            case (address)
                5'h3: begin
                    if (write && (done == 0)) begin
                        wren <= 1;
                        waddr <= waddr + 16'd1;
                    end
                    else wren <= 0;
                    if (waddr == 16'd25) begin
                        done <= 1;
                        waddr <= 16'd0;
                    end
                end
                5'h4: begin
                    if (read && done) begin
                        raddr <= raddr + 16'd1;
                    end
                    if (raddr == 16'd10) begin
                        done <= 0;
                        raddr <= 16'd0;
                    end
                end
            endcase
        end
    end
endmodule
