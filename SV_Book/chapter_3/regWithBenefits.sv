// Задача 3.1: напишите и промоделируйте 8-битный регистр с заданным заголовком модуля
module regWithBenefits
    #(parameter W = 8)
    (input logic [W-1:0] d,     // информация, которая должа быть записана в регистр
    input logic rst_l,          // сигнал асинхронного сброса 
    input logic clk,            // тактовый сигнал
    input logic clr,            // сигнал синхронного сброса
    input logic ld,             // сигнал разрешения записи в регистр  
    input logic shl,            // сигнал сдвига содержимого решистра влево на одну позицию
    input logic shIn,           // младший бит при сдвиге содержимого в регистр 
    output logic [W-1:0] q);    // выход регистра

    // Если устанолен более, чем один управляющий сигнал, 
    // предполагается следующий приоритет: clr, ld, shl

    logic [W-1:0] state, next_state;

    // состояние регистра
    always_ff @(posedge clk, negedge rst_l) begin
        if (~rst_l)              // асинхронный сброс
            state <= '0;
        else                     // тактовый сигнал
            state <= next_state; 
    end

    // следующее состояние регистра
    always_comb begin
        if (clr)                   // синхронный сброс
            next_state = '0;
        else if (ld)               // запись регистра при наличии разрешения
            next_state = d;      
        else if (shl)              // сдвиг содержимого регистра влево
            next_state = { shIn, state[W-1:1]};
        else                     // хранение информации
            next_state = state;
    end

    // выход регистра
    assign q = state;
endmodule