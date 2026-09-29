`timescale 1ns / 1ps
module encoder_task_tb;

logic [15:0] X;
logic [3:0]  Y;

logic [4:0]  count = 0;

encoder_task inst(
    .X (X),
    .Y (Y)
);

initial begin
    for (int i = 0; i < 16; i++) begin
        X = 16'b1 << i;

        #10;
            
        if (Y != i) $error  ("FAIL: X = %b, expected = %0d, got = %0d", X, i, Y);
        else        count++;
    end

    if (count == 16) $display("PASS");
$finish;
end

initial begin
    $dumpfile("encoder_task_timing_diagram.vcd");
    $dumpvars(0, encoder_task_tb);
end

endmodule