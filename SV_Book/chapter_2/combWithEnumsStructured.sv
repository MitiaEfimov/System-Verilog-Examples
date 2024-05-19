typedef enum bit [2:0] {
    AND = 3'b001,
    SUB = 3'b010,
    XOR = 3'b011,
    ADD = 3'b100,
    OR =  3'b110
    } aluFun_t;

typedef struct packed {
    aluFun_t oper;
    logic [7:0] inA, inB;
} command_t;

// Написал до того, как прочитал как правильно. Не работает
// Не поддерживается "наложение" нотаций, так что 'command.oper.first()' нужно переписать. (стр 23)
module combTestWithEnumsStruct;
    command_t command;
    bit [7:0] result;

    aluWithEnumsStruct dut (.command, .result);

    initial begin
        command.oper = command.oper.first();
        $monitor ("%b = %b %s %b", 
                result, a, command.oper, b);
        forever begin
            $display ("\nactual name is %s and it is %b position", command.oper.name(), command.oper);
            command.inA = 8'h35; command.inB = 8'h15;
            #1 if (command.oper == command.oper.last) break;
            command.oper = command.oper.next();
        end
    end
endmodule

// Не поддерживается "constant selects in always_* processes"
module aluWithEnumsStruct
    (input command_t command, 
    output bit [7:0] result);

    bit [2:0] oper;
    assign oper = command.oper;

    always_comb
        unique case (oper)
            ADD : result = command.inA + command.inB;
            SUB : result = command.inA - command.inB;
            AND : result = command.inA & command.inB;
            OR  : result = command.inA | command.inB;
            XOR : result = command.inA ^ command.inB;
            // default : result = 0;
        endcase
endmodule