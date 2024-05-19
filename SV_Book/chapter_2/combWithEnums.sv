typedef enum bit [2:0] {
    AND = 3'b001,
    SUB = 3'b010,
    XOR = 3'b011,
    ADD = 3'b100,
    OR =  3'b110
    } aluFun_t;

module combTestWithEnums;
    aluFun_t op;
    bit [7:0] a, b, result;

    aluWithEnums dut (.op, .a, .b, .result);

    initial begin
        op = op.first();
        $monitor ("%b = %b %s %b", 
                result, a, op, b);
        forever begin
            $display ("\nactual name is %s and it is %b position", op.name(), op);
            a = 8'h35; b = 8'h15;
            #1 if (op == op.last) break;
            op = op.next();
        end
    end
endmodule

module aluWithEnums
    (input bit [7:0] a, b, 
    output bit [7:0] result,
    input aluFun_t op);

    always_comb
        unique case (op)
            ADD : result = a + b;
            SUB : result = a - b;
            AND : result = a & b;
            OR  : result = a | b;
            XOR : result = a ^ b;
            // default : result = 0;
        endcase
endmodule