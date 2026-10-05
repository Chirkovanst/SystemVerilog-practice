module full_adder_8bit (
    input  logic [7:0] A, B,
    input  logic        Cin,

    output logic        Cout,
    output logic [7:0] S
);

logic [8:0] carry;

assign carry[0] = Cin;
assign Cout     = carry[8];

full_adder inst[7:0] (
    .A    (A),
    .B    (B),
    .Cin  (carry[7:0]),
    .S    (S),
    .Cout (carry[8:1])
);

endmodule