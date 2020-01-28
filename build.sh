#!/bin/bash
gcc -Wall -g -o bin/nqoisc-sim simulator.c
gcc -Wall -g -o bin/nqoisc-disassembler disassembler.c
gcc -Wall -g -o bin/nqoisc-asm asm.c ../src/vector.c
