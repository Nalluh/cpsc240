#!/bin/bash

#Program: Array Management
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "Bash: The script file for Array Management has begun"

echo "Bash: Compile the main function" 
gcc -c -m64 -Wall -fno-pie -no-pie -o driver.o driver.c -std=c17
#References regarding "-no-pie" see Jorgensen, page 226.

echo "Bash: Assemble manage.asm"
nasm -f elf64 -o super.o manage.asm

echo "Bash: Assemble output_array.asm"
nasm -f elf64 -o fill.o fill_array.asm

echo "Bash: Assemble display.asm"
nasm -f elf64 -o display.o display.asm

echo "Bash: Assemble sum.asm"
nasm -f elf64 -o sum.o sum_array.asm


echo "Bash: Link the object files"
gcc -m64 -no-pie -o arr.out -std=c17 driver.o super.o fill.o display.o sum.o #-fno-pie -no-pie

echo "Bash: Run the program Integer Arithmetic:"
./arr.out

echo "The script file will terminate"

