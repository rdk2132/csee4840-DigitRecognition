module fc_g3_mem ( input [8:0] address_a, address_b,
					    input clock, 
					    output reg [15:0] q_a, q_b);

	// Declare the ROM variable
	reg [15:0] rom[511:0];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file dual_port_rom_init.txt.  Without this file,
	// this design will not compile.
	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file.

	initial
	begin
		$readmemh("init/fc_g3.txt", rom);
	end

	always @ (posedge clock)
	begin
		q_a <= rom[address_a];
		q_b <= rom[address_b];
	end

endmodule