module half_adder_tb;

logic A;
logic B;
logic S;
logic C;

logic [2:0] count = 0;

Half_Adder inst(
    .A(A),
    .B(B),
    .S(S),
    .C(C)
);

initial begin
    for (int i = 0; i < 2; i++) begin
    A = i;
        for (int j = 0; j < 2; j++) begin
        B = j;

        #10;

        if ({C, S} != A + B)
            $error(
                "FAIL: A = %b B = %b | C = %b S = %b, must be = %b",
                A, B, C, S, A + B
            );
        else
            count++;
    end
end
    
    if (count == 4) $display("PASS");
end

initial begin
    $dumpfile("half_adder_timing_diagram.vcd");
    $dumpvars(0, half_adder_tb);
end

endmodule