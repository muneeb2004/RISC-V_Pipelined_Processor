`timescale 1ns / 1ps

module dataExtractor(
    input [31:0] instruction,
    output [31:0] imm
    );
    
    // I-type instruction (if instruction[6:5] == 2'b00)
    wire [63:0] imm_i = {{20{instruction[31]}}, instruction[31:20]};
    // S-type instruction (if instruction[6:5] == 2'b01)
    wire [63:0] imm_s = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    // SB-type instruction (if instruction[6:5] == 2'b11)
    wire [63:0] imm_sb = {{20{instruction[31]}}, instruction[31],  instruction[7], instruction[30:25], instruction[11:8]};

    // Final imm based on instruction[6:5] using a mux structure
    assign imm = (instruction[6:5] == 2'b00) ? imm_i :
                 (instruction[6:5] == 2'b01) ? imm_s :
                 (instruction[6:5] == 2'b11) ? imm_sb :
                 32'b0;
                 
endmodule
