`timescale 1ns / 1ps

module tb_Adder();
    reg [63:0] a;
    reg [63:0] b;
    wire [63:0] out;
    
    Adder ab(a, b, out);

    initial begin;
    a = 64'd10; b = 64'd4;
    
    #50 a = 64'd17; b = 64'd10;
    
    #50 a = 64'd60; b = 64'd95;
    
    #50 a = 64'd2; b = 64'd10;
end
endmodule
