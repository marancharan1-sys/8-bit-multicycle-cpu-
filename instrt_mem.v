module instr_mem (
    input  wire [7:0] addr,
    output wire [7:0] instr
);

reg [7:0] mem [0:255];

initial begin
    // Program:
    // R1 = R1 + R1
    // MEM[R0] = R1
    // R2 = MEM[R0]
    // JMP 0

    mem[0] = 8'b000_001_01; // ADD   R1, R1
    mem[1] = 8'b101_001_00; // STORE R1, [R0]
    mem[2] = 8'b100_010_00; // LOAD  R2, [R0]
    mem[3] = 8'b110_000_00; // JMP 0
end

assign instr = mem[addr];

endmodule
