// Тестовое окружение для модуля FSMprob (задача 3.2). 
// Автомат задан неявно

`timescale 1ms/1ms
module FSMprob_test;
    logic clk, rst_l, ok_flag; bit i, j; // общие порты, определенные в модуле FSMprob и FSMprob_hardway
    logic x, y; // Выходные порты FSMprob 
    logic Xh, Yh; // Выходные порты FSMprob_hardway 

    FSMprob dut (.clk, .rst_l, .i, .j, .x, .y, .ok_flag);
    FSMprob_hardway dut_h (.clk, .rst_l, .i, .j, .x(Xh), .y(Yh));
    reg st_prob = dut.state; 
    
    FSMprob_tb tb (.clk, .i, .j);


    initial begin: TEST
        $monitor("T(%0t): Current State - prob = %b hard = %b%b\ni j = %b %b | x y = %b %b | Xh Yh = %b %b", 
        $time, dut.state, dut_h.q0, dut_h.q1, i, j, x, y, Xh, Yh);

        if (~ok_flag)
            $display("Ok flag is gone: %d", ok_flag);
        clk = 0; rst_l = 0;
        rst_l <= #1 1;
        forever # 5 clk = ~clk;
    end

endmodule
    
program FSMprob_tb
    (input clk, output logic i, j);

    initial begin: TB
        {i, j} <= 2'b00; // "A" вариант 1
        @(posedge clk); // на 5 мс: состояние "A", xy = 10
        {i, j} <= 2'b01; // "A" вариант 2
        @(posedge clk); // на 15 мс: состояние "A", xy = 10
        {i, j} <= 2'b10; // "A" вариант 3
        @(posedge clk); // на 25 мс: состояние "B", xy = 11
        {i, j} <= 2'b01; // "B" вариант 1
        @(posedge clk); // на 35 мс: состояние "C", xy = 01
        {i, j} <= 2'b10; // "C" вариант 1
        @(posedge clk); // на 45 мс: состояние "B", xy = 00
        {i, j} <= 2'b11; // "B" вариант 2
        @(posedge clk); // на 55 мс: состояние "C", xy = 01
        {i, j} <= 2'b11; // "C" вариант 2
        @(posedge clk); // на 65 мс: состояние "B", xy = 00
        {i, j} <= 2'b00; // "B" вариант 3
        @(posedge clk); // на 75 мс: состояние "D", xy = 10
        {i, j} <= 2'b10; // "D" 1 вариант 
        @(posedge clk); // на 85 мс: состояние "D", xy = 00
        {i, j} <= 2'b11; // "D" 2 вариант 
        @(posedge clk); // на 95 мс: состояние "D", xy = 00
        {i, j} <= 2'b01; // "D" 3 вариант
        @(posedge clk); // на 105 мс: состояние "C", xy = 10
        {i, j} <= 2'b01; // "C" 3 вариант 
        @(posedge clk); // на 115 мс: состояние "C", xy = 10
        {i, j} <= 2'b00; // "C" 4 вариант 
        @(posedge clk); // на 125 мс: состояние "D", xy = 11
        {i, j} <= 2'b00; // "D" 4 вариант 
        @(posedge clk); // на 135 мс: состояние "A", xy = 00
        {i, j} <= 2'b11; // "A" 4 вариант 
        @(posedge clk); // на 145 мс: состояние "B", xy = 11
        {i, j} <= 2'b10; // "B" 4 вариант 
        @(posedge clk); // на 155 мс: состояние "D", xy = 10
        #1 $finish;
    end
endprogram