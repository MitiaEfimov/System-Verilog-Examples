module sum_and_dif_A
(output logic [3:0] result,
    input logic [3:0] a, b,
    input select_plus);

    always_comb
        if (select_plus)
            result = a + b;
        else result = a - b;
endmodule: sum_and_dif_A

module sum_and_dif_B
(output logic [3:0] result,
    input logic [3:0] a, b,
    input select_plus);

    assign result = (select_plus) ? a + b : a - b;
endmodule: sum_and_dif_B