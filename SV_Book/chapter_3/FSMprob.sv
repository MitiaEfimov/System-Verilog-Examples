// Задача 3.2
// Написать модуль конечного автомата определенного диаграммой состояний 
// на рисунке 1. ( images\Picture_1.png) Порядок входов: i и j;
// Порядок выходов: x и y. 
// Для определения имён состояний воспользоваться перечислимым типом.
// Определить автомат явным образом.
module FSMprob
    (input logic clk, rst_l, 
    input bit i, j,
    output logic x, y, ok_flag);

    // Определение имён состояний
    enum logic [1:0] {A=2'b00, B=2'b01, C=2'b10, D=2'b11} state, next_state;
    // {x, y} = {x, y};

    // Текущее состояние FSM
    always_ff @(posedge clk, negedge rst_l) begin
        if (~rst_l)
            state <= A;
        else
            state <= next_state;
    end
    // Следующее состояние FSM
    always_comb
        case (state)
        A: next_state = (i) ? B : A;
        B: next_state = (j) ? C : D;
        C: if (i) next_state = B;
           else next_state = (j) ? C : D;
        D: if (i) next_state = D;
           else next_state = (j) ? C : A;
        default: next_state = A;
        endcase

    // Выход 
    always_comb
        case (state)
            A: {x, y} = (i) ? 2'b11 : 2'b10;
            B: {x, y} = (j) ? 2'b01 : 2'b10;
            C: if (i) {x, y} = 2'b00;
               else {x, y} = (j) ? 2'b10 : 2'b00;
            D: if (i) {x, y} = 2'b00;
               else {x, y} = (j) ? 2'b10 : 2'b00;
            default: begin 
                {x, y} = 2'b10;
                ok_flag = 0;
            end
        endcase
     
endmodule