module multiplexer_2_1_case (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);

    always_comb begin
        case(SEL)
        0:       OUT = IN0;
        1:       OUT = IN1;
        default: OUT = 1'bx;
        endcase
    end

endmodule