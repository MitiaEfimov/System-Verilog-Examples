module badFFstyle
    (input logic d, clk, rst_l,
    output logic q2);
    logic q1;

    always @(posedge clk)
        if (~rst_l) q1 <= 1'b0;
        else begin
            q1 <= d;
            q2 <= q1;
        end
endmodule