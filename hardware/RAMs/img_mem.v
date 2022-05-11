//RAM module modified from quartus template
module img_mem ( input [9:0] address_a, address_b, 
				 input clock,
				 input [15:0] data_a, data_b, 
				 input wren_a, wren_b, 
				 output reg [15:0] q_a, q_b);

	reg [15:0] ram[1023:0];

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