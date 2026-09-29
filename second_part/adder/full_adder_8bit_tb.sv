`timescale 1ns / 1ps 
module full_adder_8bit_tb;

logic [7:0] A, B;
logic        Cin;

logic        Cout;
logic [7:0] S;

logic [10:0] count = 0;

full_adder_8bit inst(
    .A    (A),
    .B    (B),
    .Cin  (Cin),
    .Cout (Cout),
    .S    (S)
);

logic [8:0] reference;
assign reference = {1'b0, A} + {1'b0, B} + Cin;

initial begin
    random_test();
    if (count == 1000) $display("PASS");

$finish;
end

task random_test();
    repeat(1000) begin
        A   = $urandom();
        B   = $urandom();
        Cin = $urandom_range(1);

        #1;

        if (reference === {Cout, S}) count++;
        else $error("FAIL: A = 0x%08h, B = 0x%08h, Cin = %b | S = 0x%08h, Cout = %b | must be S = 0x%09h", A, B, Cin, S, Cout, reference);
    end
endtask

initial begin
    $dumpfile("full_adder_8bit_timing_diagram.vcd");
    $dumpvars(0, full_adder_8bit_tb);
end
endmodule 


