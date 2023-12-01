#!/bin/bash

#Program: Array Management
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out


gcc -c -m64 -Wall -fno-pie -no-pie -o driver.o driver.c -std=c17
#References regarding "-no-pie" see Jorgensen, page 226.

nasm -f elf64 -o super.o manage.asm

nasm -f elf64 -o fill.o fill_array.asm

nasm -f elf64 -o display.o display.asm

nasm -f elf64 -o sum.o sum_array.asm

nasm -f elf64 -o rot.o rot_right.asm


gcc -m64 -no-pie -o arr.out -std=c17 driver.o super.o fill.o display.o sum.o rot.o #-fno-pie -no-pie

./arr.out


