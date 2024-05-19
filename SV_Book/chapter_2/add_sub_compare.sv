module add_sub_compare (
    output logic [3:0] result,
    input logic [3:0] a, b,
    output logic neq, eq,
    input logic plus_minus);

    sum_and_dif_A   alu (result, a, b, plus_minus);
    compare         c   (eq, neq, result);
    
endmodule