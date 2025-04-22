`timescale 1ns / 1ps

module tb_MainProcessor();

    reg clk, reset;
    main_processor mp (clk, reset);
    
    initial
        begin
            reset <= 1; #1; reset <= 0;
        end
        
        
    always
        begin
            clk <= 1; #1; clk <= 0; #1;
        end    
        
endmodule