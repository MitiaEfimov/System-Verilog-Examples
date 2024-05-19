module FSMAlternate
    (input logic x, ck, r_l,
    output logic z);

    enum logic [2:0] {A=3'b001, B=3'b010, C=3'b100} state, nextState;
    always_ff @(posedge ck, negedge r_l)
        if (~r_l) state <= A;
        else state <= nextState;

    always_comb
        case (state)
        A: nextState = (x) ? B : A;
        B: nextState = (x) ? C : A;
        C: nextState = (x) ? C : B;
        default: nextState = A;
    endcase

    assign z = (state == C) ? ~x : 1'b1;
endmodule
