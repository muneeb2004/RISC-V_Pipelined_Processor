`timescale 1ns / 1ps

module Instruction_Memory(
    input [63:0] Inst_Addr,
    output [31:0] Instruction
    );
    
    reg [7:0] Inst_Mem [15:0];
    
    initial
    begin
    
    Inst_Mem[0] = 8'b10000011;
    Inst_Mem[1] = 8'b00110100;
    Inst_Mem[2] = 8'b00000101;
    Inst_Mem[3] = 8'b00001111;
    Inst_Mem[4] = 8'b10110011;
    Inst_Mem[5] = 8'b10000100;
    Inst_Mem[6] = 8'b10011010;
    Inst_Mem[7] = 8'b00000000;
    Inst_Mem[8] = 8'b10010011;
    Inst_Mem[9] = 8'b10000100;
    Inst_Mem[10] = 8'b00010100;
    Inst_Mem[11] = 8'b00000000;
    Inst_Mem[12] = 8'b00100011;
    Inst_Mem[13] = 8'b00111000;
    Inst_Mem[14] = 8'b10010101;
    Inst_Mem[15] = 8'b00001110;
    
    end
    
    assign Instruction[7:0] = Inst_Mem[Inst_Addr];
    assign Instruction[15:8] = Inst_Mem[Inst_Addr+1];
    assign Instruction[23:16] = Inst_Mem[Inst_Addr+2];
    assign Instruction[31:24] = Inst_Mem[Inst_Addr+3];
endmodule
