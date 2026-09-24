module multiplexer_4_1_tb;

logic       IN0, IN1, IN2, IN3;
logic [1:0] SEL;

logic       OUT;

logic       OUT_expected;
logic [7:0] count;

multiplexer_4_1 inst (
    .IN0(IN0),
    .IN1(IN1),
    .IN2(IN2),
    .IN3(IN3),
    .SEL(SEL),
    .OUT(OUT)
);

task test_x (
    input       t_IN0, t_IN1, t_IN2, t_IN3,
    input [1:0] t_SEL,
    input       t_OUT
);

    {IN0, IN1, IN2, IN3, SEL} = {t_IN0, t_IN1, t_IN2, t_IN3, t_SEL};

    #1;

    if (OUT !== t_OUT) $error("SEL = %b | IN0 = %b | IN1 = %b | IN2 = %b | IN3 = %b | OUT = %b EXPECTED = %b", 
                                                         SEL, IN0, IN1, IN2, IN3, OUT, t_OUT);
    else count++;
endtask

initial begin
    count = 0;
    for (int sel = 0; sel < 4; sel++) begin
        SEL = sel;
        for (int in0 = 0; in0 <= 1; in0++) begin
            IN0 = in0;
            for (int in1 = 0; in1 <= 1; in1++) begin
                IN1 = in1;
                for (int in2 = 0; in2 <= 1; in2++) begin
                    IN2 = in2;
                    for (int in3 = 0; in3 <= 1; in3++) begin
                        IN3 = in3;

                        #10;

                        OUT_expected = (IN0 & ~SEL[1] & ~SEL[0])
                        | (IN1 & ~SEL[1] &  SEL[0])
                        | (IN2 &  SEL[1] & ~SEL[0])
                        | (IN3 &  SEL[1] &  SEL[0]);

                        if (OUT != OUT_expected) $error("SEL = %b | IN0 = %b | IN1 = %b | IN2 = %b | IN3 = %b | OUT = %b | EXPECTED = %b", 
                                                         SEL, IN0, IN1, IN2, IN3, OUT, OUT_expected);

                        else count++;
                    end
                end
            end
        end
    end

    test_x(1'bx, 1'b1, 1'b1, 1'b1, 2'b00, 1'bx);
    test_x(1'b1, 1'bx, 1'b1, 1'b1, 2'b01, 1'bx);
    test_x(1'b1, 1'b1, 1'bx, 1'b1, 2'b10, 1'bx);
    test_x(1'b1, 1'b1, 1'b1, 1'bx, 2'b11, 1'bx);   

    if (count == 68) $display ("PASS");

$finish;
end

initial begin
    $dumpfile("multiplexer_4_1_timing_diagram.vcd");
    $dumpvars(0, multiplexer_4_1_tb);
end
endmodule