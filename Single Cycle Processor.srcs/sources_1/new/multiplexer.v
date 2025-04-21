`timescale 1ns / 1ps

module multiplexer(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output [31:0] data_out
    );
    
    assign data_out = sel == 0 ? a : b;
    
endmodule
