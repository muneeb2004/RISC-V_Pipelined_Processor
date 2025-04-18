module registerFile(
    input [63:0] WriteData,
    input [4:0] rs1, rs2, rd,
    input RegWrite, clk, reset,
    output reg [63:0] ReadData1, ReadData2
);

    reg [63:0] Registers [31:0];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            Registers[i] = i;
        end
    end

    always @(posedge clk) begin
        if (RegWrite == 1)
            Registers[rd] = WriteData;
    end

    always @(*) begin
        if (reset == 1) begin
            ReadData1 = 0;
            ReadData2 = 0;
        end else begin
            ReadData1 = Registers[rs1];
            ReadData2 = Registers[rs2];
        end
    end
endmodule