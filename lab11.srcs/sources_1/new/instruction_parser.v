module instruction_parser(
    input [31:0] Instruction, output [6:0] opcode, output [4:0] rd,
    output [2:0] funct3, output [4:0] rs1, output [4:0] rs2, output [6:0] funct7
    );
    
    assign opcode = Instruction[6:0];
    assign rd = Instruction[11:7];
    assign funct3 = Instruction[14:12];
    assign rs1 = Instruction[19:15];
    assign rs2 = Instruction[24:20];
    assign funct7 = Instruction[31:25];
endmodule