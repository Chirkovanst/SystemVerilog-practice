module multiplexer_2_1_ventili (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);

    assign OUT = (IN1 & SEL) | (IN0 & ~SEL);

endmodule