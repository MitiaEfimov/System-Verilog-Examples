module four_bit_adder
    (input logic [3:0] a, b,
    input logic [3:0] sum,
    input logic cIn,
    output logic cOut);

    logic [2:0] c;

    adder b0 (a[0], b[0], cIn, sum[0], c[0]);
    adder b1 (a[1], b[1], c[0], sum[1], c[1]);
    adder b2 (a[2], b[2], c[1], sum[2], c[2]);
    adder b3 (a[3], b[3], c[2], sum[3], cOut);
endmodule

module adder
    (input logic a, b, cI,
    output logic s, c0);

    assign s = a ^ b^ cI,
    c0 = (a&b) | (a&cI) | (b&cI);
endmodule

module test_four_bit_adder;
    logic [3:0] s;
    logic cOut;
    logic [9:0] count;

    four_bit_adder
        add0 (count[7:4], count[3:0], s, count[8], cOut);

    initial begin
        for (count = 1; count <= 10'h200; count++)
            #1 if ({cOut, s} != (count[7:4] + count[3:0] + count[8]))
                $display ("oops! %d != %d +%d +%d",
                {cOut, s}, count[7:4], count[3:0], count[8]);

        $finish;
    end
endmodule