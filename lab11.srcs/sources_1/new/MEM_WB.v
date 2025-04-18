module MEM_WB (
    input clk,
    input [63:0] Read_Data,
    input [63:0] ALU_Result_EXMEM,
    input [4:0] rd_EXMEM,
    input MemtoReg_EXMEM,
    input RegWrite_EXMEM,

    output reg [63:0] Read_Data_MEMWB,
    output reg [63:0] ALU_Result_MEMWB,
    output reg [4:0] rd_MEMWB,
    output reg MemtoReg_MEMWB,
    output reg RegWrite_MEMWB
);
    always @(posedge clk) begin
        Read_Data_MEMWB <= Read_Data;
        ALU_Result_MEMWB <= ALU_Result_EXMEM;
        rd_MEMWB <= rd_EXMEM;
        MemtoReg_MEMWB <= MemtoReg_EXMEM;
        RegWrite_MEMWB <= RegWrite_EXMEM;
    end
endmodule