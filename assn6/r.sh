#!/bin/bash

# Delete some unneeded files
rm *.o
rm *.out

# Compile C++ code
g++ -c -m64 -Wall -fno-pie -no-pie -o m.o main.cpp -std=c++17

# Assemble the assembly code
nasm -f elf64 -o cT.o clockTic.asm

 nasm -f elf64 -o freq.o getfrequency.asm


# Link the object files
g++ -m64 -no-pie -o arr.out -std=c++17  freq.o m.o cT.o -fno-pie -no-pie

# Run the executable
./arr.out
