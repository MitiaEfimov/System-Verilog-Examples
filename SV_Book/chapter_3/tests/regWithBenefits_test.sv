`timescale 1ms/1ms
module regWithBenefits_test
    #(parameter W = 7);
    logic [W-1:0] d, q;
    bit rst_l, clk, clr, ld, shl, shIn;

    regWithBenefits #(.W(W)) dut  (.*);

    initial begin
        // Отслеживаем все интерфейсы
        $monitor(
        "time:%0t\nd = %b\nclr = %b; ld = %b; shl = %b; shIn = %b\n",$time, d, clr, ld, shl, shIn, 
        "clk = %b | rst_l = %b  : q = %b\n", clk, rst_l, q);

        // Начальная установка (сброс)
        $display("\n\n");
        $display("\nStart\n");
        clk = 0; rst_l = 0;
        clr = 0; 
        ld = 0; d = 0; 
        shl = 0; shIn = 0;
        rst_l <= #1 1; # 1 clk = 1;


        // Сдвиг регистра
        $display("\nShift data all the way left\n");
        clk = 0; shIn = 1; shl = 1; 
        # 1 clk = ~clk;  // posedge
        # 1 clk = ~clk;  // negedge     
        shIn = 0;
        # 1 clk = ~clk;  // posedge
        # 1 clk = ~clk;  // negedge     
        shIn = 1;
        # 1 clk = ~clk;  // posedge
        # 1 clk = ~clk;  // negedge     
        shIn = 0;
        // shift 101... data
        # 1 clk = ~clk; #1 clk = ~clk; shIn = 0;
        for (int i = 0; i <= W; i++)
            #1 clk = ~clk;

        // Установка регистра при наличии команды сдвига
        $display("\nLoad data bit while shift enable\n");
        clk = 0; d = {W{2'b10}}; ld = 1;
        # 1 clk = ~clk; #1 clk = ~clk; 
    
        // Синхронный сброс
        $display("\nSync clear data\n");
        clk = 0; clr = 1; 
        # 1 clk = ~clk; # 1 clk = ~clk;

        // Проверка, что значение не будет изменяться при отсутствии управления
        $display("\nStore data for several ticks\n");
        clk = 0; clr = 0; d = {W{2'b01}};
        # 1 clk = ~clk; 
        #1; d = 0; ld = 0;  shl =0; 
        # 1 clk = ~clk; # 1 clk = ~clk; 
        # 1 clk = ~clk; # 1 clk = ~clk; 

        // Асинхронный сброс
        $display("\nasync reset\n");
        # 1 rst_l = 0;
        # 1 rst_l = 1; 

    end

endmodule
