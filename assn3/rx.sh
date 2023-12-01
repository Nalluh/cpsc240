#!/bin/bash

# Author: Allan Cortes
# CWID: 889755740

gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp 

nasm -f elf64 -o manage.o manage.asm
gcc -c -m64 -Wall -fno-pie -no-pie -o print.o print.cpp 
nasm -f elf64 -o fill.o fill_array.asm

nasm -f elf64 -o display.o display.asm

nasm -f elf64 -o sort.o sort.asm

gcc -m64 -no-pie -o sort -lstdc++ -std=c17 main.o manage.o print.o fill.o sort.o #-fno-pie -no-pie

./sort
