module ID_EX(
    input clk, reset,
    input [31:0] rs1Data, rs2Data, imm,
    input [4:0] rs1, rs2, rd,
    input [2:0] func3,
    input [6:0] func7,
    input branch, memRead, memToReg, memWrite, aluSrc, regWrite,
    input [1:0] aluOp,

    output reg [31:0] rs1DataOut, rs2DataOut, immOut,
    output reg [4:0] rs1Out, rs2Out, rdOut,
    output reg [2:0] func3Out,
    output reg [6:0] func7Out,
    output reg branchOut, memReadOut, memToRegOut, memWriteOut, aluSrcOut, regWriteOut,
    output reg [1:0] aluOpOut
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        rs1DataOut <= 0; rs2DataOut <= 0; immOut <= 0;
        rs1Out <= 0; rs2Out <= 0; rdOut <= 0;
        func3Out <= 0; func7Out <= 0;
        branchOut <= 0; memReadOut <= 0; memToRegOut <= 0;
        memWriteOut <= 0; aluSrcOut <= 0; regWriteOut <= 0;
        aluOpOut <= 0;
    end else begin
        rs1DataOut <= rs1Data;
        rs2DataOut <= rs2Data;
        immOut <= imm;
        rs1Out <= rs1;
        rs2Out <= rs2;
        rdOut <= rd;
        func3Out <= func3;
        func7Out <= func7;
        branchOut <= branch;
        memReadOut <= memRead;
        memToRegOut <= memToReg;
        memWriteOut <= memWrite;
        aluSrcOut <= aluSrc;
        regWriteOut <= regWrite;
        aluOpOut <= aluOp;
    end
end

endmodule