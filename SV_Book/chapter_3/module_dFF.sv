module module_dFF
    (output logic q,
    input logic d, ck, reset_l);

    always_ff @(posedge ck, negedge reset_l)
    if (~reset_l)
        q <= 0;
    else q <= d;
endmodule