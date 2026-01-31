# 8-bit-multicycle-cpu-

# 8-bit Multi-Cycle CPU in Verilog

## Overview
This project implements a custom **8-bit multi-cycle CPU** using Verilog HDL.  
The CPU follows a classical **FETCH → DECODE → EXECUTE → WRITE-BACK** architecture
controlled by a finite state machine (FSM).

The design was fully simulated using **Icarus Verilog** and verified with **GTKWave**.

---

## Architecture Highlights
- Multi-cycle CPU design
- FSM-based control unit
- Separate instruction and data memory
- Register file with 8 general-purpose registers
- ALU supporting arithmetic and logical operations
- Load/Store memory access
- Jump (control flow) instruction

---

## Instruction Format
Each instruction is 8 bits wide:
[7:5] Opcode
[4:2] Destination Register (rd)
[1:0] Source Register / Address (rs)


---

## Supported Instructions

| Opcode | Instruction | Description |
|------|-----------|-------------|
| 000 | ADD | rd ← rd + rs |
| 001 | SUB | rd ← rd - rs |
| 010 | AND | rd ← rd & rs |
| 011 | OR  | rd ← rd \| rs |
| 100 | LOAD | rd ← MEM[rs] |
| 101 | STORE | MEM[rs] ← rd |
| 110 | JMP | PC ← immediate |

---

## CPU Operation (Multi-Cycle)
Each instruction executes in four clock cycles:

1. **FETCH** – Fetch instruction from instruction memory
2. **DECODE** – Decode opcode and register fields
3. **EXECUTE** – Perform ALU operation or memory access
4. **WRITE-BACK** – Write result to register file (if applicable)

---

## Verification
- Simulated using **Icarus Verilog**
- Waveforms analyzed using **GTKWave**
- Verified correct operation of:
  - ALU instructions
  - LOAD / STORE memory operations
  - JMP control flow
  - Register file write-back timing

Example waveform screenshots are available in the `waveforms/` directory.

---

## Repository Structure
src/ Verilog RTL modules
tb/ Testbench
docs/ Architecture diagrams
waveforms/ GTKWave screenshots




---

## Tools Used
- Verilog HDL
- Icarus Verilog
- GTKWave

---

## Author
**Charan Maran**

This project was built as a learning-oriented CPU design to understand
datapath, control logic, and multi-cycle processor operation.

waveforms/ GTKWave screenshots
