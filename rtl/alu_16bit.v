module alu_16bit (
    input wire [15:0] A,
    input wire [15:0] B,
    input wire [3:0] opcode,
    input wire cin,

    output reg [15:0] Y,
    output reg carry,
    output reg overflow,
    output wire zero,
    output wire negative
);

    wire [15:0] arithmetic_Y;
    wire arithmetic_carry;
    wire arithmetic_overflow;
    reg [2:0] arithmetic_op;
    arithmetic_unit U_ARITHMETIC (
        .A(A),
        .B(B),
        .op(arithmetic_op),
        .cin(cin),
        .Y(arithmetic_Y),
        .carry(arithmetic_carry),
        .overflow(arithmetic_overflow)
    );

    wire [15:0] logic_Y;
    reg [2:0] logic_op;
    logic_unit U_LOGIC (
        .A(A),
        .B(B),
        .op(logic_op),
        .Y(logic_Y)
    );

    wire [15:0] shift_Y;
    wire shift_carry;
    reg shift_direction;
    shifter U_SHIFTER (
        .A(A),
        .direction(shift_direction),
        .Y(shift_Y),
        .carry(shift_carry)
    );

    wire [15:0] less_than;
    wire [15:0] equal;
    comparator U_COMPARATOR (
        .A(A),
        .B(B),
        .less_than(less_than),
        .equal(equal)
    );

    always @(*) begin //output mux
	arithmetic_op = 3'b000;
        logic_op = 3'b000;
        shift_direction = 1'b0;
	Y = 16'b0;
        carry = 1'b0;
        overflow = 1'b0;

        case (opcode)

            4'b0000: begin 
                arithmetic_op = 3'b000;
                Y = arithmetic_Y;
                carry = arithmetic_carry;
                overflow = arithmetic_overflow;
            end

            4'b0001: begin 
                arithmetic_op = 3'b001;
                Y = arithmetic_Y;
                carry = arithmetic_carry;
                overflow = arithmetic_overflow;
            end

            4'b0010: begin
                arithmetic_op = 3'b010;
                Y = arithmetic_Y;
                carry = arithmetic_carry;
                overflow = arithmetic_overflow;
            end

            4'b0011: begin
                arithmetic_op = 3'b011;
                Y = arithmetic_Y;
                carry = arithmetic_carry;
                overflow = arithmetic_overflow;
            end

            4'b0100: begin
                logic_op = 3'b000;
                Y = logic_Y;
            end

            4'b0101: begin
                logic_op = 3'b001;
                Y = logic_Y;
            end

            4'b0110: begin
                logic_op = 3'b010;
                Y = logic_Y;
            end

            4'b0111: begin
                logic_op = 3'b011;
                Y = logic_Y;
            end

            4'b1000: begin
                logic_op = 3'b100;
                Y = logic_Y;
            end

            4'b1001: begin
                logic_op = 3'b101;
                Y = logic_Y;
            end

            4'b1010: begin
                logic_op = 3'b110;
                Y = logic_Y;
            end

            4'b1011: begin
                shift_direction = 1'b0;
                Y = shift_Y;
                carry = 1'b0;
            end

            4'b1100: begin
                shift_direction = 1'b1;
                Y = shift_Y;
                carry = 1'b0;
            end

            4'b1101: begin
                Y = less_than;
            end

            4'b1110: begin
                Y = equal;
            end

            4'b1111: begin
                arithmetic_op = 3'b100;
                Y = arithmetic_Y;
                carry = arithmetic_carry;
                overflow = arithmetic_overflow;
            end

            default: begin
                Y = 16'b0;
                carry = 1'b0;
                overflow = 1'b0;
            end

        endcase
    end
    assign zero = (Y == 16'b0);
    assign negative = Y[15];
endmodule