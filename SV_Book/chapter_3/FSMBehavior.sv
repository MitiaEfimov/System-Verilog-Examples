module FSMBehavior
    (input logic x, ck, r_l,
    output  logic z);

    enum logic [2:0] {A=3'b001, B=3'b010, C=3'b100} state;

    always_ff @(posedge ck, negedge r_l) begin
        if (~r_l)
            state <= A;
        else case (state)
            A: state <= (x) ? B : A;
            B: state <= (x) ? C : A;
            C: state <= (x) ? C : B;
            default: state <= A;
        endcase
    end
    always_comb begin
        z = 1'b1;
        if (state == C) z = ~x;
    end
endmodule