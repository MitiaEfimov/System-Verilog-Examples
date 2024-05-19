module compare (
    output logic eq, neq,
    input logic [3:0] value
);
    
    assign neq = ~eq,
    eq = (value == 0);
endmodule: compare