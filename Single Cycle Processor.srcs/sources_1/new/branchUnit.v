`timescale 1ns / 1ps

module branchUnit(
    input [2:0] funct3,
    input [31:0] result,
    input zero,
    input branch,
    output pc_mux_sel
    );
    wire sel;
    assign sel =
        (funct3 == 3'b000 & zero) | // beq
        (funct3 == 3'b100 & result[31]) | // blt
        (funct3 == 3'b101 & (~result[31] | zero)); // bge
    assign pc_mux_sel = branch & sel;
    
endmodule
