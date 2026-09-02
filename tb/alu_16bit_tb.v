`timescale 1ns/1ps

module alu_16bit_tb;
    reg [15:0] A;
    reg [15:0] B;
    reg [3:0] opcode;
    reg cin;

    wire [15:0] Y;
    wire carry;
    wire overflow;
    wire zero;
    wire negative;

    integer pass;
    integer fail;

    alu_16bit DUT (
        .A(A),
        .B(B),
        .opcode(opcode),
        .cin(cin),
        .Y(Y),
        .carry(carry),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

    task test;
        input [3:0] op;
        input [15:0] a;
        input [15:0] b;
        input c;
        input [15:0] expected_y;
        input expected_carry;
        input expected_overflow;

        begin
            A = a;
            B = b;
            cin = c;
            opcode = op;

            #10;

            if ((Y == expected_y) &&
                (carry == expected_carry) &&
                (overflow == expected_overflow)) begin

                pass = pass + 1;
                $display("PASS | OP=%b A=%h B=%h cin=%b | Y=%h C=%b V=%b",
                         op, a, b, c, Y, carry, overflow);
            end
            else begin

                fail = fail + 1;
                $display("FAIL | OP=%b A=%h B=%h cin=%b | DUT: Y=%h C=%b V=%b | EXP: Y=%h C=%b V=%b",
                         op, a, b, c,
                         Y, carry, overflow,
                         expected_y, expected_carry, expected_overflow);
            end
        end
    endtask


    initial begin

        pass = 0;
        fail = 0;

        $display("        16-BIT ALU TESTBENCH");

        test(4'b0000, 16'h0005, 16'h0003, 1'b0, //add
             16'h0008, 1'b0, 1'b0);

        test(4'b0001, 16'h0005, 16'h0003, 1'b0, //sub
             16'h0002, 1'b1, 1'b0);

        test(4'b0010, 16'h0005, 16'h0000, 1'b0, //inc
             16'h0006, 1'b0, 1'b0);

        test(4'b0011, 16'h0005, 16'h0000, 1'b0, //dec
             16'h0004, 1'b1, 1'b0);

        test(4'b0100, 16'hAAAA, 16'h5555, 1'b0, //and
             16'h0000, 1'b0, 1'b0);

        test(4'b0101, 16'hAAAA, 16'h5555, 1'b0, //or
             16'hFFFF, 1'b0, 1'b0);

        test(4'b0110, 16'hAAAA, 16'h5555, 1'b0, //xor
             16'hFFFF, 1'b0, 1'b0);

        test(4'b0111, 16'hAAAA, 16'h5555, 1'b0, //nand
             16'hFFFF, 1'b0, 1'b0);

        test(4'b1000, 16'hAAAA, 16'h5555, 1'b0, //nor
             16'h0000, 1'b0, 1'b0);

        test(4'b1001, 16'hAAAA, 16'h5555, 1'b0, //xnor
             16'h0000, 1'b0, 1'b0);

        test(4'b1010, 16'hAAAA, 16'h0000, 1'b0, //not
             16'h5555, 1'b0, 1'b0);

        test(4'b1011, 16'h0001, 16'h0000, 1'b0, //left
             16'h0002, 1'b0, 1'b0);

        test(4'b1100, 16'h8000, 16'h0000, 1'b0, //right
             16'h4000, 1'b0, 1'b0);

        test(4'b1101, 16'h0003, 16'h0005, 1'b0, //less than
             16'h0001, 1'b0, 1'b0);

        test(4'b1110, 16'h1234, 16'h1234, 1'b0, //eq
             16'h0001, 1'b0, 1'b0);

        test(4'b1111, 16'h0005, 16'h0003, 1'b1, //adc
             16'h0009, 1'b0, 1'b0);

        test(4'b0000, 16'hFFFF, 16'h0001, 1'b0, //add carry
             16'h0000, 1'b1, 1'b0);

        test(4'b0000, 16'h7FFF, 16'h0001, 1'b0, //add signed
             16'h8000, 1'b0, 1'b1);

        test(4'b0001, 16'h0000, 16'h0001, 1'b0, //sub borrow
             16'hFFFF, 1'b0, 1'b0);

        test(4'b0001, 16'h8000, 16'h0001, 1'b0, //sub signed
             16'h7FFF, 1'b1, 1'b1);

        test(4'b0010, 16'h7FFF, 16'h0000, 1'b0, //inc
             16'h8000, 1'b0, 1'b1);

        test(4'b0011, 16'h8000, 16'h0000, 1'b0, //dec
             16'h7FFF, 1'b1, 1'b1);

        $display("ALU TEST COMPLETE");
        $display("PASS = %0d", pass);
        $display("FAIL = %0d", fail);
        $display("TOTAL = %0d", pass + fail);

        if (fail == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED!");

        $finish;
    end

endmodule