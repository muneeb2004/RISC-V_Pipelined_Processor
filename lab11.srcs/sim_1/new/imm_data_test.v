`timescale 1ns / 1ps

module imm_data_test();
    reg [31:0] instruction; 
    wire [63:0] imm_data;
    
    immediate_data_extractor get_imm_data (instruction, imm_data);
    initial begin

    instruction = 32'b00000010001100100011000100100011;
    #100
    instruction = 32'b10000010001100100011000100000011;
    #100
    instruction = 32'b00000000001000001001001001100011;
    end
endmodule
