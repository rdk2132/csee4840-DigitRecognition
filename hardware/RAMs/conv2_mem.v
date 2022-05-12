//RAM module modified from quartus template
module conv2_mem ( input [5:0] address_a, address_b, 
				   input clock,
				   input [15:0] data_a, data_b, 
				   input wren_a, wren_b, 
				   output reg [15:0] q_a, q_b);

	reg [15:0] ram[63:0];
  logic [15:0] debug_23, debug_24, debug_25, debug_26, debug_27, debug_28;
  
	// Port A 
	always @ (posedge clock)
	begin
		if (wren_a) 
		begin
			ram[address_a] <= data_a;
			q_a <= data_a;
		end
		else 
		begin
			q_a <= ram[address_a];
		end 
	end 

	// Port B 
	always @ (posedge clock)
	begin
    debug_23 <= ram[23];
    debug_24 <= ram[24];
    debug_25 <= ram[25];
    debug_26 <= ram[26];
    debug_27 <= ram[27];
    debug_28 <= ram[28];
		if (wren_b) 
		begin
			ram[address_b] <= data_b;
			q_b <= data_b;
		end
		else 
		begin
			q_b <= ram[address_b];
		end 
	end

endmodule
