module goodFFstyle
    (input logic d, clk, rst_l,
    output logic q2);
    logic q1;

    always_ff @(posedge clk)
        if (~rst_l) q1 <= 1'b0;
        else q1 <= d;

    always_ff @(posedge clk)
        q2 <= q1;
endmodule