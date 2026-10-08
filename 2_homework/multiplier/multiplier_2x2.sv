module multiplier_2x2 (
    input  logic [1:0] A, B,

    output logic [3:0] P
);

logic A0B0;
logic A1B0;

logic A0B1;
logic A1B1;

logic carry;

assign A0B0 = A[0] & B[0];
assign A1B0 = A[1] & B[0];

assign A0B1 = A[0] & B[1];
assign A1B1 = A[1] & B[1];

assign P[0] = A0B0;

half_adder inst_P1(
    .A(A0B1),
    .B(A1B0),
    .S(P[1]),
    .C(carry)
);

half_adder inst_P2_P3(
    .A(A1B1),
    .B(carry),
    .S(P[2]),
    .C(P[3])
);

endmodule