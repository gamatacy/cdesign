`timescale 1ns / 1ps

module bcd2bin_tb;

    // Parameters
    localparam CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg [7:0] bcd_in;        // BCD input
    wire [6:0] bin_out;      // Binary output

    // Instantiate the module under test
    bcd2bin dut (
        .bcd_in(bcd_in),
        .bin_out(bin_out)
    );

    // Clock generation
    reg clk = 0;
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize inputs
        bcd_in = 8'b00000000;

        // Apply stimulus
        #10 bcd_in = 8'b00000001; // BCD 1 -> Binary 0000001
        #10 bcd_in = 8'b00000010; // BCD 2 -> Binary 0000010
        #10 bcd_in = 8'b00000011; // BCD 3 -> Binary 0000011
        #10 bcd_in = 8'b00000100; // BCD 4 -> Binary 0000100
        #10 bcd_in = 8'b00000101; // BCD 5 -> Binary 0000101
        #10 bcd_in = 8'b00000110; // BCD 6 -> Binary 0000110
        #10 bcd_in = 8'b00000111; // BCD 7 -> Binary 0000111
        #10 bcd_in = 8'b00001000; // BCD 8 -> Binary 0001000
        #10 bcd_in = 8'b00001001; // BCD 9 -> Binary 0001001
        #10 bcd_in = 8'b00001010; // BCD 10 -> Binary 0001010

        // Add more test cases as needed

        // Finish simulation
        #10 $finish;
    end

endmodule
