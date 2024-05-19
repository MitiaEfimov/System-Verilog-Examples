module testDff;
    logic   q, d, ck, reset_l;

    dFF_module q0(.*);

    initial begin

        $dumpfile("dump.vcd");
		$dumpvars(0, testDff);

        $monitor($time,
            " d=%b, q=%b, ck=%b, reset_l=%b", d, q, ck, reset_l);

        ck = 0;
        reset_l = 0;
        d = 0;
        #1 reset_l = 1; d = 1;
        #1 ck = 1;
        #1 reset_l = 0;
        #1 ck = 0;
        #1 ck = 1;
        #1 reset_l = 1;
        #1 ck = 0;
        #1 ck = 1;
        #1 d = 0;
        #1 ck = 0;
        #1 ck = 1;
    end
endmodule