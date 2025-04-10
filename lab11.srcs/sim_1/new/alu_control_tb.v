`timescale 1ns / 1ps

module alu_control_tb();

reg [1:0] ALUop;
reg [3:0] funct;
wire [3:0] operation ;

alu_control tb(ALUop,funct,operation);

initial begin 
    ALUop = 2'b00;
    #50
    ALUop = 2'b01;
    #50
    ALUop = 2'b10;
    funct = 4'b0000;
    #50
    funct = 4'b1000;
    #50
    funct = 4'b0111;
    #50
    funct = 4'b0110;

end
endmodule
