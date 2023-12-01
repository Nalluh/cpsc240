#!/bin/bash

# Delete some unneeded files
rm *.o
rm *.out

# Compile C++ code
g++ -c -m64 -Wall -fno-pie -no-pie -o m.o main.cpp -std=c++17

# Assemble the assembly code
nasm -f elf64 -o e.o executive.asm

nasm -f elf64 -o fra.o fill_random_array.asm

nasm -f elf64 -o sa.o show_array.asm


# Link the object files
g++ -m64 -no-pie -o arr.out -std=c++17 sa.o fra.o m.o e.o -fno-pie -no-pie

# Run the executable
./arr.out
