`timescale 1ns / 1ps

module cbrt_tb;
	reg clk = 0;
	reg rst = 0;
	reg [7:0]x = 0;
	reg start = 0;
	wire busy;
	wire [2:0] y;

	cbrt dut(
		.clk_i(clk),
		.rst_i(rst),
		.start_i(start),
		.x_bi(x),
		.y_bo(y),
		.busy_o(busy)
	);

	initial begin
		rst = 1;
		#10;
		rst = 0;
		x = 216;
		start = 1;
		#10;
		start = 0;
	end
	always begin
		#5;
		clk = ~clk;
	end
endmodule