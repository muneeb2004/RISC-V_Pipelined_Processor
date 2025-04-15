`timescale 1ns / 1ps

module main_processor(
    input clk,
    input reset
);

//program counter input
wire [63:0] pcIn;
//program counter input
wire [63:0] pcOut;
//instruction memory output / instruction parser input
wire [31:0] instruction;
// instruction parser output / control unit input
wire [6:0] opcode;
// instruction parser outputs
wire [4:0] rd;
wire [2:0] func3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] func7;
//control unit outputs
wire branch;
wire memRead;
wire memToReg;
wire [1:0] aluOp;
wire memWrite;
wire aluSrc;
wire regWrite;
//register file inputs
wire [63:0] imm;
wire [63:0] rs1Data;
wire [63:0] rs2Data;
//adder 61 first
wire [63:0] nextInsAddress;
//adder 64 second inputs
wire [63:0] branchInsAddress;
//alu control inputs
wire [3:0] operation;
//multiplexer inputs
wire [63:0] aluSecondOperand;
//alu64bit inputs 
wire zero;
wire [63:0] aluResult;
//multiplexer
wire pcMuxSel;
//dataMemory
wire [63:0] readData;
//multiplexer
wire [63:0] writeData;


programCounter pc (pcIn, clk, reset, pcOut);
instructionMemory im (pcOut, instruction);
instructionParser ip (instruction, opcode, rd, func3, rs1, rs2, func7);
controlUnit cu (reset, opcode, branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);
registerFile rf (writeData, rs1, rs2, rd, regWrite, clk, reset, rs1Data, rs2Data);
dataExtractor de (instruction, imm);
adder64 add1 (pcOut, 4, nextInsAddress);
adder64 add2 (pcOut, imm << 1 , branchInsAddress);
aluControl ac (aluOp, {instruction[30], instruction[14:12]}, operation);
multiplexer regMux (rs2Data, imm, aluSrc, aluSecondOperand);
alu64bit alu (rs1Data, aluSecondOperand, operation, zero, aluResult);
branchUnit bu (func3, aluResult, zero, branch, pcMuxSel);
multiplexer pcMux (nextInsAddress, branchInsAddress, pcMuxSel, pcIn);
dataMemory dm (aluResult, rs2Data, clk, memWrite, memRead, readData);
multiplexer memMux (aluResult, readData, memToReg, writeData);


endmodule
