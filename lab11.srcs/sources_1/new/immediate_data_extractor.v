module immediate_data_extractor(
    input [31:0] Instruction,
    output reg [63:0] imm_data
);
    wire [1:0] code = Instruction[6:5];
    
    always @(*) begin
        case (code)
            2'b00 : imm_data = {{52{Instruction[31]}}, Instruction[31:20]};
            2'b01 : imm_data = {{52{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};
            2'b11 : imm_data = {{52{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]}; 
        endcase
    end
endmodule
