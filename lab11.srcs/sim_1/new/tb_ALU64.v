`timescale 1ns / 1ps
module testbench_64bit();
reg [63:0] a;
reg [63:0] b;
reg [3:0] ALUOp;
wire [63:0] Result;
wire Zero;
ALU_64_bit tb(a, b, ALUOp, Result, Zero);
initial
begin
    a = 64'd10;
    b = 64'd20;
    ALUOp=4'b0010; // Add
    #100;
    a = 64'd15; 
    b = 64'd25;
    ALUOp = 4'b0001; // OR
    #100;
    a = 64'd30;
    b = 64'd10;
    ALUOp=4'b0110; // Subtract
    #100;
    a = 64'd50;
    b = 64'd15;
    ALUOp=4'b1100; // NOR
    #100;
    a = 64'd100;
    b = 64'd50;
    ALUOp=4'b0000; // AND
    #100;

end 
endmodule


module tb_ALU64(

    );
endmodule
