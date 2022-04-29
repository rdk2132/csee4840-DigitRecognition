module testbench 
#(
    RAM_WORDS=25
    RAM_ADDR_BITS=5
)
(
    input logic clk,
	input logic reset,
    input chipselect,
    input logic [2:0] address,
    input logic read,
	input logic write,
    input logic [15:0] writedata,
    output logic [15:0] readdata,
    output logic done
);
    logic [15:0] mem[RAM_WORDS-1:0];
    logic [RAM_ADDR_BITS-1:0] addr;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            done <= 0;
            addr <= 16'd0;
            verify <= 0;
        end
        else if (chipselect && (write | read)) begin
            case (address)
                5'h3: begin
                    if (write && done == 0) begin
                        mem[addr] <= writedata + 5;
                        addr <= addr + 1;
                    end
                    if (addr == 16'd25) begin
                        done <= 1;
                        addr <= 16'd0;
                    end
                end
                5'h4: begin
                    if (read && done) begin
                        readdata <= mem[addr];
                        addr <= addr + 1;
                    end
                    if (addr == 16'd25) begin
                        done <= 0;
                        addr <= 16'd0;
                    end
                end
                default:
            endcase
        end
    end
    


endmodule