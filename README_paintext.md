# Project

Simple and functional implementation of the general porpose processing unit risc-v (reduced ISA processor).

  *This project is for learning purposes only.*

## The set of instruction already implemented

(opcode ==  5'b00000)   //LW
 (opcode ==  5'b01000)  //SW
 (opcode ==  5'b11000  && func3 ==  3'b000)   **BEQ**
else  if (opcode ==  5'b11000  && func3 ==  3'b001)   **BNE**
else  if (opcode ==  5'b01100  && func3 ==  3'b100)   **XOR**
else  if (opcode ==  5'b00100  && func3 ==  3'b100)   **XORI**
else  if (opcode ==  5'b00100  && func3 ==  3'b110)   **ORI**
else  if (opcode ==  5'b00100  && func3 ==  3'b111)   **ANDI**
else  if (opcode ==  5'b01100  && func3 ==  3'b101)   **SRL**
begin  //**ADD**
7'b0100000) begin  //**SUB**
else  if (opcode ==  5'b11011) begin  //**JAL**
else  begin  // **ADDI**


  
    

## Examples

I've been already tested.

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

You can also run on FPGA or by hand with systemverilog compiler and test it from terminal running this example like or bypassing any device and putting data on memory following these rules:

```verilog
initial begin
	cpu.processador.controller.inst
			.mem[0] = 32'hdeadbeef; //JAL 7a
	cpu.processador.controller.inst 
			.mem[32'h7a]= {12'd252, 5'd00, 3'b010, 5'd24, 7'b0000011 }; //LW from 252, x24
	cpu.processador.controller.inst
			.mem[32'h7b]= {12'h0aa, 5'd24, 3'b111, 5'd29, 7'b0010011 }; //ANDI from aa x24, write on x29.
end

```

## Important

> README

  
Take a look on the proprietary software files. But the source code and full implementation you can find in the /src folder.

Please remind that FPGA compatibility interface in /src/DE_0_NANO isn't by own right. Although other information you can freely copy, and use by your own interest and goal.
