#!/bin/bash



rm *.o
rm *.out




nasm -f elf64 -l fp-io.lis -o fp-io.o asnn1.asm


g++ -c -m64 -Wall -o fp-io-driver.o asnn1.cpp -fno-pie -no-pie -std=c++17 -g


g++ -m64 -o fpio.out fp-io-driver.o fp-io.o -fno-pie -no-pie -std=c++17


gdb ./fpio.out


