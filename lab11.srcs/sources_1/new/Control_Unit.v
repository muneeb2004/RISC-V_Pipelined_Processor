`timescale 1ns / 1ps

module Control_Unit(
    input [6:0] opcode,
    output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ALUOp
    );
    
    always @(*)
    begin
    if (opcode == 7'b1100011) // SB-tye
    begin
        ALUSrc = 0;
        MemtoReg = 1'bX;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALUOp = 01;
    end
    else if (opcode == 7'b0100011) // S-type
    begin
        ALUSrc = 1;
        MemtoReg = 1'bX;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 1;
        Branch = 0;
        ALUOp = 00;
    end
    else if (opcode == 7'b0000011) // I-type
    begin
        ALUSrc = 1;
        MemtoReg = 1;
        RegWrite = 1;
        MemRead = 1;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 00;
    end
    else if (opcode == 7'b0110011) // R-type
    begin
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 10;
    end
end
endmodule
