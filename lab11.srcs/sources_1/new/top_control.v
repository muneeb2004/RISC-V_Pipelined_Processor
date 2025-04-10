`timescale 1ns / 1ps

module top_control(
    input [6:0] opcode,           
    input [3:0] funct,           
    output Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,             
    output [3:0] Operation        
    );
    
    wire [1:0] ALUOp;  
    
    Control_Unit cu(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
    
    alu_control alu(ALUOp, funct, Operation);
    
endmodule
