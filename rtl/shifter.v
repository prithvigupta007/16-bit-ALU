module shifter (
    input wire [15:0]A,
    input wire direction,
    output reg [15:0]Y,
    output reg carry
);
    always @(*) begin
	Y = 16'b0;
        carry = 1'b0;
	if (direction == 1'b0) begin
            Y = A<<1; //left shift
            carry = A[15];
	end
        else begin
            Y = A>>1; //right shift
            carry = A[0];
	end
    end
endmodule