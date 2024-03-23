`timescale 1ns / 1ps
module func(
	input rst_i,
	input clk_i,
	input [7:0] a_bi,
	input [7:0] b_bi,
	input start_i,
	output reg [10:0] y_bo,
	output busy_o
);
    
    localparam IDLE = 2'd0;
    localparam CBRT = 2'd1;
    localparam MUL = 2'd2;
    localparam SUM = 2'd3;
    localparam THREE = 8'h03;
    
    reg [1:0] state;
    reg start_cbrt = 0;
    wire [2:0] cbrt_res;
    wire [7:0] extended_cbrt_res;
    wire [7:0] shifted_cbrt_res;
    
    assign extended_cbrt_res = {5'b00000, cbrt_res[2:0]};
    assign shifted_cbrt_res = extended_cbrt_res << 1;
    


wire cbrt_busy;
    cbrt cbrt_b(
        .x_bi(b_bi),
        .rst_i(rst_i),
        .clk_i(clk_i),
        .start_i(start_cbrt),
        .y_bo(cbrt_res),
        .busy_o(cbrt_busy)
    );
    
    wire [10:0] mul_res;
    wire mul_busy;
    reg start_mul = 0;
    
    mul mul(
        .a_bi(a_bi),
        .b_bi(THREE),
        .busy_o(mul_busy),
        .y_bo(mul_res),
        .clk_i(clk_i),
        .rst_i(rst_i),
        .start_i(start_mul)
    );
    
    assign busy_o = (state != IDLE);
    
    always @(posedge clk_i) begin
        if (rst_i) begin
            y_bo <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if (start_i) begin
                        start_cbrt <= 1;
                        y_bo <= 0;
                        state <= CBRT;
                    end
                CBRT:
                    if (start_cbrt) begin
                        start_cbrt <= 0;
                    end else if (!cbrt_busy) begin
                        start_mul <= 1;
                        state <= MUL;
                    end
                MUL:
                    if (start_mul) begin
                        start_mul <= 0;
                    end else if (!mul_busy) begin
                        state <= SUM;
                    end
                SUM:
                    begin
                        y_bo <= mul_res + shifted_cbrt_res;
                        state <= IDLE;
                    end
            endcase
        end
    end
endmodule
