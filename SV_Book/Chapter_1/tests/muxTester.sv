module muxTester;
    logic [2:0] count;
    logic muxOut;

    mux_one_bit dut (muxOut, count[2], count[1], count[0]);

    initial begin
        //Создание файла для отображения Waveform 
        $dumpfile("dump.vcd");
		$dumpvars(0, muxTester);
        // Процедура вывода состояний портов при их изменении 
        $monitor ($time, 
        " a b sel = %b, muxOut = %b", count, muxOut);

        // Цикл перебирает каждое из состояний 3 битного входа
        count = 3'b001;
        #10;
        if ((count[0] ? count[1] : count[2]) != muxOut)
            $display("WARNING!", $time, " a, b, sel = %b, muxOut = %b");
        count = 3'b010;
        #10;
        if ((count[0] ? count[1] : count[2]) != muxOut)
            $display("WARNING!", $time, " a, b, sel = %b, muxOut = %b");
        count = 3'b011;
        #10;
        if ((count[0] ? count[1] : count[2]) != muxOut)
            $display("WARNING!", $time, " a, b, sel = %b, muxOut = %b");
        count = 3'b100;
        #10;
        if ((count[0] ? count[1] : count[2]) != muxOut)
            $display("WARNING!", $time, " a, b, sel = %b, muxOut = %b");
        count = 3'b101;
        #10;
        if ((count[0] ? count[1] : count[2]) != muxOut)
            $display("WARNING!", $time, " a, b, sel = %b, muxOut = %b");
        count = 3'b110;
        #10;
        if ((count[0] ? count[1] : count[2]) != muxOut)
            $display("WARNING!", $time, " a, b, sel = %b, muxOut = %b");
        count = 3'b111;
        #10;
        if ((count[0] ? count[1] : count[2]) != muxOut)
            $display("WARNING!", $time, " a, b, sel = %b, muxOut = %b");

        #10 $finish;
    end
endmodule