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

module MAC (input logic clk, enable, reset, 
			input logic [2:0] layer, 
			input logic signed [15:0] A, B,  
			output logic signed [31:0] out);
	
	reg signed [31:0] MAC_out;
	reg [7:0] count;

	always_ff @(posedge clk or posedge reset) begin
		if(reset == 1'b1) begin
			MAC_out <= 32'b00000000000000000000000000000000;
			count <= 8'b00000000;
		end
		else if (enable == 1'b1) begin
			MAC_out <= MAC_out + (A * B); //does the MAC thing
			count <= count + 1'b1;
		end
		if((count == 8'b00011001 && (layer == 3'b000 || layer == 3'b010)) || (count == 8'b11000000 && layer == 3'b100)) begin //if finished with a conv(count = 25) or one of the FC(count = 192) outputs the result
			out = MAC_out;
			MAC_out <= 32'b00000000000000000000000000000000;
			count <= 8'b00000000;
		end
	end
endmodule

module after_MAC (input logic [2:0] layer,
				  input logic signed [31:0] MAC_out_0, MAC_out_1, MAC_out_2, MAC_out_3, MAC_out_4, MAC_out_5, bias_0, bias_1, bias_2, bias_3, bias_4, bias_5, conv2_bias, 
				  output logic signed [15:0] out_0, out_1, out_2, out_3, out_4, out_5, out_conv2);

	//bias adding and adding of itermediates for conv1 and conv2
	wire signed [31:0] conv1_interm_0;
	wire signed [31:0] conv1_interm_1;
	wire signed [31:0] conv1_interm_2;
	wire signed [31:0] conv1_interm_3;
	wire signed [31:0] conv1_interm_4;
	wire signed [31:0] conv1_interm_5;
	wire signed [31:0] conv2_interm;
	assign conv2_interm = MAC_out_0 + MAC_out_1 + MAC_out_2 + MAC_out_3 + MAC_out_4 + MAC_out_5 + conv2_bias;
	assign conv1_interm_0 = MAC_out_0 + bias_0;
	assign conv1_interm_1 = MAC_out_1 + bias_1;
	assign conv1_interm_2 = MAC_out_2 + bias_2;
	assign conv1_interm_3 = MAC_out_3 + bias_3;
	assign conv1_interm_4 = MAC_out_4 + bias_4;
	assign conv1_interm_5 = MAC_out_5 + bias_5;

	always_comb begin

		if(layer = 3'b000) begin //if conv1 performs ReLU and shifts intermediate
			if(conv1_interm_0[31] == 1'b1) begin
				out_0[15:0] = 16'b0000000000000000;
			end
			else begin
				out_0[15:0] = conv1_interm_0[18:3];
			end
			if(conv1_interm_1[31] == 1'b1) begin
				out_1[15:0] = 16'b0000000000000000;
			end
			else begin
				out_1[15:0] = conv1_interm_1[18:3];
			end
			if(conv1_interm_2[31] == 1'b1) begin
				out_2[15:0] = 16'b0000000000000000;
			end
			else begin
				out_2[15:0] = conv1_interm_2[18:3];
			end
			if(conv1_interm_3[31] == 1'b1) begin
				out_3[15:0] = 16'b0000000000000000;
			end
			else begin
				out_3[15:0] = conv1_interm_3[18:3];
			end
			if(conv1_interm_4[31] == 1'b1) begin
				out_4[15:0] = 16'b0000000000000000;
			end
			else begin
				out_4[15:0] = conv1_interm_4[18:3];
			end
			if(conv1_interm_5[31] == 1'b1) begin
				out_5[15:0] = 16'b0000000000000000;
			end
			else begin
				out_5[15:0] = conv1_interm_5[18:3];
			end
		end

		if(layer = 3'b010) begin //if conv2 performs ReLU and shifts intermediate
			if(conv2_interm[31] == 1'b1) begin
				out_conv2[15:0] = 16'b0000000000000000;
			end
			else begin
				out_conv2[15:0] = conv2_interm[18:3];
			end
		end

		if(layer = 3'b100) begin //if Fully connected layer just shifts
			out_0[15:0] = MAC_out_0[18:3];
			out_1[15:0] = MAC_out_1[18:3];
			out_2[15:0] = MAC_out_2[18:3];
			out_3[15:0] = MAC_out_3[18:3];
			out_4[15:0] = MAC_out_4[18:3];
			out_5[15:0] = MAC_out_5[18:3];
		end
	end
endmodule		
