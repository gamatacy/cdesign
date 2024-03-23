`timescale 1ns/1ns

module bcd2bin_tb;

   reg [3:0] bcd1;
   reg [3:0] bcd0;
   wire [6:0] bin; 
   reg [6:0] expectedOut;
   integer i;

   bcd2bin dut (
      .bcd1(bcd1),
      .bcd0(bcd0),
      .bin(bin)
   );

   reg [14:0] testVector[3:0];

   initial begin
      $readmemb("tb_vector", testVector); 
      for(i = 0; i < 4; i = i+1) begin
          {bcd1, bcd0, expectedOut} = testVector[i]; #10
           $display("BCD1: %b, BCD0: %b, BIN: %b, EXPECTED: %b", bcd1, bcd0, bin, expectedOut);
      end
      $stop;
   end

endmodule