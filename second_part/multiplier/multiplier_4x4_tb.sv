module multiplier_4x4_tb;

logic [3:0] A, B;
logic [7:0] P;

logic [9:0] count = 0;

multiplier_4x4 inst(
    .A(A),
    .B(B),
    .P(P)
);

initial begin
    for(int i = 0; i < 16; i++) begin
        A = i;
        for (int j = 0; j < 16; j++) begin
            B = j;

            #10;

            if (P == (A * B)) count++;
            else $error ("FAIL: A = %b, B = %b, P = %b, reference = %b", A, B, P, (A * B));
        end
    end
    if (count == 256) $display("PASS");
$finish;
end

initial begin
    $dumpfile("multiplier_4х4_timing_diagram.vcd");
    $dumpvars(0, multiplier_4x4_tb);
end

endmodule