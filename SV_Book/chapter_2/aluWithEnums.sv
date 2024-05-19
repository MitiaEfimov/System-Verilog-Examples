typedef enum logic [2:0] { 
    AND = 3'b001,
    SUB = 3'b010,
    XOR = 3'b011,
    ADD = 3'b100,
    OR =  3'b110 } aluFun_t;
    
module combTestWithEnums;
    aluFun_t op;
    logic [7:0] a, b, result;

    aluWithEnums dut (.*);


    initial begin
        op = op.first;
        $monitor ("%8b = %8b %s %8b", 
            result, a, op, b);
        // for (aluFun_t op=op.first(); op!=op.last(); op=op.next()) begin
        forever begin
            $display("name is %s and n is %d", op.name(), op);
            a = 8'h35; b = 8'h15;
            if (op == op.last) break;
            #1 op = op.next();
            // #1;
            // #1 if (op == op.last()) break;
        end
    end
endmodule

module aluWithEnums
    (input logic [7:0] a, b,
    output logic [7:0] result,
    input aluFun_t op);

    always_comb begin
        case (op)
            ADD: result = a + b;
            SUB: result = a - b;
            AND: result = a & b;
            OR: result = a | b;
            XOR: result = a ^ b;
            default: result = 0;
        endcase
    end
endmodule