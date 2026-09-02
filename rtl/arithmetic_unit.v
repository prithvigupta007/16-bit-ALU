module arithmetic_unit (
    input wire [15:0]A,
    input wire [15:0]B,
    input wire [2:0] op,
    input wire cin,

    output reg [15:0]Y,
    output reg carry,
    output reg overflow
);
    reg [15:0] adder_B; //inputs
    reg adder_cin;

    wire [15:0] adder_sum; //outputs
    wire adder_carry;

    adder_16bit uut (.A(A),.B(adder_B),.cin(adder_cin),.sum(adder_sum),.carry(adder_carry));

    always @(*) begin
        adder_B = 16'b0;
        adder_cin = 1'b0;

        Y = 16'b0;
        carry = 1'b0;
        overflow = 1'b0;

        case (op)
            3'b000: begin //add
                adder_B   = B;
                adder_cin = 1'b0;

                Y = adder_sum;
                carry = adder_carry;

                overflow = (~(A[15]^B[15]))&(Y[15]^A[15]);
            end

            3'b001: begin //sub=A~B+1
                adder_B = ~B;
                adder_cin = 1'b1;

                Y = adder_sum;
                carry = adder_carry;

                overflow = (A[15]^B[15])&(Y[15]^A[15]);
	    end

            3'b010: begin //inc=A+1
                adder_B = 16'b0;
                adder_cin = 1'b1;

                Y = adder_sum;
                carry = adder_carry;

                overflow = (~A[15])&Y[15];
            end

            3'b011: begin //dec=A-1
                adder_B = 16'hFFFF;
                adder_cin = 1'b0;

                Y = adder_sum;
                carry = adder_carry;

                overflow = A[15]&~Y[15];
            end

            3'b100: begin //adc=A+B+cin
                adder_B = B;
                adder_cin = cin;

                Y = adder_sum;
                carry = adder_carry;

                overflow = (~(A[15]^B[15]))&(Y[15]^A[15]);
            end

            default: begin
                Y = 16'b0;
                carry = 1'b0;
                overflow = 1'b0;
            end
	endcase
    end
endmodule