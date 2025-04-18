`timescale 1ns / 1ps

module Control_Unit_TB();
    reg [6:0] Opcode;
    wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;
    
    Control_Unit a(Opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
    
    initial
    begin
    
    Opcode = 7'b1100011; // SB-tye
    #10
    Opcode = 7'b0100011; // S-type
    #10
    Opcode = 7'b0000011; // I-type
    #10
    Opcode = 7'b0110011; // R-type
    end
 
endmodule
