`timescale 1ns / 1ps

module testbench_DataMemory();

reg [63:0] Mem_Addr;
reg [63:0] Write_Data;
reg clk;
reg MemWrite;
reg MemRead;
wire [63:0] Read_Data;
Data_Memory testmodule(Mem_Addr,Write_Data,clk,MemWrite, MemRead ,Read_Data);
initial begin
clk = 1 ;
Write_Data=100;
MemWrite = 1;
MemRead = 1 ;
Mem_Addr = 1;
#200
Write_Data=200;
MemWrite = 1;
MemRead = 0;
Mem_Addr = 1;
#200
Write_Data=300;
MemWrite = 0;
MemRead = 1;
Mem_Addr = 1;
end 
always 
#100 
clk = ~clk;
endmodule