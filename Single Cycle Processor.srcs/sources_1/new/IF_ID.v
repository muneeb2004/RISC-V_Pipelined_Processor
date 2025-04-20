module IF_ID (
    input clk,
    input reset,
    input [31:0] pcIn,
    input [31:0] instructionIn,
    output reg [31:0] pcOut,
    output reg [31:0] instructionOut
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        pcOut <= 0;
        instructionOut <= 0;
    end else begin
        pcOut <= pcIn;
        instructionOut <= instructionIn;
    end
end

endmodule