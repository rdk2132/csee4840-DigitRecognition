module MAC (input logic clk, enable, reset, 
			input logic [1:0] MAC_layer, 
			input logic signed [15:0] A, B,  
			output logic signed [31:0] out);
	
	reg signed [31:0] MAC_out;
	reg [7:0] count;

	always_ff @(posedge clk or posedge reset) begin
		if(reset == 1'b1) begin
			MAC_out <= 32'b00000000000000000000000000000000;
			out <= 32'b00000000000000000000000000000000;
			count <= 8'b00000000;
		end
		else if (enable == 1'b1) begin
			if((count == 8'b00011001 && (MAC_layer == 2'b00 || MAC_layer == 2'b01)) || (count == 8'b11000000 && MAC_layer == 2'b10)) begin //if finished with a conv(count = 25) or one of the FC(count = 192) outputs the result
				out <= MAC_out;
				MAC_out <= 32'b00000000000000000000000000000000;
				count <= 8'b00000000;
			end
			else begin
				MAC_out <= MAC_out + (A * B); //does the MAC thing
				out <= 32'b00000000000000000000000000000000;
				count <= count + 1'b1;
			end
		end
	end
endmodule

/*
//weird thing that quartus made
module signed_multiply_accumulate (input clk, aclr, clken, sload,
	                               input signed [15:0] dataa, datab, 
	                               output reg signed [31:0] adder_out);

	// Declare registers and wires
	reg  signed [15:0] dataa_reg, datab_reg;
	reg  sload_reg;
	reg	 signed [31:0] old_result;
	wire signed [31:0] multa;

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
*/		
