module multiplexer_2_1_vector (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);
    logic [1:0] IN;     // Создали вектор

    assign IN[0] = IN0; // Нулевому биту вектора присвоили вход IN0
    assign IN[1] = IN1; // Первому биту вектора присвоили вход IN1

    assign OUT = IN[SEL];

endmodule