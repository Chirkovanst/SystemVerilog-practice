`timescale 1ns / 1ps 
module full_adder_tb;

logic A, B;
logic Cin;

logic S;
logic Cout;

logic [3:0] count = 0;

full_adder inst (
    .A    (A),
    .B    (B),
    .Cin  (Cin),
    .S    (S),
    .Cout (Cout)
);

logic [1:0] reference;
assign reference = {1'b0, A} + {1'b0, B} + {1'b0, Cin};

initial begin
    test();
    if (count == 8) $display("PASS");

$finish;
end

task test();
for (int i = 0; i < 2; i++) begin
    A = i;
    for (int j = 0; j < 2; j++) begin
        B = j;
        for (int k = 0; k < 2; k++) begin
            Cin = k;

            #1;

            if (reference === {Cout, S}) count++;
            else $error("FAIL: A = %b, B = %b, Cin = %b | S = %b, Cout = %b | must be = %b",
                           A, B, Cin, S, Cout, reference);
        end
    end
end
endtask

endmodule
