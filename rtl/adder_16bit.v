module adder_16bit (
    input wire [15:0]A,
    input wire [15:0]B,
    input wire cin,
    output wire [15:0]sum,
    output wire carry
);
    wire [16:0] c;
    assign c[0] = cin;

    full_adder FA0(.a(A[0]),.b(B[0]),.cin(c[0]),.sum(sum[0]),.cout(c[1]));
    full_adder FA1(.a(A[1]),.b(B[1]),.cin(c[1]),.sum(sum[1]),.cout(c[2]));
    full_adder FA2(.a(A[2]),.b(B[2]),.cin(c[2]),.sum(sum[2]),.cout(c[3]));
    full_adder FA3(.a(A[3]),.b(B[3]),.cin(c[3]),.sum(sum[3]),.cout(c[4]));
    full_adder FA4(.a(A[4]),.b(B[4]),.cin(c[4]),.sum(sum[4]),.cout(c[5]));
    full_adder FA5(.a(A[5]),.b(B[5]),.cin(c[5]),.sum(sum[5]),.cout(c[6]));
    full_adder FA6(.a(A[6]),.b(B[6]),.cin(c[6]),.sum(sum[6]),.cout(c[7]));
    full_adder FA7(.a(A[7]),.b(B[7]),.cin(c[7]),.sum(sum[7]),.cout(c[8]));
    full_adder FA8(.a(A[8]),.b(B[8]),.cin(c[8]),.sum(sum[8]),.cout(c[9]));
    full_adder FA9(.a(A[9]),.b(B[9]),.cin(c[9]),.sum(sum[9]),.cout(c[10]));
    full_adder FA10(.a(A[10]),.b(B[10]),.cin(c[10]),.sum(sum[10]),.cout(c[11]));
    full_adder FA11(.a(A[11]),.b(B[11]),.cin(c[11]),.sum(sum[11]),.cout(c[12]));
    full_adder FA12(.a(A[12]),.b(B[12]),.cin(c[12]),.sum(sum[12]),.cout(c[13]));
    full_adder FA13(.a(A[13]),.b(B[13]),.cin(c[13]),.sum(sum[13]),.cout(c[14]));
    full_adder FA14(.a(A[14]),.b(B[14]),.cin(c[14]),.sum(sum[14]),.cout(c[15]));
    full_adder FA15(.a(A[15]),.b(B[15]),.cin(c[15]),.sum(sum[15]),.cout(c[16]));

    assign carry = c[16];
endmodule