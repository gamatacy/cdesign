`timescale 1ns / 1ps

module func_tb;
    reg clk = 0;
    reg rst = 0;
    reg start = 0;
    reg [7:0] a;
    reg [7:0] b;
    wire busy;
    wire [10:0] func_res;
    
    func dut(
        .clk_i(clk),
        .a_bi(a),
        .b_bi(b),
        .rst_i(rst),
        .start_i(start),
        .busy_o(busy),
        .y_bo(func_res)
    );

    task test_func;
        input [3:0] test_num;
        input [7:0] test_a;
        input [7:0] test_b;
        input [10:0] test_res;
        
        begin
            rst = 1;
            #10;
            rst = 0;
            a = test_a;
            b = test_b;
            start = 1;
            #10
            start = 0;
            while (busy) begin
              #5;
            end
        if (func_res == test_res) $display("Test %d: Correct", test_num);
            else $display("Test %d: Failed %d, should be %d", test_num, func_res,test_res);
        end
    endtask
    
    initial begin
        test_func(0, 0, 0, 0);
        test_func(1, 1, 1, 5);
        test_func(2, 2, 2, 8);
        test_func(3, 3, 3, 11);
        test_func(4, 4, 4, 14);
        test_func(5, 5, 5, 17);
        test_func(6, 6, 6, 20);
        test_func(7, 7, 7, 23);
        test_func(8, 32, 128, 106);
        test_func(9, 48, 192, 154);
    end
    
    always begin
        #5;
        clk = ~clk;
    end
endmodule