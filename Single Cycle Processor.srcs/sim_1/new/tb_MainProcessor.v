`timescale 1ns / 1ps

module tb_MainProcessor();

    reg clk, reset;
    main_processor mp (clk, reset);
    
    initial begin
        reset = 1;
        clk = 0;
        #5 reset = 0;
    end
    always # 1 clk = ~clk;
    
endmodule