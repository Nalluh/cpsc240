#!/bin/bash


#Delete some un-needed files
rm *.o
rm *.out


gcc -c -m64 -Wall -fno-pie -no-pie -o a.o ampere.cpp -std=c17
#References regarding "-no-pie" see Jorgensen, page 226.
	
nasm -f elf64 -o f.o faraday.asm

	
nasm -f elf64 -o isf.o isfloat.asm

gcc -m64 -no-pie -o arr.out -std=c17 a.o  isf.o f.o #-fno-pie -no-pie

./arr.out


