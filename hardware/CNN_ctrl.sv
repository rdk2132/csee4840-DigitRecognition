module CNN_ctrl(input logic clk, reset, img_mem_read_done, conv1_mem_write_done, conv1_mem_read_done, conv1_k_mem_read_done, P1_mem_read_done, P1_mem_write_done, 
                            conv2_mem_write_done, conv2_mem_read_done, conv2_k_mem_read_done, P2_mem_write_done, P2_mem_read_done, fc_mem_read_done, 
                input logic [7:0] ctrl,
                output logic pooling_layer, rMAC, MAC_enable, Conv1_layer, P1_layer, Conv2_layer, P2_layer, FC_layer, 
                             img_mem_read_reset, conv1_mem_write_reset, conv1_mem_read_reset, conv1_k_mem_read_reset, P1_mem_read_reset, P1_mem_write_reset, 
                             conv2_mem_write_reset, conv2_mem_read_reset, conv2_k_mem_read_reset, P2_mem_write_reset, P2_mem_read_reset, fc_mem_read_reset, img_load, 
                output logic [7:0] return_ctrl, 
                output logic [1:0] MAC_layer);

    always_ff @(posedge clk) begin 
        if (reset == 1'b1) begin
            return_ctrl <= 8'b00000000;
            MAC_layer <= 2'b00;
            pooling_layer <= 1'b0;
            rMAC <= 1'b1;
            MAC_enable <= 1'b0;
            Conv1_layer <= 1'b0;
            P1_layer <= 1'b0;
            Conv2_layer <= 1'b0;
            P2_layer <= 1'b0;
            FC_layer <= 1'b0;
            img_mem_read_reset <= 1'b1;
            conv1_mem_write_reset <= 1'b1;
            conv1_mem_read_reset <= 1'b1;
            conv1_k_mem_read_reset <= 1'b1;
            P1_mem_read_reset <= 1'b1;
            P1_mem_write_reset <= 1'b1;
            conv2_mem_write_reset <= 1'b1;
            conv2_mem_read_reset <= 1'b1;
            conv2_k_mem_read_reset <= 1'b1;
            P2_mem_write_reset <= 1'b1;
            P2_mem_read_reset <= 1'b1;
            fc_mem_read_reset <= 1'b1;
        end

        if(ctrl == 8'b00000000) begin //img load
            MAC_layer <= 2'b00;
            img_load <= 1'b1;
            pooling_layer <= 1'b0;
            rMAC <= 1'b1;
            MAC_enable <= 1'b0;
            Conv1_layer <= 1'b0;
            P1_layer <= 1'b0;
            Conv2_layer <= 1'b0;
            P2_layer <= 1'b0;
            FC_layer <= 1'b0;
            img_mem_read_reset <= 1'b1;
            conv1_mem_write_reset <= 1'b1;
            conv1_mem_read_reset <= 1'b1;
            conv1_k_mem_read_reset <= 1'b1;
            P1_mem_read_reset <= 1'b1;
            P1_mem_write_reset <= 1'b1;
            conv2_mem_write_reset <= 1'b1;
            conv2_mem_read_reset <= 1'b1;
            conv2_k_mem_read_reset <= 1'b1;
            P2_mem_write_reset <= 1'b1;
            P2_mem_read_reset <= 1'b1;
            fc_mem_read_reset <= 1'b1;
        end
        else if(ctrl == 8'b00000001) begin //conv1
            img_load <= 1'b0;
            MAC_layer <= 2'b00;
            pooling_layer <= 1'b0;
            rMAC <= 1'b0;
            MAC_enable <= 1'b1;
            Conv1_layer <= 1'b1;
            P1_layer <= 1'b0;
            Conv2_layer <= 1'b0;
            P2_layer <= 1'b0;
            FC_layer <= 1'b0;
            img_mem_read_reset <= 1'b0;
            conv1_mem_write_reset <= 1'b0;
            conv1_mem_read_reset <= 1'b1;
            conv1_k_mem_read_reset <= 1'b0;
            P1_mem_read_reset <= 1'b1;
            P1_mem_write_reset <= 1'b1;
            conv2_mem_write_reset <= 1'b1;
            conv2_mem_read_reset <= 1'b1;
            conv2_k_mem_read_reset <= 1'b1;
            P2_mem_write_reset <= 1'b1;
            P2_mem_read_reset <= 1'b1;
            fc_mem_read_reset <= 1'b1;
        end
        else if(ctrl == 8'b00000010) begin //pool1
            img_load <= 1'b0;
            MAC_layer <= 2'b00;
            pooling_layer <= 1'b1;
            rMAC <= 1'b1;
            MAC_enable <= 1'b0;
            Conv1_layer <= 1'b0;
            P1_layer <= 1'b1;
            Conv2_layer <= 1'b0;
            P2_layer <= 1'b0;
            FC_layer <= 1'b0;
            img_mem_read_reset <= 1'b1;
            conv1_mem_write_reset <= 1'b1;
            conv1_mem_read_reset <= 1'b0;
            conv1_k_mem_read_reset <= 1'b1;
            P1_mem_read_reset <= 1'b1;
            P1_mem_write_reset <= 1'b0;
            conv2_mem_write_reset <= 1'b1;
            conv2_mem_read_reset <= 1'b1;
            conv2_k_mem_read_reset <= 1'b1;
            P2_mem_write_reset <= 1'b1;
            P2_mem_read_reset <= 1'b1;
            fc_mem_read_reset <= 1'b1;
        end
        else if(ctrl == 8'b00000011) begin //conv2
            img_load <= 1'b0;
            MAC_layer <= 2'b01;
            pooling_layer <= 1'b0;
            rMAC <= 1'b0;
            MAC_enable <= 1'b1;
            Conv1_layer <= 1'b0;
            P1_layer <= 1'b0;
            Conv2_layer <= 1'b1;
            P2_layer <= 1'b0;
            FC_layer <= 1'b0;
            img_mem_read_reset <= 1'b1;
            conv1_mem_write_reset <= 1'b1;
            conv1_mem_read_reset <= 1'b1;
            conv1_k_mem_read_reset <= 1'b1;
            P1_mem_read_reset <= 1'b0;
            P1_mem_write_reset <= 1'b1;
            conv2_mem_write_reset <= 1'b0;
            conv2_mem_read_reset <= 1'b1;
            conv2_k_mem_read_reset <= 1'b0;
            P2_mem_write_reset <= 1'b1;
            P2_mem_read_reset <= 1'b1;
            fc_mem_read_reset <= 1'b1;
        end
        else if(ctrl == 8'b00000100) begin //pool2
            img_load <= 1'b0;
            MAC_layer <= 2'b00;
            pooling_layer <= 1'b1;
            rMAC <= 1'b1;
            MAC_enable <= 1'b0;
            Conv1_layer <= 1'b0;
            P1_layer <= 1'b0;
            Conv2_layer <= 1'b0;
            P2_layer <= 1'b1;
            FC_layer <= 1'b0;
            img_mem_read_reset <= 1'b1;
            conv1_mem_write_reset <= 1'b1;
            conv1_mem_read_reset <= 1'b1;
            conv1_k_mem_read_reset <= 1'b1;
            P1_mem_read_reset <= 1'b1;
            P1_mem_write_reset <= 1'b1;
            conv2_mem_write_reset <= 1'b1;
            conv2_mem_read_reset <= 1'b0;
            conv2_k_mem_read_reset <= 1'b1;
            P2_mem_write_reset <= 1'b0;
            P2_mem_read_reset <= 1'b1;
            fc_mem_read_reset <= 1'b1;
        end
        else if(ctrl == 8'b00000101) begin //FC
            img_load <= 1'b0;
            MAC_layer <= 2'b10;
            pooling_layer <= 1'b0;
            rMAC <= 1'b0;
            MAC_enable <= 1'b1;
            Conv1_layer <= 1'b0;
            P1_layer <= 1'b0;
            Conv2_layer <= 1'b0;
            P2_layer <= 1'b0;
            FC_layer <= 1'b1;
            img_mem_read_reset <= 1'b1;
            conv1_mem_write_reset <= 1'b1;
            conv1_mem_read_reset <= 1'b1;
            conv1_k_mem_read_reset <= 1'b1;
            P1_mem_read_reset <= 1'b1;
            P1_mem_write_reset <= 1'b1;
            conv2_mem_write_reset <= 1'b1;
            conv2_mem_read_reset <= 1'b1;
            conv2_k_mem_read_reset <= 1'b1;
            P2_mem_write_reset <= 1'b1;
            P2_mem_read_reset <= 1'b0;
            fc_mem_read_reset <= 1'b0;
        end

        if(img_mem_read_done == 1'b1 && conv1_mem_write_done == 1'b1 && conv1_k_mem_read_done == 1'b1) begin
            return_ctrl <= 8'b00000001;
        end
        if(conv1_mem_read_done == 1'b1 && P1_mem_write_done == 1'b1) begin
            return_ctrl <= 8'b00000010;
        end
        if(P1_mem_read_done  == 1'b1 && conv2_mem_write_done == 1'b1 && conv2_k_mem_read_done == 1'b1) begin
            return_ctrl <= 8'b00000011;
        end
        if(conv2_mem_read_done == 1'b1 && P2_mem_write_done == 1'b1) begin
            return_ctrl <= 8'b00000100;
        end
        if(P2_mem_read_done == 1'b1 && fc_mem_read_done == 1'b1) begin
            return_ctrl <= 8'b00000101;
        end
    end

endmodule
