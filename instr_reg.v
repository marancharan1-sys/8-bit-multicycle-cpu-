module instr_reg (
    input  wire       clk,
    input  wire       ir_en,
    input  wire [7:0] instr_in,
    output reg  [7:0] instr
);

always @(posedge clk) begin
    if (ir_en)
        instr <= instr_in;
end

endmodule
