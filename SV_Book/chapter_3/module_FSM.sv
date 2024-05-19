module FSM_module
    (input logic x, ck, reset_l,
    output logic z);
    logic q1, q0;

    always_ff @(posedge ck, negedge reset_l) begin
        if (~reset_l)
            {q1, q0} <= 2'b00;
        else begin
            q0 <= q1 | x;
            q1 <= q0 & x;
        end
    end

    assign z = ~(x & q1);

endmodule