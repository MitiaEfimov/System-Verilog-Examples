module custom_bcdADD (
    input logic [3:0] inA, inB,
    input logic carryIn,
    output logic [3:0] customSum,
    output logic carryOut);  

    logic [3:0] subSum;
    assign subSum = inA + inB + carryIn;
    assign carryOut = 
        (
            (
                (subSum[3] & (subSum[2] | subSum[1]) ) |       // есть бит 4 + биты 3 или 2 (subSum >= 10)
                (((inA + inB) >= 5'd15)  | carryIn ) )   // сумма входящих чисел больше 15 или бит переноса уже стоял
    ) ? 1'b1 : 1'b0; 
    assign customSum = (carryOut == 0) ? (inA + inB) : (inA + inB + 6);

endmodule

module test_bcdADD;
    logic [3:0] test_inA, test_inB;
    logic carryIn;
    logic [4:0] test;

    // [3:0] inA, inB;
    // logic carryOut;


    custom_bcdADD dut (.inA(test_inA[3:0]), .inB(test_inB[3:0]), .customSum(test[3:0]), .carryIn(carryIn), .carryOut(test[4]));

    initial begin
        // $monitor ("%b", test);
        assign carryIn = 0;

        for (test_inA = 'd0; test_inA != 10; test_inA++) begin

            for (test_inB = 'd0; test_inB != 10; test_inB++) begin
                #1
                // $display("inA = %d (%b) inB = %d (%b); test = {%d%d}", test_inA[3:0],  test_inA[3:0], test_inB[3:0], test_inB[3:0], test[4], test[3:0]);
                // $display("%b; %d; %d; %d", test, test[4]*10, test[3:0], test[4]*10 + test[3:0]);
                if ((test_inA + test_inB) != (test[4]*10 + test[3:0]))
                    $display("OOPS!! inA = %d (%b) inB = %d (%b); test = {%d%d}", test_inA[3:0],  test_inA[3:0], test_inB[3:0], test_inB[3:0], test[4], test[3:0]);


                // $display("sum = %d", );
                // $display("%b = test[4] * 10", test);
                // $display("%b = test[4]", test[4]);

                // if (test_inA[3:0] + test_inB[3:0] != ()
                //     $display ("oops! inA + inB = %b, <- wrong\ninA + inB = %b <- should be", (test[4] * 10 + test[3:0]), (test_inA[3:0] + test_inB[3:0]));
                // else $display ("nice! inA + inB = %b, wicth is %d * 10 + %d <- calculated", (test_sum), test[4] * 10, test_inB[3:0]);
            end
        end
    end
endmodule

          