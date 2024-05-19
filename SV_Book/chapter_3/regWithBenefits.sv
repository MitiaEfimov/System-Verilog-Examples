// напишите и промоделируйте 8-битный регистр
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

    logic [W-1:0] stage, next_stage;

    // состояние регистра
    always_ff @(posedge clk, negedge rst_l) begin
        if (~rst_l)              // асинхронный сброс
            stage <= '0;
        else                     // тактовый сигнал
            stage <= next_stage; 
    end

    // следующее состояние регистра
    always_comb begin
        if (clr)                   // синхронный сброс
            next_stage = '0;
        else if (ld)               // запись регистра при наличии разрешения
            next_stage = d;      
        else if (shl)              // сдвиг содержимого регистра влево
            next_stage = { shIn, stage[W-1:1]};
        else                     // хранение информации
            next_stage = stage;
    end

    // выход регистра
    assign q = stage;
endmodule