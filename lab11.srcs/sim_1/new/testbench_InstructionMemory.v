`timescale 1ns / 1ps

module testbench_InstructionMemory();
    reg [63:0] Inst_Addr;
    wire [31:0] Instruction;
    
    Instruction_Memory tb(Inst_Addr, Instruction);
    
    initial
    begin
    
    Inst_Addr = 0;
    #100
    
    Inst_Addr = 1;
    #100
    
    Inst_Addr = 2;
    #100
    
    Inst_Addr = 3;
    #100
    
    Inst_Addr = 4;
    
    end
endmodule
