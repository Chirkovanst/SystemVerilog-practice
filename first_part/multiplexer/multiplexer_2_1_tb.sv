module multiplexer_2_1_tb;

logic IN0, IN1, SEL;
logic OUT;

logic OUT_ventili;
logic OUT_if_else;
logic OUT_case;
logic OUT_ternary_operator;
logic OUT_vector;

logic OUT_expected;

logic [3:0] count_ventili          = 0;
logic [3:0] count_if_else          = 0;
logic [3:0] count_case             = 0;
logic [3:0] count_ternary_operator = 0;
logic [3:0] count_vector           = 0;

multiplexer_2_1_ventili inst_ventili (
    .IN0(IN0),
    .IN1(IN1),
    .SEL(SEL),
    .OUT(OUT_ventili)
);

multiplexer_2_1_if_else inst_if_else (
    .IN0(IN0),
    .IN1(IN1),
    .SEL(SEL),
    .OUT(OUT_if_else)
);

multiplexer_2_1_case inst_case (
    .IN0(IN0),
    .IN1(IN1),
    .SEL(SEL),
    .OUT(OUT_case)
);

multiplexer_2_1_ternary_operator inst_ternary_operator (
    .IN0(IN0),
    .IN1(IN1),
    .SEL(SEL),
    .OUT(OUT_ternary_operator)
);

multiplexer_2_1_vector inst_vector (
    .IN0(IN0),
    .IN1(IN1),
    .SEL(SEL),
    .OUT(OUT_vector)
);

initial begin
    for (int sel = 0; sel <= 1; sel++) begin
        SEL = sel;
        for (int in0 = 0; in0 <= 1; in0++) begin
            IN0 = in0;
            for (int in1 = 0; in1 <= 1; in1++) begin
                IN1 = in1;

                #10;

                OUT_expected = (IN1 & SEL) | (IN0 & ~SEL);

                if (OUT_expected == OUT_ventili) count_ventili++;
                else $display("%b | %b | %b | %b | FAIL_ventili", SEL, IN0, IN1, OUT_ventili);

                if (OUT_expected == OUT_if_else) count_if_else++;
                else $display("%b | %b | %b | %b | FAIL_if_else", SEL, IN0, IN1, OUT_if_else);

                if (OUT_expected == OUT_case) count_case++;
                else $display("%b | %b | %b | %b | FAIL_case", SEL, IN0, IN1, OUT_case);

                if (OUT_expected == OUT_ternary_operator) count_ternary_operator++;
                else $display("%b | %b | %b | %b | FAIL_ternary_operator", SEL, IN0, IN1, OUT_ternary_operator);

                if (OUT_expected == OUT_vector) count_vector++;
                else $display("%b | %b | %b | %b | FAIL_vector", SEL, IN0, IN1, OUT_vector);

            end
        end
    end
    if (count_ventili == 8)             
        $display("multiplexer_2_1_ventili PASS");
    if (count_if_else == 8)             
        $display("multiplexer_2_1_if_else PASS");
    if (count_case == 8)                
        $display("multiplexer_2_1_case PASS");
    if (count_ternary_operator == 8)    
        $display("multiplexer_2_1_ternary_operator PASS");
    if (count_vector == 8)  
        $display("multiplexer_2_1_vector PASS");

$finish;
end

initial begin
    $dumpfile("multiplexer_2_1_timing_diagram.vcd");
    $dumpvars(0, multiplexer_2_1_tb);
end

endmodule
