#!/bin/bash
gcc -c -Wall -O2 $1.c -o $1.o;
echo "---------------------";
objdump -d -M intel_mnemonic $1.o;
