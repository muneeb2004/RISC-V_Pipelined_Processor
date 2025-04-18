module tb_Pipeline();                   

    reg clk, reset;       
    wire [4:0] rd_out, rs1_out, rs2_out; 
    wire [63:0] ReadData1_out, ReadData2_out, IDEX_ReadData1_out, IDEX_ReadData2_out; 
    wire [4:0] IDEX_rd_out; 
    wire [63:0] EXMEM_ReadData2_out; 
    wire [4:0] EXMEM_rd_out;
    wire [63:0] MEMWB_DM_Read_Data_out;
    wire [4:0] MEMWB_rd_out;

    // Corrected module name (case-sensitive!)
    RISC_V_Processor ris (
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

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns clock period

    // Reset Logic
    initial begin
        reset = 1;
        #12 reset = 0;  // Deassert reset after some time

        // Run simulation
        #200 $finish;   // Stop after 200 time units
    end

    // Monitoring Outputs (Optional, useful for debugging)
    always @(posedge clk) begin
        $display("Time: %0t | rd: %d, rs1: %d, rs2: %d", $time, rd_out, rs1_out, rs2_out);
        $display("ReadData1: %h | ReadData2: %h", ReadData1_out, ReadData2_out);
        $display("ID/EX ReadData1: %h | ReadData2: %h | rd: %d", IDEX_ReadData1_out, IDEX_ReadData2_out, IDEX_rd_out);
        $display("EX/MEM ReadData2: %h | rd: %d", EXMEM_ReadData2_out, EXMEM_rd_out);
        $display("MEM/WB ReadData: %h | rd: %d\n", MEMWB_DM_Read_Data_out, MEMWB_rd_out);
    end

endmodule