module CNN( input logic clk, load, start
            input logic [15:0] data_in
            output logic done
            output logic [15:0] data_out);
    
    logic [9:0] addr1_img, addr2_img;

    logic [4:0] addr1_c1W, addr2_c1W;
    logic [2:0] addr1_c1B, addr2_c1B;
    logic [9:0] addr1_c1O, addr2_c1O;

    logic [4:0] addr1_c2W, addr2_c2W;
    logic [6:0] addr1_c2B, addr2_c2B;
    logic [6:0] addr1_c1O, addr2_c1O;

    logic [10:0] addr1_P1, addr2_P1;
    logic [10:0] addr1_P2, addr2_P2;

    logic [4:0] done, load;
    img_mem_counter img_mem_counter1(   .clk(clk), .start(load[0]), 
                                        .addr1(addr_img), .addr2(addr2_img), 
                                        .done(done[0]));

    c1W_mem_counter c1W_mem_counter1(   .clk(clk), .start(load[1]), 
                                        .addr1(addr1_c1W), .addr2(addr2_c1W), 
                                        .done(done[1]));
    c1B_mem_counter c1B_mem_counter1(   .clk(clk), .start(load[2]),
                                        .addr1(addr1_c1B), .addr2(addr2_c1B)
                                        .done(done[2]));
    c1O_mem_counter c1O_mem_counter1(   .clk(clk), .start(load[3]),
                                        .addr1(addr1_c1O), .addr2(addr2_c1O)
                                        .done(done[3]));

    c2B_mem_counter c2B_mem_counter1(   .clk(clk), .start(load[4]),
                                        .addr1(addr1_c2B), .addr2(addr2_c2B)
                                        .done(done[4]));                           
    c2W_mem_counter c2W_mem_counter1(   .clk(clk), .start(load[5]), 
                                        .addr1(addr1_c2W), .addr2(addr2_c2W), 
                                        .done(done[5]));
    c2O_mem_counter c2O_mem_counter1(   .clk(clk), .start(load[6]),
                                        .addr1(addr1_c2O), .addr2(addr2_c2O)
                                        .done(done[6]));

    P1_mem_counter  P1_mem_counter1(   .clk(clk), .start(load[7]), 
                                        .addr1(addr1_P1), .addr2(addr2_P1), 
                                        .done(done[7]));
    P2_mem_counter  P2_mem_counter1(   .clk(clk), .start(load[8]),
                                        .addr1(addr1_P2), .addr2(addr2_P2)
                                        .done(done[8]));

    FCW_mem_counter FCW_mem_counter1(   .clk(clk), .start(load[9]),
                                        .addr1(addr1_FCW), .addr2(addr2_FCW)
                                        .done(done[9]));
    FCB_mem_counter FCB_mem_counter1(   .clk(clk), .start(load[10]),
                                        .addr1(addr1_FCB), .addr2(addr2_FCB)
                                        .done(done[10]));                                       
    
    
    P1_mem param1mem(.clk(clk), );
    P2_mem param2mem(.clk(clk), );
    mac MAC();

    always_ff @(posedge clk) begin
        

    end
endmodule