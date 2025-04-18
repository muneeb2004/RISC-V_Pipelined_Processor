module ID_EX (
    input [2:0] funct3,
    input clk,
    input [63:0] PC_IFID,
    input [63:0] ReadData1,
    input [63:0] ReadData2,
    input [63:0] imm_data,
    input [4:0] rs1, rs2, rd,
    input [3:0] Operation,
    input Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    
    output reg [63:0] PC_IDEX,
    output reg [63:0] ReadData1_IDEX,
    output reg [63:0] ReadData2_IDEX,
    output reg [63:0] imm_data_IDEX,
    output reg [4:0] rs1_IDEX, rs2_IDEX, rd_IDEX,
    output reg [3:0] Operation_IDEX,
    output reg Branch_IDEX, MemRead_IDEX, MemtoReg_IDEX, MemWrite_IDEX, ALUSrc_IDEX, RegWrite_IDEX,
    output reg [2:0] funct3_IDEX
);
    always @(posedge clk) begin
        PC_IDEX <= PC_IFID;
        ReadData1_IDEX <= ReadData1;
        ReadData2_IDEX <= ReadData2;
        imm_data_IDEX <= imm_data;
        rs1_IDEX <= rs1;
        rs2_IDEX <= rs2;
        rd_IDEX <= rd;
        Operation_IDEX <= Operation;
        Branch_IDEX <= Branch;
        MemRead_IDEX <= MemRead;
        MemtoReg_IDEX <= MemtoReg;
        MemWrite_IDEX <= MemWrite;
        ALUSrc_IDEX <= ALUSrc;
        RegWrite_IDEX <= RegWrite;
        funct3_IDEX <= funct3;
    end
endmodule