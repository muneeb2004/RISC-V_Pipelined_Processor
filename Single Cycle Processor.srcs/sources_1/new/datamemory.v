`timescale 1ns / 1ps
module dataMemory(
    input [31:0] mem_addr,
    input[31:0] write_data,
    input clk,
    input mem_write,
    input mem_read,
    output [31:0] read_data
);
reg [7:0] memory [511:0];
integer i;
initial begin 
for (i =0; i < 512; i=i+1) begin
// lab
//        memory[i] = 64'b0 + i;
// project
    memory[i] = 32'b0;
    end
end


assign read_data[7:0] = mem_read? memory[mem_addr]: 8'b0;
assign read_data[15:8] = mem_read? memory[mem_addr+1]: 8'b0;
assign read_data[23:16] = mem_read? memory[mem_addr+2]: 8'b0;
assign read_data[31:24] = mem_read? memory[mem_addr+3]: 8'b0;


always @(posedge clk) begin
    if (mem_write) begin
        memory[mem_addr] = write_data[7:0];
        memory[mem_addr+1] = write_data[15:8];
        memory[mem_addr+2] = write_data[23:16];
        memory[mem_addr+3] = write_data[31:24];
      
    end
end
endmodule
