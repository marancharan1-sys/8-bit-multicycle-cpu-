module data_mem (
    input  wire       clk,
    input  wire       we,
    input  wire [7:0] addr,
    input  wire [7:0] wd,
    output wire [7:0] rd
);
data_mem DM (
    .clk  (clk),
    .we   (mem_we),
    .addr (rs_data),   // address comes from Rs
    .wd   (rd_data),   // STORE: write Rd into memory
    .rd   (mem_rd)     // LOAD: read data from memory
);

reg [7:0] mem [0:255];

assign rd = mem[addr];

always @(posedge clk) begin
    if (we)
        mem[addr] <= wd;
end

endmodule
