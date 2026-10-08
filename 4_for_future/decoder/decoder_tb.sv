`timescale 1ns / 1ps
module decoder_tb;
logic [3:0]  A;
logic [15:0] Y;

logic [4:0]  count = 0;

decoder inst (
    .A(A),
    .Y(Y)
);

initial begin
    for (int i = 0; i < 16; i++) begin
        A = i;

        #10;

        if   (Y == (16'b1 << i)) count++;
        else                     $error("FAIL: A = %04b, Y = %016b, must be Y = %016b", A, Y, (16'b1 << i));
    end
    if (count == 16) $display("PASS");

$finish;
end

initial begin
    $dumpfile("decoder_timing_diagram.vcd");
    $dumpvars(0, decoder_tb);
end
endmodule
