`timescale 1ns / 1ps

module main_processor(
    input clk,
    input reset
);

    wire [31:0] pc_in;
    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] func3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] func7;
    wire branch;
    wire mem_read;
    wire mem_to_reg;
    wire [1:0] alu_op;
    wire mem_write;
    wire alu_src;
    wire reg_write;
    wire [31:0] imm;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] next_ins_address;
    wire [31:0] branch_ins_address;
    wire [3:0] operation;
    wire [31:0] alu_second_operand;
    wire zero;
    wire [31:0] alu_result;
    wire [31:0] read_data;
    wire [31:0] write_data;
    wire pc_mux_sel;
    // Pipeline registers
    wire [31:0] pc_out_IF_ID;
    wire [31:0] ins_out_IF_ID;
    wire [31:0] pc_out_ID_EX, read_data1_ID_EX, read_data2_ID_EX, imm_ID_EX;
    wire [4:0] rd_ID_EX, rs1_ID_EX, rs2_ID_EX;
    wire [3:0] funct_ID_EX;
    wire branch_ID_EX, memread_ID_EX, memtoreg_ID_EX, memwrite_ID_EX, alusrc_ID_EX, regwrite_ID_EX;
    wire [1:0] aluop_ID_EX;
    wire mem_to_reg_out_EX_MEM, reg_write_out_EX_MEM, branch_out_EX_MEM, mem_write_out_EX_MEM, mem_read_out_EX_MEM, zero_out_EX_MEM;
    wire [31:0] adder_out_EX_MEM, alu_result_out_EX_MEM, mux_out_EX_MEM;
    wire [4:0] rd_out_EX_MEM;
    wire [3:0] funct_out_EX_MEM;
    wire [31:0] readdata_MEM_WB, result_alu_out_MEM_WB;
    wire [4:0] rd_MEM_WB;
    wire Memtoreg_MEM_WB, Regwrite_MEM_WB;
    // Forwarding controls
    wire [1:0] forward_a, forward_b;
    wire [31:0] three_i_mux_out1, three_i_mux_out2;
    // Hazard detection
    wire stall, flush;
    // Flush for taken branches
    wire flush_pipeline = pc_mux_sel;
    // Debug outputs
    wire [7:0] array_out0, array_out1, array_out2, array_out3, array_out4, array_out5, array_out6;
    
    // Module instantiations
    programCounter pc (pc_in, clk, reset, stall, pc_out);
    
    multiplexer pc_mux (next_ins_address, adder_out_EX_MEM, pc_mux_sel, pc_in);
    
    adder64 add_1 (pc_out, 4, next_ins_address);

    instructionMemory im (clk, reset, pc_out, instruction);

    IF_ID if_id (
        .clk(clk), 
        .reset(reset), 
        .stall(stall), 
        .flush(flush_pipeline),
        .pc_in(pc_out), 
        .instruction(instruction), 
        .pc_out(pc_out_IF_ID), 
        .ins_out(ins_out_IF_ID)
    );
       
    instructionParser ip (ins_out_IF_ID, opcode, rd, func3, rs1, rs2, func7);
   
    controlUnit cu (reset, opcode, branch, mem_read, mem_to_reg, alu_op, mem_write, alu_src, reg_write);
   
    registerFile rf (write_data, rs1, rs2, rd_MEM_WB, Regwrite_MEM_WB, clk, reset, rs1_data, rs2_data);
   
    dataExtractor de (ins_out_IF_ID, imm);
   
    ID_EX id_ex (
        .clk(clk), 
        .reset(reset), 
        .flush(flush || flush_pipeline),
        .pc_in(pc_out_IF_ID), 
        .read_data1_in(rs1_data), 
        .read_data2_in(rs2_data), 
        .imm_input(imm),
        .rd_in(rd), 
        .rs1_in(rs1), 
        .rs2_in(rs2), 
        .funct_in({ins_out_IF_ID[30], ins_out_IF_ID[14:12]}),
        .branch_in(branch), 
        .memread_in(mem_read), 
        .memtoreg_in(mem_to_reg),
        .memwrite_in(mem_write), 
        .aluSrc_in(alu_src), 
        .regwrite_in(reg_write), 
        .Aluop_in(alu_op),
        .pc_out(pc_out_ID_EX), 
        .rs1(rs1_ID_EX), 
        .rs2(rs2_ID_EX), 
        .rd(rd_ID_EX), 
        .imm_data(imm_ID_EX),
        .readdata1(read_data1_ID_EX), 
        .readdata2(read_data2_ID_EX), 
        .funct_out(funct_ID_EX),
        .Branch(branch_ID_EX), 
        .Memread(memread_ID_EX), 
        .Memtoreg(memtoreg_ID_EX),
        .Memwrite(memwrite_ID_EX), 
        .Regwrite(regwrite_ID_EX), 
        .Alusrc(alusrc_ID_EX), 
        .aluop(aluop_ID_EX)
    );
    hazardDetectionUnit hdu (
        .rs1_ID(rs1), 
        .rs2_ID(rs2), 
        .rd_EX(rd_ID_EX), 
        .mem_read_EX(memread_ID_EX),
        .branch_ID(branch), 
        .rd_MEM(rd_out_EX_MEM), 
        .reg_write_EX(regwrite_ID_EX),
        .reg_write_MEM(reg_write_out_EX_MEM), 
        .stall(stall), 
        .flush(flush)
    );
    
    three_input_mux mx1(read_data1_ID_EX, write_data, alu_result_out_EX_MEM, forward_a, three_i_mux_out1);

    three_input_mux mx2(read_data2_ID_EX, write_data, alu_result_out_EX_MEM, forward_b, three_i_mux_out2);
    
    forwardingUnit fwd(rs1_ID_EX, rs2_ID_EX, rd_out_EX_MEM, rd_MEM_WB, Regwrite_MEM_WB, reg_write_out_EX_MEM, forward_a, forward_b);
    
    multiplexer reg_mux (three_i_mux_out2, imm_ID_EX, alusrc_ID_EX, alu_second_operand);
    
    adder64 add_2 (pc_out_ID_EX, imm_ID_EX << 1, branch_ins_address);
    
    aluControl ac (aluop_ID_EX, funct_ID_EX, operation);
    
    alu64bit alu (three_i_mux_out1, alu_second_operand, operation, zero, alu_result);

    EX_MEM ex_mem (
        .clk(clk),
        .reset(reset),
        .flush(flush_pipeline),
        .mem_to_reg(memtoreg_ID_EX),
        .reg_write(regwrite_ID_EX),
        .branch(branch_ID_EX),
        .mem_write(memwrite_ID_EX),
        .mem_read(memread_ID_EX),
        .adder_in(branch_ins_address),
        .zero(zero),
        .alu_result(alu_result),
        .mux_in(three_i_mux_out2),
        .rd(rd_ID_EX),
        .funct(funct_ID_EX),
        .mem_to_reg_out(mem_to_reg_out_EX_MEM),
        .reg_write_out(reg_write_out_EX_MEM),
        .branch_out(branch_out_EX_MEM),
        .mem_write_out(mem_write_out_EX_MEM),
        .mem_read_out(mem_read_out_EX_MEM),
        .adder_out(adder_out_EX_MEM),
        .zero_out(zero_out_EX_MEM),
        .alu_result_out(alu_result_out_EX_MEM),
        .mux_out(mux_out_EX_MEM),
        .rd_out(rd_out_EX_MEM),
        .funct_out(funct_out_EX_MEM)
    );
    
    branchUnit bu (funct_out_EX_MEM[2:0], alu_result_out_EX_MEM, zero_out_EX_MEM, branch_out_EX_MEM, pc_mux_sel);
    
    dataMemory dm (alu_result_out_EX_MEM, mux_out_EX_MEM, clk, mem_write_out_EX_MEM, mem_read_out_EX_MEM, read_data, array_out0, array_out1, array_out2, array_out3, array_out4, array_out5, array_out6);
    
    MEM_WB mem_wb (
        .clk(clk),
        .reset(reset),
        .read_data_in(read_data),
        .result_alu_in(alu_result_out_EX_MEM),
        .Rd_in(rd_out_EX_MEM),
        .memtoreg_in(mem_to_reg_out_EX_MEM),
        .regwrite_in(reg_write_out_EX_MEM),
        .readdata(readdata_MEM_WB),
        .result_alu_out(result_alu_out_MEM_WB),
        .rd(rd_MEM_WB),
        .Memtoreg(Memtoreg_MEM_WB),
        .Regwrite(Regwrite_MEM_WB)
    );
    
    multiplexer mem_mux (result_alu_out_MEM_WB, readdata_MEM_WB, Memtoreg_MEM_WB, write_data);

endmodule