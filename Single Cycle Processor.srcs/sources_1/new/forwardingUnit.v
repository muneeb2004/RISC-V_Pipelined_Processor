`timescale 1ns / 1ps

module forwardingUnit(
    input [4:0] RS_1,       // ID/EX.RegisterRs1
    input [4:0] RS_2,       // ID/EX.RegisterRs2
    input [4:0] rdMem,      // EX/MEM.Register Rd
    input [4:0] rdWb,       // MEM/WB.RegisterRd
    input regWrite_Wb,      // MEM/WB.RegWrite
    input regWrite_Mem,     // EX/MEM.RegWrite
    output reg [1:0] Forward_A,
    output reg [1:0] Forward_B
);

    always @(*) begin
        // Forward_A logic
        if (regWrite_Mem == 1 && rdMem != 0 && rdMem == RS_1) begin
            Forward_A = 2'b10;  // Forward from EX/MEM
        end
        else if (regWrite_Wb == 1 && rdWb != 0 && rdWb == RS_1 && !(regWrite_Mem == 1 && rdMem != 0 && rdMem == RS_1)) begin
            Forward_A = 2'b01;  // Forward from MEM/WB, but only if no EX/MEM forwarding
        end
        else begin
            Forward_A = 2'b00;  // No forwarding
        end
    
        // Forward_B logic
        if (regWrite_Mem == 1 && rdMem != 0 && rdMem == RS_2) begin
            Forward_B = 2'b10;  // Forward from EX/MEM
        end
        else if (regWrite_Wb == 1 && rdWb != 0 && rdWb == RS_2 && !(regWrite_Mem == 1 && rdMem != 0 && rdMem == RS_2)) begin
            Forward_B = 2'b01;  // Forward from MEM/WB, but only if no EX/MEM forwarding
        end
        else begin
            Forward_B = 2'b00;  // No forwarding
        end
    end
endmodule