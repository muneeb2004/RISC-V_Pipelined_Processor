module tb_RegisterFile;

    reg [63:0] WriteData;  
    reg [4:0] RS1;  
    reg [4:0] RS2;  
    reg [4:0] RD;  
    reg RegWrite, clk, reset;  
    wire [63:0] ReadData1;  
    wire [63:0] ReadData2;

    registerFile regFile (
        .WriteData(WriteData),
        .RS1(RS1),
        .RS2(RS2),
        .RD(RD),
        .RegWrite(RegWrite),
        .clk(clk),
        .reset(reset),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );    

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        // Initialization
        clk = 0;   
        RegWrite = 0;   
        reset = 1;
        RS1 = 0;
        RS2 = 0;
        RD = 0;
        WriteData = 0;

        $display("Starting Register File Testbench");
        $monitor("Time = %0t | RS1 = %0d, RS2 = %0d | RD = %0d | WriteData = %0d | RegWrite = %b | ReadData1 = %0d | ReadData2 = %0d", 
                  $time, RS1, RS2, RD, WriteData, RegWrite, ReadData1, ReadData2);

        #10 reset = 0;

        // Test Case 1
        RD = 5; WriteData = 64'd100; RegWrite = 1;
        RS1 = 5; RS2 = 0;
        #10;

        // Test Case 2
        RD = 10; WriteData = 64'd200; RegWrite = 1;
        RS1 = 10; RS2 = 5;
        #10;

        // Test Case 3: Disable write and check persistence
        RegWrite = 0;
        RD = 15; WriteData = 64'd300; // Should not write
        RS1 = 10; RS2 = 5;
        #10;

        // Test Case 4: Check another register
        RD = 20; WriteData = 64'd400; RegWrite = 1;
        RS1 = 20; RS2 = 10;
        #10;

        // Test Case 5: Reset register file
        reset = 1;
        #10 reset = 0;
        RS1 = 5; RS2 = 10;
        #10;

        $display("Testbench finished.");
        $stop;
    end

endmodule