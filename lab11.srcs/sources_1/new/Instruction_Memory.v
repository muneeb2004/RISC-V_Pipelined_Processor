module Instruction_Memory
(
    input [63:0] Inst_Addr,
    output [31:0] Instruction
);

reg [7:0] Inst_Mem [127:0];

initial begin

    // insertion sort (64-bit version using ld/sd)

    // addi x12, x0, 1
    {Inst_Mem[3], Inst_Mem[2], Inst_Mem[1], Inst_Mem[0]} = 32'h01000106;

//    // beq x12, x11, end
//    {Inst_Mem[7], Inst_Mem[6], Inst_Mem[5], Inst_Mem[4]} = 32'h04b10ccc;

//    // slli x15, x12, 3
//    {Inst_Mem[11], Inst_Mem[10], Inst_Mem[9], Inst_Mem[8]} = 32'h00197e18;

//    // add x15, x10, x15
//    {Inst_Mem[15], Inst_Mem[14], Inst_Mem[13], Inst_Mem[12]} = 32'h00a7e2b3;

//    // ld x14, 0(x15)
//    {Inst_Mem[19], Inst_Mem[18], Inst_Mem[17], Inst_Mem[16]} = 32'h0007f703;

//    // addi x13, x12, -1
//    {Inst_Mem[23], Inst_Mem[22], Inst_Mem[21], Inst_Mem[20]} = 32'hff86c1fe;

//    // blt x13, x0, insert
//    {Inst_Mem[27], Inst_Mem[26], Inst_Mem[25], Inst_Mem[24]} = 32'h20360cc6;

//    // slli x15, x13, 3
//    {Inst_Mem[31], Inst_Mem[30], Inst_Mem[29], Inst_Mem[28]} = 32'h001a7e18;

//    // add x15, x10, x15
//    {Inst_Mem[35], Inst_Mem[34], Inst_Mem[33], Inst_Mem[32]} = 32'h00a7e2b3;

//    // ld x16, 0(x15)
//    {Inst_Mem[39], Inst_Mem[38], Inst_Mem[37], Inst_Mem[36]} = 32'h00070f03;

//    // bge x14, x16, insert
//    {Inst_Mem[43], Inst_Mem[42], Inst_Mem[41], Inst_Mem[40]} = 32'h10e77ae6;

//    // addi x17, x13, 1
//    {Inst_Mem[47], Inst_Mem[46], Inst_Mem[45], Inst_Mem[44]} = 32'h018e8801;

//    // slli x17, x17, 3
//    {Inst_Mem[51], Inst_Mem[50], Inst_Mem[49], Inst_Mem[48]} = 32'h00198f18;

//    // add x17, x10, x17
//    {Inst_Mem[55], Inst_Mem[54], Inst_Mem[53], Inst_Mem[52]} = 32'h01a882b3;

//    // sd x16, 0(x17)
//    {Inst_Mem[59], Inst_Mem[58], Inst_Mem[57], Inst_Mem[56]} = 32'h01c8b023;

//    // addi x13, x13, -1
//    {Inst_Mem[63], Inst_Mem[62], Inst_Mem[61], Inst_Mem[60]} = 32'hff86c1fe;

//    // beq x0, x0, loop_j
//    {Inst_Mem[67], Inst_Mem[66], Inst_Mem[65], Inst_Mem[64]} = 32'hfc0000e3;

//    // addi x15, x13, 1
//    {Inst_Mem[71], Inst_Mem[70], Inst_Mem[69], Inst_Mem[68]} = 32'h01868701;

//    // slli x15, x15, 3
//    {Inst_Mem[75], Inst_Mem[74], Inst_Mem[73], Inst_Mem[72]} = 32'h00197e18;

//    // add x15, x10, x15
//    {Inst_Mem[79], Inst_Mem[78], Inst_Mem[77], Inst_Mem[76]} = 32'h00a7e2b3;

//    // sd x14, 0(x15)
//    {Inst_Mem[83], Inst_Mem[82], Inst_Mem[81], Inst_Mem[80]} = 32'h01e70e23;

//    // addi x12, x12, 1
//    {Inst_Mem[87], Inst_Mem[86], Inst_Mem[85], Inst_Mem[84]} = 32'h01868601;

//    // beq x0, x0, loop_i
//    {Inst_Mem[91], Inst_Mem[90], Inst_Mem[89], Inst_Mem[88]} = 32'hfa0000e3;

//    // end: beq x0, x0, end
//    {Inst_Mem[95], Inst_Mem[94], Inst_Mem[93], Inst_Mem[92]} = 32'h00000003;

end

assign Instruction = {Inst_Mem[Inst_Addr + 3], Inst_Mem[Inst_Addr + 2],
                      Inst_Mem[Inst_Addr + 1], Inst_Mem[Inst_Addr]};

endmodule