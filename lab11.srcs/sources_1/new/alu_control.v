`timescale 1ns / 1ps

module alu_control(
input [1:0] ALUOp,
input [3:0] funct,
output reg[3:0] Operation 
);
always @(*)
begin 
if (ALUOp == 2'b00) 
    begin 
    Operation = 4'b0010;
    end
else if (ALUOp == 2'b01) 
    begin 
    Operation = 4'b0110;
    end
else if (ALUOp == 2'b10) 
    begin 
    if (funct == 4'b0000) 
        begin 
        Operation = 4'b0010;
        end
    if (funct == 4'b1000) 
        begin 
        Operation = 4'b0110;
        end
    if (funct == 4'b0111) 
        begin 
        Operation = 4'b0000;
        end
    if (funct == 4'b0110) 
        begin 
        Operation = 4'b0001;
        end
    end
end
endmodule

