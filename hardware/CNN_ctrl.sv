//Control circuitry for CNN
//state 1 = load
//state 2 = conv1
//state 3 = pool1
//state 4 = conv2
//state 5 = pool2
//state 6 = FC

module CNN_ctrl(//The one and only cock
                input logic clk,

                //input from software
                inout logic [8:0] state,

                //ROM counter done
                input logic img_d, conv1_kern_d, conv2__kern_d, FC_d,

                // RAM counter done
                input logic conv1_out_r_e, conv1_out_w_e,
                input logic conv2_out_r_e, conv2_out_w_e, 
                input logic pool1_r_e, pool1_w_e,
                input logic pool2_r_e, pool2_w_e,
                input logic fc_r_e, fc_w_e,

                //ROM counter enables
                output logic img_e, conv1_kern_e, conv2__kern_e, FC_e,

                //RAM counter enables
                output logic conv1_out_c_r_e, conv1_out_c_w_e,
                output logic conv2_out_c_r_e, conv2_out_c_w_e, 
                output logic P1_c_r_e, P1_c_w_e,
                output logic P2_c_r_e, P2_c_w_e,
                output logic fc_c_r_e, fc_c_w_e,

                //MAC reset
                output logic rMAC,

                //ROM counter resets
                output logic img_r, conv1_kern_r, conv2__kern_r, FC_r,

                //RAM counter resets
                output logic conv1_out_r_r, conv1_out_w_r,
                output logic conv2_out_r_r, conv2_out_w_r, 
                output logic pool1_r_r, pool1_w_r,
                output logic pool2_r_r, pool2_w_r,
                output logic fc_r_r, fc_w_r, 

                //read/write enables
                output logic img_r, img_w, conv1k_r, conv2k_r, FC_r,
                output logic conv1_out_m_r, conv1_out_m_w, 
                output logic conv2_out_m_r, conv2_out_m_w, 
                output logic P1_r, P1_w, 
                output logic P2_r, P2_w,
                output logic FC_r, FC_w,

                //MUX/DEMUX selector bits
                output logic [1:0] MAC_layer,
                output logic pooling_layer,

                //Done signal for software <3
                output logic[7:0] done);
    


    //used to pulse reset for MAC
    reg pulse;
    logic reset;
    //sets the mux/demux
    always_comb begin
        MAC_layer = state[2:1];
        pooling_layer = state[2];
    end

    always_ff @(posedge clk) begin
        //pulse these outputs
        rMAC <= 1'b0;
        img_r <= conv1_kern_r <= conv2__kern_r <= FC_r <= 1'b0;
        conv1_out_r_r <= conv1_out_w_r = 1'b0;
        conv2_out_r_r <= conv2_out_w_r <= 1'b0; 
        pool1_r_r <= pool1_w_r <= 1'b0;
        pool2_r_r <= pool2_w_r <= 1'b0;
        fc_r_r <= fc_w_r <= 1'b0;

        if(reset == 1) begin
            //all resets to 1
            reset = 0;
        end

        //State 1: Load Image
        if(state == 8'b0000 0001 && done == 8'b0000 0000) begin 
            //stop image write
            if( img_d == 1'b1) begin
                done <= 8'b0000 0001;
                img_w <= 1'b0;
            end
            else begin
                img_w <= 1'b1;
            end
        end
        //State 2: Convolution 1
        else if(state == 8'b0000 0010 && done == 8'b0000 0001) begin
            
        end
        //State 3: Pool 1
        else if(state == 8'b0000 0011 && done == 8'b0000 0001) begin

        end
        //State 4: Convolution 2
        else if(state == 8'b0000 0100 && done == 8'b0000 0001) begin

        end
        //State 5: Pool 2
        else if(state == 8'b0000 0101 && done == 8'b0000 0001) begin

        end
        //State 6: Fully Connected
        else if(state == 3'b0000 0110 && done == 8'b0000 0001) begin

        end
    end
endmodule