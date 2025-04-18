module EX_MEM (
    input clk,
    input [63:0] Result,
    input [63:0] ReadData2_IDEX,
    input [4:0] rd_IDEX,
    input Branch_IDEX, MemRead_IDEX, MemtoReg_IDEX, MemWrite_IDEX, RegWrite_IDEX,
    input zero,
    input funct3_IDEX,
    
    output reg [63:0] ALU_Result_EXMEM,
    output reg [63:0] ReadData2_EXMEM,
    output reg [4:0] rd_EXMEM,
    output reg Branch_EXMEM, MemRead_EXMEM, MemtoReg_EXMEM, MemWrite_EXMEM, RegWrite_EXMEM,
    output reg zero_EXMEM,
    output reg funct3_EXMEM
);
    always @(posedge clk) begin
        ALU_Result_EXMEM <= Result;
        ReadData2_EXMEM <= ReadData2_IDEX;
        rd_EXMEM <= rd_IDEX;
        Branch_EXMEM <= Branch_IDEX;
        MemRead_EXMEM <= MemRead_IDEX;
        MemtoReg_EXMEM <= MemtoReg_IDEX;
        MemWrite_EXMEM <= MemWrite_IDEX;
        RegWrite_EXMEM <= RegWrite_IDEX;
        zero_EXMEM <= zero;
    end
endmodule