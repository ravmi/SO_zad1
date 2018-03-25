#!/bin/bash
nasm -f elf64 -o $1.o $1.asm -g;
ld --fatal-warnings -o $1 $1.o -g
