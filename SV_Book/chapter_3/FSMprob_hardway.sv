// Задача 3.2
// Написать модуль конечного автомата определенного диаграммой состояний 
// на рисунке 1. ( images\Picture_1.png) Порядок входов: i и j;
// Порядок выходов: x и y. 
// P.S. Задача такая же что и в FSMprob, только автомат расчитан по картам карно
module FSMprob_hardway
    (input logic clk, rst_l, 
    input bit i, j,
    output logic x, y);

    // Определение состояний
    // q0 | q1 | состояние
    //  0 |  0 |    A
    //  0 |  1 |    B
    //  1 |  0 |    C
    //  1 |  1 |    D
    logic q0, q1; 

    // enum logic [1:0] {A=2'b00, B=2'b01, C=2'b10, D=2'b11} state, next_state;
    // {x, y} = {x, y};

    // Расчёт состояния автомата
    always_ff @(posedge clk, negedge rst_l) begin
        if (~rst_l)
            {q0, q1} <= 2'b00;
        else
            q0 <= ( (q0 | q1) & (i | j) & ( (~q0) | q1 | (~i) ) );
            q1 <= ( i & (i | (~j) ) & ( (~i) | (~j) | q0 | (~q1) ) );
    end

    // Выход 
    assign
        x = ( ((~q0) & (~q1)) | ((~q0) & (~i) & (~j)) | ((~q0) & i & (~j)) | (q0 & (~i) & j)),
        y = ( (i & (~q0) & (~q1)) | ((~q0) & i & j) | ((~q0) & q1 & (~i) & j) );
     
endmodule