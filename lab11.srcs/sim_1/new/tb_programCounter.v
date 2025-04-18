`timescale 1ns / 1ps

module tb_programCounter();
    reg clk = 0; 
    reg reset = 0; 
    reg [63:0] PC_In; 
    wire [63:0] PC_Out;
    
    Program_Counter PC(clk, reset, PC_In, PC_Out);
    
    initial begin
        PC_In = 64'd0;
        #100 PC_In = 64'd20;
        
        #100 PC_In = 64'd240;
        
        #100 reset = 1;
        
        #100 PC_In = 64'd37;
        
        #100 reset = 0;
    end
    always begin
    #5 clk = ~clk;
end
endmodule
