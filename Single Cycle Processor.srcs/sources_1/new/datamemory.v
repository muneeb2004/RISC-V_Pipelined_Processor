`timescale 1ns / 1ps
module dataMemory(
    input [31:0] mem_addr,
    input[31:0] write_data,
    input clk,
    input mem_write,
    input mem_read,
    output [31:0] read_data,
    
    output [7:0] array_out0,
    output [7:0] array_out1,
    output [7:0] array_out2,
    output [7:0] array_out3,
    output [7:0] array_out4,
    output [7:0] array_out5,
    output [7:0] array_out6
 
);
    reg [7:0] array [6:0];
    reg [7:0] memory [511:0];
    integer i;
    initial begin 
    for (i =0; i < 512; i=i+1) begin
    
        memory[i] = 32'b0;
        
        end
    end
    
    
    assign read_data[7:0] = mem_read? memory[mem_addr]: 8'b0;
    assign read_data[15:8] = mem_read? memory[mem_addr+1]: 8'b0;
    assign read_data[23:16] = mem_read? memory[mem_addr+2]: 8'b0;
    assign read_data[31:24] = mem_read? memory[mem_addr+3]: 8'b0;
    
    assign array_out0 = array[0];
    assign array_out1 = array[1];
    assign array_out2 = array[2];
    assign array_out3 = array[3];
    assign array_out4 = array[4];
    assign array_out5 = array[5];
    assign array_out6 = array[6];
    
    
    always @(posedge clk) begin
        if (mem_write) begin
            memory[mem_addr] = write_data[7:0];
            memory[mem_addr+1] = write_data[15:8];
            memory[mem_addr+2] = write_data[23:16];
            memory[mem_addr+3] = write_data[31:24];
            
            
            array[0] = memory[256];
            array[1] = memory[260];
            array[2] = memory[264];
            array[3] = memory[268];
            array[4] = memory[272];
            array[5] = memory[276];
            array[6] = memory[280];
            
        end
    end
endmodule
