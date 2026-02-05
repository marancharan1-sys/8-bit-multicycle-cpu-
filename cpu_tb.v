module cpu_tb;

reg clk = 0;
reg reset = 1;

cpu_top DUT (
    .clk(clk),
    .reset(reset)
);

// Clock generation
always #5 clk = ~clk;

// VCD dump
initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, cpu_tb);
end

// Reset + finish
initial begin
    #10 reset = 0;
    #300 $finish;
end

endmodule
