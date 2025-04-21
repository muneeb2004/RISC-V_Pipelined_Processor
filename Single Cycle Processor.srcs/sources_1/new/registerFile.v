`timescale 1ns / 1ps
module registerFile(
    input [31:0] write_data,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input reg_write,
    input clk,
    input reset,
    output reg [31:0] read_data_1,
    output reg [31:0] read_data_2
    );
    
    reg [31:0] registers [31:0];
    
    integer i;
    initial begin
        // project
        registers[0] = 0;
        for (i = 1; i < 32; i = i + 1)
            registers[i] = i + 32'b1;
            
        // lab 
//        for (i = 0; i < 63; i = i + 1)
//            registers[i] = i;
        
    end
    
//    always registers[0] <= 0;
    
    always @(posedge clk) begin
        if (reg_write)
            registers[rd] <= write_data;
    end
    
    
    always @(*) begin
        registers[0] <= 0;
        if (~reset) begin
            read_data_1 <= registers[rs1];
            read_data_2 <= registers[rs2];
        end else begin
            read_data_1 <= 32'b0;
            read_data_2 <= 32'b0;
        end
    end 
    
endmodule