`timescale 1ns / 1ps

module programCounter(
    input [31:0] pc_in,
    input clk,
    input reset,
    input stall,  // New stall input
    output reg [31:0] pc_out
);

reg pc_s;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        pc_s <= 0;
        pc_out <= 0;
    end else if (~stall) begin  // Only update if not stalled
        if (pc_in > 7) begin
            pc_out <= 0;
        end else begin
            if (~pc_s) begin
                pc_out <= 0;
                pc_s <= 1;
            end else 
                pc_out <= pc_in;
        end
    end
end
endmodule