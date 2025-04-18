module IF_ID (
    input clk,
    input [63:0] PC_Out,
    input [31:0] Instruction,
    output reg [63:0] PC_IFID,
    output reg [31:0] Instruction_IFID
);
    always @(posedge clk) begin
        PC_IFID <= PC_Out;
        Instruction_IFID <= Instruction;
    end
endmodule