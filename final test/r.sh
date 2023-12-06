#!/bin/bash

# Delete some unneeded files
rm *.o
rm *.out

# Compile C++ code
g++ -c -m64 -Wall -fno-pie -no-pie -o m.o main.cpp -std=c++17

# Assemble the assembly code
nasm -f elf64 -o e.o executive.asm

# Link the object files
g++ -m64 -no-pie -o arr.out -std=c++17   e.o m.o -fno-pie -no-pie

# Run the executable
./arr.out
