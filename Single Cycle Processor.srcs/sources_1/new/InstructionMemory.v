
`timescale 1ns / 1ps
module instructionMemory(
    input clk,
    input reset,
    input [31:0] instruction_address,
    output reg[31:0] instruction
);
    reg [7:0] ins_mem [7:0];

initial begin
{ins_mem[3], ins_mem[2], ins_mem[1], ins_mem[0]}     = 32'h00600293;
{ins_mem[7], ins_mem[6], ins_mem[5], ins_mem[4]}     = 32'h10502023;

    end
always @(*)
    begin
    if (reset)
        instruction <= 0;
    else if (clk)
    begin
        instruction[7:0] <= ins_mem[instruction_address];
        instruction[15:8] <= ins_mem[instruction_address + 1];
        instruction[23:16] <= ins_mem[instruction_address + 2];
        instruction[31:24] <= ins_mem[instruction_address + 3];
        end
    end    

endmodule