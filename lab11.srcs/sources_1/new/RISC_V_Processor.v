module RISC_V_Processor(
    input clk,
    input reset,
    output [4:0] rd_out, rs1_out, rs2_out,
    output [63:0] ReadData1_out, ReadData2_out,
    output [63:0] IDEX_ReadData1_out, IDEX_ReadData2_out,
    output [4:0] IDEX_rd_out,
    output [63:0] EXMEM_ReadData2_out,
    output [4:0] EXMEM_rd_out,
    output [63:0] MEMWB_DM_Read_Data_out,
    output [4:0] MEMWB_rd_out
);
    // Program Counter
    wire [63:0] PC_In;
    wire [63:0] PC_Out;
    Program_Counter a1(clk, reset, PC_In, PC_Out);

    // PC + 4 Adder
    wire [63:0] pc4;
    Adder b1(PC_Out, 64'd4, pc4);

    // Instruction Memory (IF Stage)
    wire [31:0] Instruction;
    Instruction_Memory c1(PC_Out, Instruction);

    // IF/ID Pipeline Register
    wire [63:0] PC_IFID;
    wire [31:0] Instruction_IFID;
    IF_ID if_id_reg(clk, PC_Out, Instruction, PC_IFID, Instruction_IFID);

    // Decode Stage Components
    wire switch_branch;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;
    assign rd_out = rd;
    assign rs1_out = rs1;
    assign rs2_out = rs2;

    instruction_parser d1(Instruction_IFID, opcode, rd, funct3, rs1, rs2, funct7);

    // Control Unit
    wire [3:0] funct;
    assign funct = {Instruction_IFID[30], Instruction_IFID[14:12]};

    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire [3:0] Operation;
    top_control g1(opcode, funct, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Operation);

    // Immediate Generator
    wire [63:0] imm_data;
    immediate_data_extractor e1(Instruction_IFID, imm_data);

    // Branch Calculation
    wire [63:0] PC_Branch;
    wire [63:0] imm_left = imm_data << 1;
    Adder f1(PC_IFID, imm_left, PC_Branch);

    // ID/EX Pipeline Register
    wire [63:0] PC_IDEX;
    wire [63:0] ReadData1, ReadData2;
    wire [4:0] rd_IDEX;
    wire [3:0] Operation_IDEX;
    wire [2:0] funct3_IDEX;
    wire Branch_IDEX, MemRead_IDEX, MemtoReg_IDEX, MemWrite_IDEX, ALUSrc_IDEX, RegWrite_IDEX;
    wire [63:0] imm_data_IDEX;
    wire [4:0] rs1_IDEX, rs2_IDEX;

    ID_EX id_ex_stage (
        .clk(clk),
        .PC_IFID(PC_IFID),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .imm_data(imm_data),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .Operation(Operation),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .funct3(funct3),
        .PC_IDEX(PC_IDEX),
        .ReadData1_IDEX(IDEX_ReadData1_out),
        .ReadData2_IDEX(IDEX_ReadData2_out),
        .imm_data_IDEX(imm_data_IDEX),
        .rs1_IDEX(rs1_IDEX),
        .rs2_IDEX(rs2_IDEX),
        .rd_IDEX(IDEX_rd_out),
        .Operation_IDEX(Operation_IDEX),
        .Branch_IDEX(Branch_IDEX),
        .MemRead_IDEX(MemRead_IDEX),
        .MemtoReg_IDEX(MemtoReg_IDEX),
        .MemWrite_IDEX(MemWrite_IDEX),
        .ALUSrc_IDEX(ALUSrc_IDEX),
        .RegWrite_IDEX(RegWrite_IDEX),
        .funct3_IDEX(funct3_IDEX)
    );

    assign ReadData1_out = ReadData1;
    assign ReadData2_out = ReadData2;

    // EX Stage Components
    wire [63:0] ALU_input_b;
    mux alu_input_mux(ReadData2_IDEX, imm_data_IDEX, ALUSrc_IDEX, ALU_input_b);

    wire C_In = (Operation_IDEX == 4'b0011) ? 1 : 0;
    wire C_Out, zero;
    wire [63:0] Result;
    ALU_64_bit j1(ReadData1_IDEX, ALU_input_b, C_In, Operation_IDEX, C_Out, zero, Result);

    // EX/MEM Pipeline Register
    wire [63:0] Result_EXMEM;
    wire [63:0] ReadData2_EXMEM;
    wire [4:0] rd_EXMEM;
    wire [2:0] funct3_EXMEM;
    wire Branch_EXMEM, MemRead_EXMEM, MemtoReg_EXMEM, MemWrite_EXMEM, RegWrite_EXMEM, zero_EXMEM;

    EX_MEM ex_mem_stage (
        .clk(clk),
        .Result(Result),
        .ReadData2_IDEX(IDEX_ReadData2_out),
        .rd_IDEX(IDEX_rd_out),
        .Branch_IDEX(Branch_IDEX),
        .MemRead_IDEX(MemRead_IDEX),
        .MemtoReg_IDEX(MemtoReg_IDEX),
        .MemWrite_IDEX(MemWrite_IDEX),
        .RegWrite_IDEX(RegWrite_IDEX),
        .zero(zero),
        .funct3_IDEX(funct3_IDEX),
        .ALU_Result_EXMEM(Result_EXMEM),
        .ReadData2_EXMEM(EXMEM_ReadData2_out),
        .rd_EXMEM(EXMEM_rd_out),
        .Branch_EXMEM(Branch_EXMEM),
        .MemRead_EXMEM(MemRead_EXMEM),
        .MemtoReg_EXMEM(MemtoReg_EXMEM),
        .MemWrite_EXMEM(MemWrite_EXMEM),
        .RegWrite_EXMEM(RegWrite_EXMEM),
        .zero_EXMEM(zero_EXMEM),
        .funct3_EXMEM(funct3_EXMEM)
    );

    // MEM Stage
    wire [63:0] Read_Data;
    Data_Memory l1(Result_EXMEM, EXMEM_ReadData2_out, clk, MemWrite_EXMEM, MemRead_EXMEM, Read_Data);

    Branch branch_unit (
        .Branch(Branch_EXMEM),
        .ZERO(zero_EXMEM),
        .Isgreater(Result_EXMEM[63] == 0),
        .funct3(funct3_EXMEM),
        .switch_branch(switch_branch)
    );

    // MEM/WB Pipeline Register
    wire [63:0] Read_Data_MEMWB;
    wire [63:0] ALU_Result_MEMWB;
    wire [4:0] rd_MEMWB;
    wire MemtoReg_MEMWB, RegWrite_MEMWB;

    MEM_WB mem_wb_reg (
        .clk(clk),
        .Read_Data(Read_Data),
        .ALU_Result_EXMEM(Result_EXMEM),
        .rd_EXMEM(EXMEM_rd_out),
        .MemtoReg_EXMEM(MemtoReg_EXMEM),
        .RegWrite_EXMEM(RegWrite_EXMEM),
        .Read_Data_MEMWB(MEMWB_DM_Read_Data_out),
        .ALU_Result_MEMWB(ALU_Result_MEMWB),
        .rd_MEMWB(MEMWB_rd_out),
        .MemtoReg_MEMWB(MemtoReg_MEMWB),
        .RegWrite_MEMWB(RegWrite_MEMWB)
    );

    // WB Stage
    wire [63:0] WriteData;
    mux final_write_mux(ALU_Result_MEMWB, MEMWB_DM_Read_Data_out, MemtoReg_MEMWB, WriteData);

    registerFile h1(
        WriteData,
        rs1,
        rs2,
        MEMWB_rd_out,
        RegWrite_MEMWB,
        clk,
        reset,
        ReadData1,
        ReadData2
    );

    // PC Selection Logic
    mux pc_mux(pc4, PC_Branch, switch_branch, PC_In);
    
    always @(*) begin
        $display("Branch Taken: %b, Target: %h", switch_branch, PC_Branch);
    end
endmodule