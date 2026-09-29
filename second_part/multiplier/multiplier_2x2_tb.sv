`timescale 1ns / 1ps
module multiplier_2x2_tb;

logic [1:0] A, B;
logic [3:0] P;
logic [5:0] count = 0;

multiplier_2x2 inst(
    .A(A),
    .B(B),
    .P(P)
);

initial begin
    for(int i = 0; i < 4; i++) begin
        A = i;
        for (int j = 0; j < 4; j++) begin
            B = j;

            #10;

            if (P == A*B) count++;
            else $error ("FAIL: A = %b, B = %b, P = %b, must be = %b", A, B, P, A * B);
        end
    end
    if (count == 16) $display("PASS");
$finish;
end

initial begin
    $dumpfile("multiplier_2х2_timing_diagram.vcd");
    $dumpvars(0, multiplier_2x2_tb);
end

endmodule
