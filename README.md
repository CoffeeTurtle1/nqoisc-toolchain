# NQOISC (Not Quite One Instruction Set Computer)

This repository contains the source code for the NQOISC basic toolchain. The
C compiler is contained in it's own repository
[here](https://github.com/CoffeeTurtle1/nqoisc-cc).

## The NQOISC Instruction Set
The insruction set is based on [brainfuck](https://esolangs.org/wiki/Brainfuck).
Each instruction is 32-bits long. Memory is byte addressed and uses big endian.
There are two registers a program counter and a data pointer. The data pointer
points to the current memory address to be modified and the program counter
points to the next instruction to be executed. It is assumed that both the
program counter and the data pointer are initialized to zero.

Any I/O is memory mapped.

Instruction format:<br>
```
Opcode  Imm 30-bit
00      000000000000000000000000000000
```
Note: Imm is sign extended to 32-bits.

| Opcode |  Name       |  Description                                                                      |
|--------|-------------|-----------------------------------------------------------------------------------|
| 00     |  right imm  |  Move the data pointer to the right by imm bytes.                                 |
| 01     |  add   imm  |  Add imm to the current address pointed to by the data pointer.                   |
| 10     |  bnz   imm  |  Set the program counter to program counter + imm if the current address pointed to by the data pointer is equal to zero. |

## Compiling
Run this command to compile the toolchain.
```bash
# ./build.sh && ./install.sh
```

## Files
| Name           | Description                                       |
|----------------|---------------------------------------------------|
| disassembler.c | NQOISC disassembler.                              |
| simulator.c    | ISA simulator. Run `nqoisc-sim -h` for more info. |
| asm.c          | An assembler.                                     |
| build.sh       | Bash script to build the toolchain.               |
| install.sh     | Bash script to install the toolchain.             |
| vector.h       | Header file for `vector.c`.                       |
| vector.c       | A simple vector implementation.                   |

## Using the tools

### The Disassembler
To disassemble an NQOISC binary run the following command.
```
nqoisc-disassembler binary.bin
```

### The Simulator
Run `nqoisc-sim -h` for info on how to use the simulator.

### The assembler
Run `nqoisc-asm -h` for instructions on how to use the command.

Assembly language EBNF.
```
program ::= stmt.
program ::= program stmt.

stmt ::= instruction-stmt.
stmt ::= label-stmt.

label-stmt ::= ? Identifier followed by a colon ?.
instruction-stmt ::= instruction value.

value ::= INTEGER.
value ::= IDENTIFIER.

instruction ::= RIGHT.
instruction ::= LEFT.
instruction ::= ADD.
instruction ::= SUB.
instruction ::= BNZ.
```

| Instruction | Description                                            | Is a pseudo instruction? |
|-------------|--------------------------------------------------------|--------------------------|
| right x     | Move the data pointer right.                           | No.                      |
| left x      | Move the data pointer left.                            | right -x                 |
| add x       | Add x to the value under the data pointer.             | No.                      |
| sub x       | Subtract x from the value under the data pointer.      | sub -x                   |
| bnz label   | Branch if the value under the data pointer is not zero | No.                      |

## Known Bugs
- Currently the toolchain will only run on a little endian machine.
