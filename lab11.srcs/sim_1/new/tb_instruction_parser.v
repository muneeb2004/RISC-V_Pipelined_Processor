`timescale 1ns / 1ps

module tb_instruction_parser();

    reg [31:0] instruction;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;
    
    instruction_parser ParseTest(instruction, opcode, rd, funct3, rs1, rs2, funct7);
    
    initial
    begin
    
        instruction = 32'b10101010101010101010101010101010;
        #100
        instruction = 32'b11001100110011001100110011001100;
        #100
        instruction = 32'b11110000111100001111000011110000;
        #100
        instruction = 32'b01101110011011110110111101110111;
    end
    
endmodule
