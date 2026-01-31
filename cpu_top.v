module cpu_top (
    input wire clk,
    input wire reset
);

    // ========================
    // Wires
    // ========================
    wire [7:0] pc_out;
    wire [7:0] pc_next;

    wire [7:0] instr;
    wire [7:0] ir;

    wire [7:0] rd_data;
    wire [7:0] rs_data;
    wire [7:0] alu_out;

    wire zero;

    wire pc_en;
    wire ir_en;
    wire reg_we;
    wire mem_we;

    wire [2:0] alu_op;
    wire [1:0] state;
    wire [7:0] mem_rd;
wire [7:0] wb_data;


    // ========================
    // Instruction fields (ISA decode)
    // ========================
    wire [2:0] opcode = ir[7:5];      // what to do
    wire [2:0] rd     = ir[4:2];      // destination register
    wire [2:0] rs     = {1'b0, ir[1:0]}; // source register (zero-extended)

    // Write-back data select (LOAD vs ALU)
assign wb_data = (opcode == 3'b100) ? mem_rd : alu_out;


    // ========================
    // PC next logic (JMP support)
    // ========================
    // opcode 110 = JMP
    // jump target = ir[1:0] (0–3)
   assign pc_next =
    (state == 2'd0 && opcode == 3'b110) ? {6'd0, ir[1:0]} :
                                          pc_out + 8'd1;

    // ========================
    // Module instantiations
    // ========================

    // Program Counter
    pc PC (
        .clk     (clk),
        .reset   (reset),
        .pc_en   (pc_en),
        .pc_next (pc_next),
        .pc      (pc_out)
    );

    // Instruction Memory (ROM)
    instr_mem IM (
        .addr  (pc_out),
        .instr (instr)
    );

    // Instruction Register
    instr_reg IR (
        .clk      (clk),
        .ir_en    (ir_en),
        .instr_in (instr),
        .instr    (ir)
    );

    // Register File
    reg_file RF (
        .clk     (clk),
        .we      (reg_we),
        .rd      (rd),
        .rs      (rs),
        .wd      (wb_data),
        .rd_data (rd_data),
        .rs_data (rs_data)
    );

    // ALU
    alu ALU (
        .a      (rd_data),
        .b      (rs_data),
        .alu_op (alu_op),
        .result (alu_out),
        .zero   (zero)
    );

    // Control Unit (FSM)
    control_unit CU (
        .clk    (clk),
        .reset  (reset),
        .opcode (opcode),
        .zero   (zero),
        .pc_en  (pc_en),
        .ir_en  (ir_en),
        .reg_we (reg_we),
        .mem_we (mem_we),
        .alu_op (alu_op),
        .state  (state)
    );

endmodule
