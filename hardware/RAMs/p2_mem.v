//RAM module modified from quartus template
module p2_mem ( input [3:0] address, 
				   input clock,
				   input [15:0] data,
				   input wren,
				   output [15:0] q);

	reg [15:0] ram[15:0];
    reg[3:0] address_reg;

	always @ (posedge clock)
	begin
		if (wren) 
		begin
			ram[address] <= data;
            address_reg <= address;
		end
	end
    
    assign q = ram[address_reg];

endmodule
