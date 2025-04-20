module EX_MEM(
    input clk, reset,

    input [31:0] aluResult,
    input [31:0] rs2Data,
    input [4:0] rd,

    input memRead,
    input memWrite,
    input memToReg,
    input regWrite,

    output reg [31:0] aluResultOut,
    output reg [31:0] rs2DataOut,
    output reg [4:0] rdOut,

    output reg memReadOut,
    output reg memWriteOut,
    output reg memToRegOut,
    output reg regWriteOut
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        aluResultOut <= 0;
        rs2DataOut <= 0;
        rdOut <= 0;
        memReadOut <= 0;
        memWriteOut <= 0;
        memToRegOut <= 0;
        regWriteOut <= 0;
    end else begin
        aluResultOut <= aluResult;
        rs2DataOut <= rs2Data;
        rdOut <= rd;
        memReadOut <= memRead;
        memWriteOut <= memWrite;
        memToRegOut <= memToReg;
        regWriteOut <= regWrite;
    end
end

endmodule