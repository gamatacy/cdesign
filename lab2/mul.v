module mul(
	input clk_i,
	input rst_i,
	input [7:0]a_bi,
	input [7:0]b_bi,
	input start_i,
	output busy_o,
	output reg [15:0] y_bo	
);
	localparam IDLE = 1'b0;
	localparam WORK = 1'b1;
	reg state;
	assign busy_o = state;
	reg[3:0] counter;
	wire[7:0] part_sum;
	wire [15:0] shifted_part_sum;
	reg[7:0] a,b;
	wire[2:0] end_step;
	reg[15:0] part_res;
	assign part_sum = a & {8{b[counter]}};
	assign shifted_part_sum = part_sum << counter;
	assign end_step = (counter == 4'h8);
	always @(posedge clk_i) begin
		if (rst_i) begin
			counter <= 0;
			part_res <= 0;
			y_bo <= 0;
			state <= IDLE;
		end else begin
		case (state)
			IDLE:
			if (start_i) begin
				state <= WORK;
				a <= a_bi;
				b <= b_bi;
				counter <= 0;
				part_res <= 0;
			end
			WORK:
				begin
				if (end_step) begin
					state <= IDLE;
					y_bo <= part_res;
				end				
			part_res <= part_res +
			shifted_part_sum;
			counter <= counter + 1;
			end
		endcase
	end
end
endmodule