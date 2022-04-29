module testbench 
#(
    RAM_WORDS=25
    RAM_ADDR_BITS=5
)
(
    input logic clk,
	input logic reset,
    input chipselect,
    input logic [15:0] writedata,
    input logic [2:0] address,
	input logic write,
    input logic read,
    output logic [15:0] outdata,
    output logic [4:0] verify,
    output logic done
);
    logic [15:0] mem[RAM_WORDS-1:0];
    logic [RAM_ADDR_BITS-1:0] addr;
    
    assign verify = addr;
    always_ff @(posedge clk) begin
        if (reset) begin
            done <= 0;
            addr <= 16'd0;
            verify <= 0;
        end
        else if (chipselect && write) begin
            case (address)
                5'h3: begin
                    if (write) mem[addr] <= writedata;
                    addr <= addr + 1;
                    if (addr == 16'd25) begin
                        done <= 1;
                        addr <= 16'd0;
                    end
                end
                5'h4: begin
                    if (read) outdata <= mem[addr];
                    addr <= addr + 1;
                    if (addr == 16'd25) begin
                        done <= 1;
                        addr <= 16'd0;
                    end
                end
                default:
            endcase
        end
    end
    


endmodule