//weird thing that quartus made
module signed_multiply_accumulate (input clk, aclr, clken, sload,
	                               input signed [15:0] dataa, datab, 
	                               output reg signed [32:0] adder_out);

	// Declare registers and wires
	reg  signed [WIDTH-1:0] dataa_reg, datab_reg;
	reg  sload_reg;
	reg	 signed [32:0] old_result;
	wire signed [32:0] multa;

	// Store the results of the operations on the current data
	assign multa = dataa_reg * datab_reg;

	// Store (or clear) old results
	always @ (adder_out, sload_reg)
	begin
		if (sload_reg)
			old_result <= 0;
		else
			old_result <= adder_out;
	end

	// Clear or update data, as appropriate
	always @ (posedge clk or posedge aclr)
	begin
		if (aclr)
		begin
			dataa_reg <= 0;
			datab_reg <= 0;
			sload_reg <= 0;
			adder_out <= 0;
		end
		else if (clken)
		begin
			dataa_reg <= dataa;
			datab_reg <= datab;
			sload_reg <= sload;
			adder_out <= old_result + multa;
		end
	end
endmodule

module MAC (input logic clk, enable, reset, ReLU, bias_sel, 
			input signed [15:0] A, B, bias, 
			output reg signed [15:0] out);

	reg signed [31:0] MAC_out;
	wire signed [31:0] ReLU_out;

	always_ff @(posedge clk or posedge reset) begin
		if(reset == 1'b1) begin
			MAC_out <= 32'b00000000000000000000000000000000;
		end
		else if (enable == 1'b1) begin
			MAC_out <= out + (A * B);
		end	
	end

	always_comb begin
		if(ReLU == 1'b1) begin
			if(MAC_out[31] == 1'b1) begin
				ReLU_out = 32'b00000000000000000000000000000000;
			end
		end
		else begin
			ReLU_out = MAC_out;
		end
		if(bias_sel == 1'b1) begin
			out = ReLU_out[15:0] + bias >> 4;
		end
		else begin
			out = ReLU_out[15:0] + bias >> 4;
	end
endmodule