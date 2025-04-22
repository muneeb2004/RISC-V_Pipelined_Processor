`timescale 1ns / 1ps

module IF_ID(
    input clk,
    input reset,
    input stall,
    input flush,  // Added flush input
    input [31:0] pc_in,
    input [31:0] instruction,
    output reg [31:0] pc_out,
    output reg [31:0] ins_out
);

    initial begin
        pc_out <= 0;
        ins_out <= 0;
    end   
    
    always @(posedge clk) begin
        if (reset || flush) begin //flush is prioritized
            pc_out <= 0;
            ins_out <= 0;
        end else if (~stall) begin
            pc_out <= pc_in;
            ins_out <= instruction;
        end
    end
endmodule