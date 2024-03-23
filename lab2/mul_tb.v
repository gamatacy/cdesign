`timescale 1ns / 1ps
module mul_tb;
	reg clk = 0;
	reg rst = 0;
	reg [7:0]a = 0;
	reg [7:0]b = 0;
	reg start = 0;
	wire busy;
	wire [15:0] y;

mul dut(
	.clk_i(clk),
	.rst_i(rst),
	.a_bi(a),
	.b_bi(b),
	.start_i(start),
	.busy_o(busy),
	.y_bo(y)
);

	initial begin
		rst = 1;
		#10;
		rst = 0;
		a = 8'hff;
		b = 8'h06;
		start = 1;
		#10;
		start = 0;
	end
	always begin
		#5 clk = ~clk;
	end
endmodule