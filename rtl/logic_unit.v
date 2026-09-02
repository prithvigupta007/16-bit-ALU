module logic_unit (
    input wire [15:0]A,
    input wire [15:0]B,
    input wire [2:0]op,
    output reg [15:0]Y
);
    always @(*) begin
	case (op)
	    3'b000: Y = A&B; //and
            3'b001: Y = A|B; //or
            3'b010: Y = A^B; //xor
            3'b011: Y = ~(A&B); //nand
            3'b100: Y = ~(A|B); //nor
            3'b101: Y = ~(A^B); //xnor
            3'b110: Y = ~A; //not

            default: Y = 16'b0;

        endcase
    end
endmodule