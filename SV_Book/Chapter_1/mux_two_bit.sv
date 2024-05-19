module mux_two_bit
    (output logic [1:0] f,
     input  logic [1:0] a, b,
     input  logic       sel);

    mux_one_bit b0 (f[0], a[0], b[0], sel);
    mux_one_bit b1 (f[1], a[1], b[1], sel);
endmodule

//module mux_one_bit
//    (output logic f,
//     input  logic a, b, sel);
//
//    and #2  g1 (f1, a, n_sel);
//            g2 (f2, b, sel);
//    or  #2  g3 (f, f1, f2);
//    not     g4 (n_sel, sel);
//endmodule