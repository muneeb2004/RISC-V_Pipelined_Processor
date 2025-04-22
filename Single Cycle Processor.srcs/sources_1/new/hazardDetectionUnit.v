`timescale 1ns / 1ps

module hazardDetectionUnit (
    input [4:0] rs1_ID, rs2_ID,          // Source registers from ID stage
    input [4:0] rd_EX,                   // Destination register in EX stage
    input mem_read_EX,                   // Load instruction in EX stage (memread_ID_EX)
    input branch_ID,                     // Branch instruction in ID stage
    input [4:0] rd_MEM,                  // Destination register in MEM stage
    input reg_write_EX, reg_write_MEM,   // Register write enables
    output reg stall,                    // Stall pipeline (freeze PC, IF/ID)
    output reg flush                     // Flush ID/EX (insert NOP)
);

    always @(*) begin
        // Initialize outputs
        stall = 0;
        flush = 0;
    
        // Load-use hazard
        if (mem_read_EX && ((rd_EX == rs1_ID) || (rd_EX == rs2_ID)) && (rd_EX != 0)) begin
            stall = 1;  // Stall PC and IF/ID
            flush = 1;  // Insert NOP in ID/EX
        end
    
        // Branch hazard
        if (branch_ID && (
            (reg_write_EX && (rd_EX == rs1_ID || rd_EX == rs2_ID) && rd_EX != 0) ||
            (reg_write_MEM && (rd_MEM == rs1_ID || rd_MEM == rs2_ID) && rd_MEM != 0)
        )) begin
            stall = 1;  // Stall PC and IF/ID
            flush = 1;  // NOP in ID/EX
        end
    end
    
endmodule