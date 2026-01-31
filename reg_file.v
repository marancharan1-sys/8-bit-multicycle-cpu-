module reg_file (
    input  wire       clk,
    input  wire       we,
    input  wire [2:0] rd,
    input  wire [2:0] rs,
    input  wire [7:0] wd,
    output wire [7:0] rd_data,
    output wire [7:0] rs_data
);

reg [7:0] regs [0:7];

integer i;
initial begin
    for (i = 0; i < 8; i = i + 1)
        regs[i] = 8'd0;
    regs[1] = 8'd1;
end



assign rd_data = regs[rd];
assign rs_data = regs[rs];

always @(posedge clk) begin
    if (we)
        regs[rd] <= wd;
end

endmodule
