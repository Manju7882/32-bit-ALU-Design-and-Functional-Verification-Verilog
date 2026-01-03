**📌 Overview
**
This project implements a 32-bit Arithmetic Logic Unit (ALU) using Verilog HDL and verifies its functionality through simulation in Xilinx ISE. 
The design supports arithmetic, logical, and shift operations with proper handling of corner cases.

**⚙️ Features**

32-bit input operands (a, b)

64-bit output result

**Supported operations:**

**Arithmetic:** ADD, SUB, INC, DEC, MUL, DIV

**Logical:** AND, OR, XOR, XNOR, NAND, NOR, INV, BUF

**Shift:** SHL, SHR

**Tri-state output control using output enable (oe)**

**Divide-by-zero protection**

**🧪 Functional Verification**

A structured Verilog testbench applies multiple input combinations

All ALU commands are verified

**Corner cases tested:**

Divide-by-zero

Underflow conditions

Tri-state output behavior

Outputs observed using console logs and waveforms

**🛠 Tools Used**

Verilog HDL

Xilinx ISE

RTL Simulation
