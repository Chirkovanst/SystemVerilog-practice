module multiplier_4x4 (
    input  logic [3:0] A, B,
    output logic [7:0] P
);

    logic [3:0] P0;
    logic [3:0] P1;
    logic [3:0] P2;
    logic [3:0] P3;

    logic [7:0] shift_P0;
    logic [7:0] shift_P1;
    logic [7:0] shift_P2;
    logic [7:0] shift_P3;

    logic [7:0] SUM_1;
    logic [7:0] SUM_2;

    logic       carry1;
    logic       carry2;

    multiplier_2x2 inst_P0 (
        .A(A[1:0]),
        .B(B[1:0]),
        .P(P0)
    );

    multiplier_2x2 inst_P1 (
        .A(),
        .B(),
        .P()
    );

    multiplier_2x2 inst_P2 (
        .A(),
        .B(),
        .P()
    );

    multiplier_2x2 inst_P3 (
        .A(),
        .B(),
        .P()
    );

    assign shift_P0 = {4'b0000, P0};
    assign shift_P1 = {};
    assign shift_P2 = {};
    assign shift_P3 = {};

    full_adder_8bit inst_SUM1 (
        .A    (shift_P0),
        .B    (shift_P1),
        .Cin  (1'b0),
        .Cout (carry1),
        .S    (SUM_1)
    );

    full_adder_8bit inst_SUM2 (
        .A    (),
        .B    (),
        .Cin  (),
        .Cout (),
        .S    ()
    );

    full_adder_8bit inst_SUM3 (
        .A    (),
        .B    (),
        .Cin  (),
        .Cout (),
        .S    ()
    );

endmodule