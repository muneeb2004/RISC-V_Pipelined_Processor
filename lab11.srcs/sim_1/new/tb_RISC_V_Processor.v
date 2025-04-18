`timescale 1ns / 1ps

module tb_RISC_V_Processor;

    // Clock and reset
    reg clk;
    reg reset;

    // Outputs from the processor for observation
    wire [4:0] rd_out, rs1_out, rs2_out;
    wire [63:0] ReadData1_out, ReadData2_out;
    wire [63:0] IDEX_ReadData1_out, IDEX_ReadData2_out;
    wire [4:0] IDEX_rd_out;
    wire [63:0] EXMEM_ReadData2_out;
    wire [4:0] EXMEM_rd_out;
    wire [63:0] MEMWB_DM_Read_Data_out;
    wire [4:0] MEMWB_rd_out;

    // Instantiate the processor
    RISC_V_Processor uut (
        .clk(clk),
        .reset(reset),
        .rd_out(rd_out),
        .rs1_out(rs1_out),
        .rs2_out(rs2_out),
        .ReadData1_out(ReadData1_out),
        .ReadData2_out(ReadData2_out),
        .IDEX_ReadData1_out(IDEX_ReadData1_out),
        .IDEX_ReadData2_out(IDEX_ReadData2_out),
        .IDEX_rd_out(IDEX_rd_out),
        .EXMEM_ReadData2_out(EXMEM_ReadData2_out),
        .EXMEM_rd_out(EXMEM_rd_out),
        .MEMWB_DM_Read_Data_out(MEMWB_DM_Read_Data_out),
        .MEMWB_rd_out(MEMWB_rd_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting simulation...");
        $monitor("Time: %0t | PC=%h | rd=%d | rs1=%d | rs2=%d | WriteBack Reg=%d",
                  $time, uut.PC_Out, rd_out, rs1_out, rs2_out, MEMWB_rd_out);

        // Initialize inputs
        clk = 0;
        reset = 1;

        // Hold reset for a few cycles
        #10 reset = 0;

        // Run the simulation
        #200 $finish;
    end

endmodule