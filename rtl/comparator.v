module comparator (
    input wire [15:0]A,
    input wire [15:0]B,
    output wire [15:0]less_than,
    output wire [15:0]equal
);
    assign less_than = (A<B)?16'b1:16'b0;
    assign equal = (A==B)?16'b1:16'b0;
endmodule