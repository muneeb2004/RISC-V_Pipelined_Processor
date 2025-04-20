`timescale 1ns / 1ps

module alu64bit(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_op,
    output zero,
    output [31:0] result
);
    
    assign result =
        alu_op == 4'b0000 ? a & b: // AND
        alu_op == 4'b0001 ? a | b: // OR
        alu_op == 4'b0010 ? a + b: // ADD
        alu_op == 4'b0110 ? a - b: // SUB
        alu_op == 4'b1100 ? ~(a | b): // NOR
        alu_op == 4'b1000 ? a << b: // SLLI
        32'b0;
        
    assign zero = ~(|result);
endmodule
