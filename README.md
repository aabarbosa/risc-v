## The project

Simple and functional implementation of the general purpose processing unit risc-v (reduced ISA processor).

  *This project is for learning purposes only.*

### The set of instruction already implemented

| Instruction  | Opcode | func3  |   |   |
|----------|---|---|---|---|
| **SW**   |   |   |   |   |
| **BEQ**  |   |   |   |   |
| **BNE**  |   |   |   |   |
| **XOR**  |   |   |   |   |
| **XORI** |   |   |   |   |
| **ORI**  |   |   |   |   |
| **ANDI** |   |   |   |   |
| **SRL**  |   |   |   |   |
| **ADD**  |   |   |   |   |
| **SUB**  |   |   |   |   |
| **JAL**  |   |   |   |   |
| **ADDI** |   |   |   |   |
| **LW**   |   |   |   |   |

### Examples

I've been tested.

```nasm
.section .text
.globl _start
_start:
	addi a1, zero, 0x20
	addi a2, zero, 0x20
	sw a1, 0xfc(zero)
	lw t3, 0xfc(zero)
done:
	sub a2 , a2, a2
	sw a2 , 0x34(zero)
	lw s11, 0x34(zero)
	lw t6 , 0x34(zero)
	addi a1 , a1, 1
target:
	beq a1, a2, done
	addi t6, a1, 0x99
	jal done
end:
```
>Aditional
You can also run on FPGA or by hand with systemverilog compiler and test it from terminal running this example like or bypassing devices and putting data on memory, following:

```verilog
initial begin
	cpu.processador.controller.inst.
		.mem[0] = 32'hdeadbeef; //JAL 7a
	cpu.processador.controller.inst 
		.mem[32'h7a]= {12'd252, 5'd00, 3'b010, 5'd24, 7'b0000011 }; //LW from 252, x24
	cpu.processador.controller.inst
		.mem[32'h7b]= {12'h0aa, 5'd24, 3'b111, 5'd29, 7'b0010011 }; //ANDI from aa x24, write on x29.
end

```

### Important
Take a look on the proprietary software files. But the source code and full implementation you can find in the /src folder. Please remind that FPGA compatibility interface in /src/DE_0_NANO isn't by own right. Although other information you can freely copy, and use by your own interest and goal.
