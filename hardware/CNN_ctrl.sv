//Control circuitry for CNN
//state 0 = load
//state 1 = conv1
//state 2 = pool1
//state 3 = ...

module CNN_ctrl(//The one and only cock
                input logic clk,
                //ROM counter done
                input logic img_d, conv1_kern_d, conv2__kern_d, FC_d,

                // RAM counter done
                input logic conv1_out_r_e, conv1_out_w_e,
                input logic conv2_out_r_e, conv2_out_w_e, 
                input logic pool1_r_e, pool1_w_e,
                input logic pool2_r_e, pool2_w_e,
                input logic fc_r_e, fc_w_e,

                //input from software
                inout logic state, reset,

                //ROM counter enables
                output logic img_e, conv1_kern_e, conv2__kern_e, FC_e,

                //RAM counter enables
                output logic conv1_out_r_e, conv1_out_w_e,
                output logic conv2_out_r_e, conv2_out_w_e, 
                output logic pool1_r_e, pool1_w_e,
                output logic pool2_r_e, pool2_w_e,
                output logic fc_r_e, fc_w_e,

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
                output logic conv1o_r, conv1o_w, 
                output logic comv2o_r, conv2o_w, 
                output logic P1_r, P1_w, 
                output logic P2_r, P2_w,
                output logic FC_r, FC_w,

                //MUX/DEMUX selector bits
                output logic [1:0] MAC_layer,
                output logic pooling_layer,

                //Done
                output logic done);
    


    //used to pulse reset for MAC
    reg pulse;

    //soft lock for layers when done
    logic done0, done1, done2, done3, done4, done5;
    
    //sets the mux/demux
    always_comb begin
        MAC_layer = state[2:1];
        pooling_layer = state[2];
    end

    always_ff @(posedge clk) begin
        //pulse these outputs
        done = 0;
        img_r = conv1_kern_r = conv2__kern_r = FC_r = 1'b0;
        conv1_out_r_r = conv1_out_w_r = 1'b0;
        conv2_out_r_r = conv2_out_w_r = 1'b0; 
        pool1_r_r = pool1_w_r = 1'b0;
        pool2_r_r = pool2_w_r = 1'b0;
        fc_r_r = fc_w_r, = 1'b0;

        //reset all values to zero
        if(reset == 1) begin
            //pulse the resets for everything
        end 

        //set stay done low when you want to start
        if (start == 1) begin
            stay_done = 0;
        end

        //state 0: load image
        if(state == 3'b000 && done0 = 1'b0) begin
            img_w = 1;
            img_r = 0;
        end
        else if(image_done) begin
            img_w = 0;
            done = done0 = 1;
        end


        //state 1: Convolution 1
        else if( state = 3'b001 && done = 1'b0) begin
            //reset image image counter
            if(done0 == 1) begin
                img_r = 1;
                done0 = 0;
            end

            if(conv1_kern_done == 1'b1 && pulse == 1'b1) begin
               conv1o_w = conv1k_r = image_count_enable = pulse = 1'b0;
               done = 1'b1;
               done1 = 1'b1;
            end

            //turn off reset for MAC and set read and write
            else if(rMAC == 1) begin
                rMAC = 1'b0;
                conv1o_w = conv1k_r = image_count_enable = 1'b1;
                conv1o_r = 1'b0;
            end

            //turn on reset for MAC and invert pulse
            else if(rMAC == 1'b0 && pulse == 1'b0) begin
                rMAC = 1'b1;
                pulse = 1'b1;
            end
        end

        //state 2: Pooling 1
        else if( state == 3'b010 && done2 == 1'b0) begin 
            //turn on counters for conv1 out read and pool1 write 
            conv1_out_r_e = 1'b1;
            pool1_w_e = 1'b1;
            //turn read on for conv1 out and write for pool1
            conv1o_r = P1_r = 1'b1;
            conv1o_w = P1_w = 1'b0;

            //reset preveous layer
            if(done1 == 1'b1) begin
                conv1_kern_r = 1'b1;
                done1 = 1'b0;
            end

            if(conv1_out_done == 1) begin
                done = 1;
                done2 = 1;
            end
        end
        //state 3: Convolution 2 
        else if( state == 3'b011 ) begin 
            done2 = 0;

        end
        //state 2: Pooling 2
        else if( state == 3'b100 && done2 == 0) begin 
            

        end
        //state 3: Fully Connected
        else if( state == 3'b101 ) begin 
            done2 = 0;

        end
    end
endmodule