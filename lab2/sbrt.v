module cbrt(
	input clk_i,
	input rst_i,
	input start_i,
	input [7:0]x_bi,
	output busy_o,
	output reg [2:0] y_bo
);
	localparam IDLE = 2'd0;
	localparam SQUARING = 2'd1;
	localparam CUBING = 2'd2;
	reg [1:0] state;
	reg [7:0] a;
	reg [7:0] b;
	reg start_mul = 0;
	wire mul_busy;
	wire [15:0] mul_res;

	mul inner_mul(
		.rst_i(rst_i),
		.clk_i(clk_i),
		.a_bi(a),
		.b_bi(b),
		.start_i(start_mul),
		.busy_o(mul_busy),
		.y_bo(mul_res)
	);

	assign busy_o = (state != IDLE);

	always @(posedge clk_i) begin

	if (rst_i) begin
		a <= 0;
		b <= 0;
		state <= IDLE;
	end else begin
	case (state)
		IDLE:
		if (start_i) begin
			a <= 7;
			b <= 7;
			state <= SQUARING;
			start_mul <= 1;
		end
		SQUARING:
		if (start_mul) begin
			start_mul <= 0;
		end else if (!mul_busy) begin
			a <= mul_res;
			state <= CUBING;
			start_mul <= 1;
		end
		CUBING:
		if (start_mul) begin
			start_mul <= 0;
		end else if (!mul_busy) begin
		if (mul_res > x_bi) begin
			a <= b - 1;
			b <= b - 1;
			state <= SQUARING;
			start_mul <= 1;
		end else begin
		y_bo <= b;
		state <= IDLE;
		end
	end
	endcase

	end
end
endmodule