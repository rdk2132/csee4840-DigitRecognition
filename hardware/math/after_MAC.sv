module after_MAC (input logic [1:0] MAC_layer,
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
	assign conv1_interm_0 = MAC_out_0 + -32'd188;
	assign conv1_interm_1 = MAC_out_1 + -32'd224;
	assign conv1_interm_2 = MAC_out_2 + -32'd144;
	assign conv1_interm_3 = MAC_out_3 + -32'd64;
	assign conv1_interm_4 = MAC_out_4 + -32'd64;
	assign conv1_interm_5 = MAC_out_5 +  32'd64;

	always_comb begin

		if(MAC_layer == 2'b00) begin //if conv1 performs ReLU and shifts intermediate
			if(conv1_interm_0[31] == 1'b1) begin
				out_0[15:0] = 16'b0000000000000000;
			end
			else begin
				out_0[15:0] = conv1_interm_0[19:4];
			end
			if(conv1_interm_1[31] == 1'b1) begin
				out_1[15:0] = 16'b0000000000000000;
			end
			else begin
				out_1[15:0] = conv1_interm_1[19:4];
			end
			if(conv1_interm_2[31] == 1'b1) begin
				out_2[15:0] = 16'b0000000000000000;
			end
			else begin
				out_2[15:0] = conv1_interm_2[19:4];
			end
			if(conv1_interm_3[31] == 1'b1) begin
				out_3[15:0] = 16'b0000000000000000;
			end
			else begin
				out_3[15:0] = conv1_interm_3[19:4];
			end
			if(conv1_interm_4[31] == 1'b1) begin
				out_4[15:0] = 16'b0000000000000000;
			end
			else begin
				out_4[15:0] = conv1_interm_4[19:4];
			end
			if(conv1_interm_5[31] == 1'b1) begin
				out_5[15:0] = 16'b0000000000000000;
			end
			else begin
				out_5[15:0] = conv1_interm_5[19:4];
			end
            out_conv2 = 16'b0000000000000000;
		end

		else if(MAC_layer == 2'b01) begin //if conv2 performs ReLU and shifts intermediate
			out_0 = 16'b0000000000000000;
            out_1 = 16'b0000000000000000;
            out_2 = 16'b0000000000000000;
            out_3 = 16'b0000000000000000;
            out_4 = 16'b0000000000000000;
            out_5 = 16'b0000000000000000;
			if(conv2_interm[31] == 1'b1) begin
				out_conv2[15:0] = 16'b0000000000000000;
			end
			else begin
				out_conv2[15:0] = conv2_interm[19:4];
			end
		end

		else if(MAC_layer == 2'b10) begin //if Fully connected layer just shifts
			out_0[15:0] = MAC_out_0[19:4];
			out_1[15:0] = MAC_out_1[19:4];
			out_2[15:0] = MAC_out_2[19:4];
			out_3[15:0] = MAC_out_3[19:4];
			out_4[15:0] = MAC_out_4[19:4];
			out_5[15:0] = MAC_out_5[19:4];
            out_conv2 = 16'b0000000000000000;
		end
        else begin
			out_0 = 16'b0000000000000000;
			out_1 = 16'b0000000000000000;
			out_2 = 16'b0000000000000000;
			out_3 = 16'b0000000000000000;
			out_4 = 16'b0000000000000000;
			out_5 = 16'b0000000000000000;
            out_conv2 = 16'b0000000000000000;
        end
	end
endmodule
