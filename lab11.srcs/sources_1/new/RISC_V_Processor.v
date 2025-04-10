`timescale 1ns / 1ps

module RISC_V_Processor(
    input clk,
    input reset
    );
    //Program Counter
    wire [63:0] PC_In;
    wire [63:0] PC_Out;
    Program_Counter a1(clk,reset,PC_In,PC_Out);
    
    //Program Counter + 4
    wire [63:0] pc4;
    Adder b1(PC_Out, 64'd4, pc4);
    
    //Instruction Memory
    wire [31:0] Instruction;
    Instruction_Memory c1(PC_Out,Instruction);
    
    //Instruction Parser
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [3:0] funct7;
    instruction_parser d1(Instruction,opcode,rd,funct3,rs1,rs2,funct7);
    
    //Control Unit
    wire [3:0] funct; 
    assign funct = {Instruction[30], Instruction[14:12]};
    wire Branch;                
    wire MemRead;               
    wire MemtoReg;              
    wire MemWrite;              
    wire ALUSrc;                
    wire RegWrite;              
    wire [3:0] Operation;
    top_control g1(opcode,funct,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Operation);
    
    //Immediate Data Extractor
    wire [63:0] imm_data;
    immediate_data_extractor e1(Instruction,imm_data);
    
    //Program Counter + Branch Instruction
    wire [63:0] PC_Branch;
    wire [63:0] imm_left;
    assign imm_left = imm_data << 1;
    Adder f1(PC_Out,imm_left, PC_Branch);
    
    //Register File
    wire [63:0] WriteData;
    wire [63:0] ReadData1;
    wire [63:0] ReadData2;
    registerFile h1(WriteData,rs1,rs2,rd,RegWrite,clk,reset,ReadData1,ReadData2);
    
    //mux : ALU input
    wire [63:0] data_out;
    mux i1(ReadData2, imm_data, ALUSrc, data_out);
    
    //ALU
    wire C_In;
    wire C_Out;
    wire zero;
    wire [63:0] Result;
    assign C_In = Operation == 4'b0011 ? 1 : 0;
    ALU_64_bit j1(ReadData1, data_out, C_In, Operation, C_Out, zero, Result);
  
    //PC Mux
    wire [63:0] PC_Final;
    wire sel;
    assign sel = Branch && zero; 
    mux k1(pc4, PC_Branch, sel, PC_Final); 
    assign PC_In = PC_Final; 
    
    //Data Memory
    wire [63:0] Read_Data;
    Data_Memory l1(Result,ReadData2,clk,MemWrite,MemRead,Read_Data);
    
    //Final Result
    wire [63:0] final_data_out;
    mux m1(Read_Data,Result,MemtoReg,final_data_out);
    
    assign WriteData = final_data_out;
    
    
endmodule
