module CNN( input logic clk, load, start
            input logic [15:0] data_in
            output logic done
            output logic [15:0] data_out);
    
    wire [10:0] addr1, addr2;
    wire [4:0] done;

    img_mem_counter img_mem_counter1(   .clk(clk), .start(load), 
                                        .addr1(addr1[9:0]), .addr2(addr2), 
                                        .done(done_imc));
    c1W_mem_counter clW_mem_counter1(   .clk(clk), .start(load), 
                                        .addr1(addr1), .addr2(addr2), 
                                        .done(done_imc)); 
    
    P1_mem param1mem(.clk(clk), );
    P2_mem param2mem(.clk(clk), );
    mac MAC();

    always_ff @(posedge clk) begin
        //my money dont jiggle jiggle, it folds
        //I'd like to see you wiggle wiggle, fo sho

    end