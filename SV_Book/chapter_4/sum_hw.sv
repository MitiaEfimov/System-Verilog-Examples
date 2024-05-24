// Задача спроектировать аппаратный потоко, вычисляющий сумму чисел,
// Подаваемых на вход нескольких последовательных тактах. Поток должен
// знать, когда на входе находятся валидные данные. После завершения 
// суммирования поток должен сообщить о том, что результат вычислен и 
// другой поток может получить его.

module sum_hw
    (input logic clk, // Тактовый сигнал
    input logic rst_l, // асинхронный сброс
    input logic go_l, // флаг разрешения вычисления
    input  logic [15:0] inA, // вектор чисел, подлежащих суммированию
    output logic done, // флаг окончания суммирования
    output logic [15:0] sum); // выходной вектор выдачи вычисленной суммы


    logic ld_l; // флаг сохранения в регистре вычисленной суммы 
    logic cl_l; // сигнал для синхронного сброса вычисленной суммы
    logic inAeq;
    logic [15:0] addOut;

    // состояние А и Б конечного автомата
    enum bit {sA, sB}; // sA - ожидание установки go_l, sB - ожидание 0 на входе inA

    always_ff @(posedge clk, negedge rst_l)
        begin: st_machine
            if (~rst_l)
                state <= sA;
            else begin
                if (((state == sA) & go_l) | ((state == sB) & inAeq))
                    state <= sA;
                if (((state == sA) & ~go_l) | ((state == sB) & ~inAeq))
                    state <= sB;
            end
        end: st_machine

    always_ff @(posedge clk, negedge rst_l)
        begin: reg_sum
            if (~rst_l) sum <= 0;
            else if (~ld_l) sum <= addOut;
            else if (~cl_l) sum <= 0;
        end: reg_sum

    assign 
            // вычисление суммы чисел из регистра и на входе
            addOut = inA + sum, 
            // вычисление состояния флага хранения регистра
            ld_l = ~(((state == sA) & ~go_l) | ((state == sB) & ~inAeq)),
            // вычисление состояния флага синхронного сброса
            cl_l = ~(((state == sB) & inAeq)),
            // вычисление состояния флага завершения расчёта суммы
            done = ((state == sB) & inAeq),
            // проверка окончания 
            inAeq = inA == 0;
endmodule

