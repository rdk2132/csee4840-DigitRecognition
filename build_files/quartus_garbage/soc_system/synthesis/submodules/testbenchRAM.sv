module twoport4(
    input logic clk,
    input logic [4:0] ra, wa,
    input logic write,
    input logic [15:0] d,
    output logic [15:0] q);

logic [15:0] mem [31:0];

always_ff @(posedge clk) begin
    if (write) mem[wa] <= d;
    q <= mem[ra];
end

endmodule
