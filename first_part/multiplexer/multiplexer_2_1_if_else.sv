module multiplexer_2_1_if_else (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);

    always_comb begin
        if (SEL) OUT = IN1;
        else     OUT = IN0;
    end

endmodule