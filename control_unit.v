module control_unit (
    input  wire       clk,
    input  wire       reset,
    input  wire [2:0] opcode,
    input  wire       zero,

    output reg        pc_en,
    output reg        ir_en,
    output reg        reg_we,
    output reg        mem_we,
    output reg [2:0]  alu_op,
    output reg [1:0]  state
);

    // FSM states
    localparam FETCH  = 2'd0;
    localparam DECODE = 2'd1;
    localparam EXEC   = 2'd2;
    localparam WB     = 2'd3;

    // ========================
    // State register
    // ========================
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= FETCH;
        else begin
            case (state)
                FETCH:  state <= DECODE;
                DECODE: state <= EXEC;
                EXEC:   state <= WB;
                WB:     state <= FETCH;
                default: state <= FETCH;
            endcase
        end
    end

    // ========================
    // Control logic
    // ========================
    always @(*) begin
        // defaults
        pc_en   = 0;
        ir_en   = 0;
        reg_we  = 0;
        mem_we  = 0;
        alu_op  = 3'b000;

        case (state)

            // ----------------
            FETCH: begin
                pc_en = 1;
                ir_en = 1;
            end

            // ----------------
            EXEC: begin
                case (opcode)
                    3'b000, // ADD
                    3'b001, // SUB
                    3'b010, // AND
                    3'b011: // OR
                        alu_op = opcode;

                    3'b101: // STORE
                        mem_we = 1;

                    default: ;
                endcase
            end

            // ----------------
            WB: begin
                case (opcode)
                    3'b000, // ADD
                    3'b001, // SUB
                    3'b010, // AND
                    3'b011, // OR
                    3'b100: // LOAD
                        reg_we = 1;

                    default: ;
                endcase
            end

            default: ;
        endcase
    end

endmodule
