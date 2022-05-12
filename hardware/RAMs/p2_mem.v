//RAM module modified from quartus template
module p2_mem ( input [3:0] address, 
				   input clock,
				   input [15:0] data,
				   input wren,
				   output reg [15:0] q);

	reg [15:0] ram[15:0];

	always @ (posedge clock)
	begin
		if (wren) 
		begin
			ram[address] <= data;

		end
    q <= ram[address];
	end
    

endmodule
