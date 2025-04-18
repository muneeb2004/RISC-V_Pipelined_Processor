module Branch(
    input Branch,        // From control unit
    input ZERO,          // ALU zero flag
    input Isgreater,     // Optional: from ALU
    input [2:0] funct3,  // from instruction
    output reg switch_branch
);

    always @(*) begin
        if (Branch) begin
            case(funct3)
                3'b000: switch_branch = ZERO ? 1 : 0; // beq
                3'b001: switch_branch = ZERO ? 0 : 1; // bne
                3'b101: switch_branch = Isgreater ? 1 : 0; // bge
                default: switch_branch = 0;
            endcase
        end else begin
            switch_branch = 0;
        end
    end
endmodule