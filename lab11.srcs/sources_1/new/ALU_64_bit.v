`timescale 1ns / 1ps

module ALU_64_bit(
    input [63:0] a,        
    input [63:0] b,         
    input C_In,       
    input [3:0] ALUOp, 
    output C_Out, zero, 
    output reg [63:0] Result 
    );
    
    wire [63:0] a_not, b_not, and_, or_, xor_, add, sub;
     
    assign and_ = a & b;
    assign or_ = a | b;
    assign xor_ = a ^ b;
    assign a_not = ~a;
    assign b_not = ~b;
    assign add = a + b + C_In;
    assign sub = a - b + C_In;
    assign zero = (Result == 64'b0);
    
    assign C_Out = (a[63] & b[63]) | ((a[63] | b[63]) & add[63]);
    
    always @(*) begin
        case (ALUOp)
            4'b0000: Result = and_;     
            4'b0001: Result = or_;      
            4'b0010: Result = add;       
            4'b0011: Result = sub;       
            4'b0100: Result = xor_;     
            default: Result = 64'b0;     
        endcase
    end
endmodule
