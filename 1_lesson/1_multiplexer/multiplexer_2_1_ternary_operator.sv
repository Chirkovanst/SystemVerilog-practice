module multiplexer_2_1_ternary_operator (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);

    assign OUT = SEL ? IN1 : IN0;

endmodule