`timescale 1ns / 1ps

module tb_RegisterFile ( 
 
); 
 
 	reg [63:0] WriteData;  
 	reg [4:0]RS1;  
  	reg [4:0]RS2;  
  	reg [4:0]RD;  
  	reg RegWrite, clk, reset;  
  	wire  [63:0]ReadData1;  
  	wire  [63:0]ReadData2;    
  
  registerFile regFile  
  (    
    WriteData,RS1,   RS2,   
    RD,   
    RegWrite,   
    clk,   
    reset,   
    ReadData1,   
    ReadData2  
  );    
  initial  
    begin 
      
      clk = 0;   
      RegWrite = 0;   
      reset = 0;   
      
      RS1 = 10;    
      RS2 = 20;  
      WriteData = 64'd35;    
      RD = 20;  
  #10 reset = 0;    
            
  #10 RegWrite = 1;
  #10
      clk = 1;   
      RegWrite = 0;   
      reset = 1;   
      
      RS1 = 5;   
      RS2 = 4;   
      WriteData = 64'd25;    
      RD = 15;  
  #10 reset = 0;    
            
  #10 RegWrite = 1;
  
  #10
      clk = 0;   
      RegWrite = 1;   
      reset = 0;   
      
      RS1 = 8;   
      RS2 = 9; 
      WriteData = 64'd20;    
      RD = 10;  
  #10 reset = 0;    
            
  #10 RegWrite = 1;
  
  #10
      clk = 1;   
      RegWrite = 1;   
      reset = 1;   
      
      RS1 = 12;  
      RS2 = 13; 
      WriteData = 64'd15;    
      RD = 5;  
  #10 reset = 0;    
            
  #10 RegWrite = 1;
 
    
    end 
  
  always
    #5 clk=~clk;

endmodule