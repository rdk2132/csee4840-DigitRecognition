//RAM module modified from quartus template
module conv1_mem ( input [8:0] address_a, address_b, 
				   input clock,
				   input [15:0] data_a, data_b, 
				   input wren_a, wren_b, 
				   output reg [15:0] q_a, q_b);

	reg [15:0] ram[511:0];
  logic [8:0] prev_addra, pprev_addra;
  logic [8:0] prev_addrb, pprev_addrb;
	// Port A 
	always @ (posedge clock)
	begin
    pprev_addra <= address_a;
    prev_addra <= pprev_addra;
		if (wren_a) 
		begin
			ram[prev_addra] <= data_a;
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
    pprev_addrb <= address_b;
    prev_addrb <= pprev_addrb;
    if (wren_b) 
		begin
			ram[prev_addrb] <= data_b;
			q_b <= data_b;
		end
		else 
		begin
			q_b <= ram[address_b];
		end 
	end

endmodule
