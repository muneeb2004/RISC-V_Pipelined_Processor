module MEM_WB(
    input clk, reset,

    input [31:0] readData,
    input [31:0] aluResult,
    input [4:0] rd,

    input memToReg,
    input regWrite,

    output reg [31:0] readDataOut,
    output reg [31:0] aluResultOut,
    output reg [4:0] rdOut,

    output reg memToRegOut,
    output reg regWriteOut
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        readDataOut <= 0;
        aluResultOut <= 0;
        rdOut <= 0;
        memToRegOut <= 0;
        regWriteOut <= 0;
    end else begin
        readDataOut <= readData;
        aluResultOut <= aluResult;
        rdOut <= rd;
        memToRegOut <= memToReg;
        regWriteOut <= regWrite;
    end
end

endmodule