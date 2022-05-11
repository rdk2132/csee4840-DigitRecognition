//RAM module modified from quartus template
module p2_mem ( input [3:0] address, 
				   input clock,
				   input logic [15:0] data,
				   input wren,
				   output logic [15:0] q);

	reg [15:0] ram[15:0];

	always @ (posedge clock)
	begin
		if (wren) 
		begin
			ram[address] <= data;
			q <= data;
		end
		else 
		begin
			q <= ram[address];
		end 
	end 

endmodule
