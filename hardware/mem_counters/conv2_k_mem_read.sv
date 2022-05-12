//Module used to provide access to 6 kernels with two counters at once
// counter/addresser for Convolution 2 layer weight memory read
module conv2_k_mem_read (input logic clk, reset, enable,
                        output logic [7:0] addr0, addr1,
                        output logic done);

    logic [3:0] delay;
    logic [5:0] count;
    logic [7:0] addrcount;
    logic [7:0] offset;

    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            delay <= 4'b0000;
            addrcount <= 6'b000000;
            offset <= 8'b0000000;
        end
        else if (enable == 1'b1 && done == 1'b0) begin

            //when address reaches 24, count
            if(addrcount == 8'd24) begin
                addrcount <= 1'b0;
                if(count == 5'd63) begin
                    count <= 5'd0;
                    if(offset == 8'b00000000) begin
                        offset <= 8'd25;
                    end
                    else if(offset == 8'd25) begin
                        offset <= 8'd50;
                    end
                end
                else begin
                    count <= count + 5'd1;
                end
            end

            //else, increment by 1
            else if(delay == 4'b0000) begin
                addrcount <= addrcount + 8'b00000001;
            end
            else begin
                delay <= delay + 4'b0001;
            end
        end
    end

    always_comb begin
        if(offset == 8'd50 && count == 6'd63) begin
            done = 1'b1;
        end
        else begin
            done = 1'b0;
        end
        addr0 = addrcount + offset;
        addr1 = addrcount + 8'b01001011 + offset;
    end
endmodule
