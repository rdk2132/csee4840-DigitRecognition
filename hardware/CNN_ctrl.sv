//Control circuitry for CNN
module CNN_ctrl(input logic clk, conv1_kern_done, conv2__kern_done, FC_done, conv1_out_done, 
                input logic conv2_out_done, poo1_done, pool2_done, image_done,

                //input from software
                inout logic state, reset, start, 

                //counter enables
                output logic img_count_enable, conv1_kern_count_enable, conv2__kern_count_enable, FC_count_enable,
                output logic conv1_out_r_enable, conv1_out_w_enable,
                output logic conv2_out_r_enable, conv2_out_w_enable, 
                output logic pool1_r_enable, pool1_w_enable,
                output logic pool2_r_enable, pool2_w_enable, 

                //read/write enables
                output logic img_r, img_w, conv1k_r, conv2k_r, FC_r,
                output logic conv1o_r, conv1o_w, 
                output logic comv2o_r, conv2o_w, 
                output logic P1r, P1w, 
                output logic P2r, P2w, 

                //MUX/DEMUX selector bits
                output logic [1:0] MAC_layer,
                output logic rMAC, pooling_layer,

                output logic done);
    


    reg pulse;
    logic done1, done2, done3, done4, done5;
    
    //sets the mux/demux
    always_comb begin
        MAC_layer = state[2:1];
        pooling_layer = state[2];
    end

    always_ff @(posedge clk) begin
        //pulse these outputs
        done = 0;
 
        //reset all values to zero
        if(reset == 1) begin
            //pulse the resets for everything
        end 

        //set stay done low when you want to start
        if (start == 1) begin
            stay_done = 0;
        end

        //state 0
        //load an image when not currently proccessing image
        if(state == 3'b000) begin
            img_w = 1;
            img_r = 0;
        end
        else if(image_done) begin
            img_w = 0;
            done = stay_done = 1;
        end


        //state 1: Convolution 1
        else if( state = 3'b001 && done = 1'b0) begin
            if(conv1_kern_done == 1'b1 && pulse == 1'b1) begin
               conv1o_w = conv1k_r = image_count_enable = pulse = 1'b0;
               done = 1'b1;

               //soft lock the layer until the next layer is called
               done_1 = 1'b1;
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
        else if( state == 3'b010 ) begin 
            done1 = 0;

        end
        //state 3: Convolution 2 
        else if( state == 3'b011 ) begin 
            done1 = 0;

        end
        //state 2: Pooling 2
        else if( state == 3'b100 && done2 == 0) begin 
            done1 = 0;
            if(conv1_out_done == 1) begin
                conv1_out_count_enable = P1
                done = 1;
                done2 = 1;
            end
            else begin

            end

        end
        //state 3: Fully Connected
        else if( state == 3'b101 ) begin 
            done2 = 0;

        end
    end
endmodule