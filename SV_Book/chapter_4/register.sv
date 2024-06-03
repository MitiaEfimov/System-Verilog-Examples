module register
    #(parameter W = 1)
    (input logic clk, reset_l, cl_l, ld, incr,
    input logic [W-1:0] dataIn,
    output logic [w-1:0] dataOut);

    always_ff @(posedge clk, negedge reset_l)
        begin
            if (~reset_l) dataOut <= 0; // Асинхронный сброс
            else if (ld) dataOut <= dataIn; // Загрузка
            else if (incr) dataOut <= dataOut + 1; // Инкримент
            else if (cl_l) dataOut <= 0; // Синхронный сброс
        end
endmodule