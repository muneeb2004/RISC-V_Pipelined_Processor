`timescale 1ns / 1ps

module mux_test();
    reg [63:0] a;
    reg [63:0] b;
    reg sel;
    wire [63:0] data_out;
    
    mux MuxTest (a, b, sel, data_out);

    initial
    begin
    #0
    a = 64'b1000000000; 
    b= 64'b0010000000; 
    sel = 0;
    
    #100
    a = 64'b1000000000; 
    b = 64'b0010000000; 
    sel = 1;
    
    #200
    a = 64'b1000000100; 
    b = 64'b0010000001; 
    sel = 0;
    
    #300
    a = 64'b1000000100; 
    b= 64'b0010000001; 
    sel = 1;
    
    end
endmodule