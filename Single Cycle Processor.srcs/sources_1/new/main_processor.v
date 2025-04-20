`timescale 1ns / 1ps

module main_processor(
    input clk,
    input reset
);

// Program Counter and Fetch
wire [31:0] pcIn, pcOut, instruction;
wire [31:0] nextInsAddress;
programCounter pc (pcIn, clk, reset, pcOut);
instructionMemory im (pcOut, instruction);
adder64 add1 (pcOut, 4, nextInsAddress);

// IF/ID Pipeline Register
wire [31:0] IFID_pc, IFID_instruction;
IF_ID if_id (
    .clk(clk),
    .reset(reset),
    .pcIn(pcOut),
    .instructionIn(instruction),
    .pcOut(IFID_pc),
    .instructionOut(IFID_instruction)
);

// Decode Stage
wire [6:0] opcode;
wire [4:0] rd, rs1, rs2;
wire [2:0] func3;
wire [6:0] func7;
instructionParser ip (IFID_instruction, opcode, rd, func3, rs1, rs2, func7);

wire branch, memRead, memToReg, memWrite, aluSrc, regWrite;
wire [1:0] aluOp;
controlUnit cu (reset, opcode, branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);

wire [31:0] imm;
dataExtractor de (IFID_instruction, imm);

wire [31:0] rs1Data, rs2Data;
registerFile rf (writeData, rs1, rs2, rd, regWrite_WB, clk, reset, rs1Data, rs2Data);

// ID/EX Pipeline Register
wire [31:0] IDEX_rs1Data, IDEX_rs2Data, IDEX_imm;
wire [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd;
wire [2:0] IDEX_func3;
wire [6:0] IDEX_func7;
wire IDEX_branch, IDEX_memRead, IDEX_memToReg, IDEX_memWrite, IDEX_aluSrc, IDEX_regWrite;
wire [1:0] IDEX_aluOp;

ID_EX id_ex (
    .clk(clk),
    .reset(reset),
    .rs1Data(rs1Data),
    .rs2Data(rs2Data),
    .imm(imm),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .func3(func3),
    .func7(func7),
    .branch(branch),
    .memRead(memRead),
    .memToReg(memToReg),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .regWrite(regWrite),
    .aluOp(aluOp),

    .rs1DataOut(IDEX_rs1Data),
    .rs2DataOut(IDEX_rs2Data),
    .immOut(IDEX_imm),
    .rs1Out(IDEX_rs1),
    .rs2Out(IDEX_rs2),
    .rdOut(IDEX_rd),
    .func3Out(IDEX_func3),
    .func7Out(IDEX_func7),
    .branchOut(IDEX_branch),
    .memReadOut(IDEX_memRead),
    .memToRegOut(IDEX_memToReg),
    .memWriteOut(IDEX_memWrite),
    .aluSrcOut(IDEX_aluSrc),
    .regWriteOut(IDEX_regWrite),
    .aluOpOut(IDEX_aluOp)
);

// Execute Stage
wire [3:0] operation;
aluControl ac (IDEX_aluOp, {IDEX_func7[5], IDEX_func3}, operation);

wire [31:0] aluSecondOperand;
multiplexer regMux (IDEX_rs2Data, IDEX_imm, IDEX_aluSrc, aluSecondOperand);

wire zero;
wire [31:0] aluResult;
alu64bit alu (IDEX_rs1Data, aluSecondOperand, operation, zero, aluResult);

// Branch decision
wire pcMuxSel;
wire [31:0] branchInsAddress;
adder64 add2 (IFID_pc, IDEX_imm << 1 , branchInsAddress);
branchUnit bu (IDEX_func3, aluResult, zero, IDEX_branch, pcMuxSel);
multiplexer pcMux (nextInsAddress, branchInsAddress, pcMuxSel, pcIn);

// EX/MEM Pipeline Register
wire [31:0] EXMEM_aluResult, EXMEM_rs2Data;
wire [4:0] EXMEM_rd;
wire EXMEM_memRead, EXMEM_memWrite, EXMEM_memToReg, EXMEM_regWrite;

EX_MEM ex_mem (
    .clk(clk),
    .reset(reset),
    .aluResult(aluResult),
    .rs2Data(IDEX_rs2Data),
    .rd(IDEX_rd),
    .memRead(IDEX_memRead),
    .memWrite(IDEX_memWrite),
    .memToReg(IDEX_memToReg),
    .regWrite(IDEX_regWrite),

    .aluResultOut(EXMEM_aluResult),
    .rs2DataOut(EXMEM_rs2Data),
    .rdOut(EXMEM_rd),
    .memReadOut(EXMEM_memRead),
    .memWriteOut(EXMEM_memWrite),
    .memToRegOut(EXMEM_memToReg),
    .regWriteOut(EXMEM_regWrite)
);

// Memory Access
wire [31:0] readData;
dataMemory dm (EXMEM_aluResult, EXMEM_rs2Data, clk, EXMEM_memWrite, EXMEM_memRead, readData);

// MEM/WB Pipeline Register
wire [31:0] MEMWB_readData, MEMWB_aluResult;
wire [4:0] MEMWB_rd;
wire MEMWB_memToReg, regWrite_WB;

MEM_WB mem_wb (
    .clk(clk),
    .reset(reset),
    .readData(readData),
    .aluResult(EXMEM_aluResult),
    .rd(EXMEM_rd),
    .memToReg(EXMEM_memToReg),
    .regWrite(EXMEM_regWrite),

    .readDataOut(MEMWB_readData),
    .aluResultOut(MEMWB_aluResult),
    .rdOut(MEMWB_rd),
    .memToRegOut(MEMWB_memToReg),
    .regWriteOut(regWrite_WB)
);

// Write Back
wire [31:0] writeData;
multiplexer memMux (MEMWB_aluResult, MEMWB_readData, MEMWB_memToReg, writeData);

endmodule