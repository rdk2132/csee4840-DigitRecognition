module conv2_k_g1_mem ( input [7:0] address_a, address_b,
					    input clock, 
					    output reg [15:0] q_a, q_b);

	// Declare the ROM variable
	reg [15:0] rom[255:0];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file dual_port_rom_init.txt.  Without this file,
	// this design will not compile.
	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file.

	initial
	begin
		$readmemh("init/conv2_k_g1.txt", rom);
	end

	always @ (posedge clock)
	begin
		q_a <= rom[address_a];
		q_b <= rom[address_b];
	end

endmodule