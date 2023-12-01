;****************************************************************************************************************************
;Program name: "Shift Numbers Right".  This program demonstrates how to shift numbers in an array to the right            *
; ascending order .Copyright (C) 2023 Allan Cortes.                                                                         *
;                                                                                                                           *
;This file is part of the software program "Basic Float Operations".                                                        *
;Basic Float Operations is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
;License version 3 as published by the Free Software Foundation.                                                            *
;Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the       *
;implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
;details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                  *
;****************************************************************************************************************************




;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;Author name: Allan Cortes
;Author email: allan.cor98@csu.fullerton.edu
;
;Program information
;   Program name: Array sort in ASM
;   Programming languages: One module in C++ and four modules in X86
;   Date program began: 2023-Oct-25
;  Date of last update: 2023-Oct-25
;  Date of reorganization of comments: 2023-Oct-25
;   Files in this program: driver.c  manage.asm, fill_array.asm, display.asm, sum_array.asm and rot_right.asm
;   Status: completed
; 
; 
;This file
;    File name: fill_array.asm
;    Language: X86, 64-bit target machine
;    Max page width: 132 columns
;    Assemble: nasm -f elf64 -o fill.o fill_array.asm

;===== Begin code area ==============================================================================================================
extern printf                                               ;External C++ function for writing to standard output device

extern scanf                                                ;External C++ function for reading from the standard input device

global fill_array

segment .data 

floatform db "%lf", 0  
one_float_format db "%lf",0
segment .bss
backuparea resb 832

segment .text                                               

fill_array:                                          ;Entry point.  Execution begins here.

;=========== Back up all the GPRs whether used in this program or not =========================================================

push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf      
push qword 0


mov r13, rdi ;array
mov r14, rsi ;max size
mov r15, 0   ;counter

beginLoop:
    cmp r15, r14                    ;compare if index is still within boundary of max size of array
    je done                         ;jump to out of loop if capacity exceeded
    push qword 0                   ;reserve space in memory
    mov rax, 1                      
    mov rdi, one_float_format     
    mov rsi, rsp                    ;point scanf to the reserved storage
    call scanf                      ;call external C++ function to read user input
    movsd xmm10, [rsp]
    ;this section starts ctrl+d checking (if ctrl+d, exit the loop)
    cdqe
    cmp rax, -1                     ;if ctrl+d is entered, rax will be filled with -1
    pop rax
    je done                         ;if rax equal to -1, jump to done to exit loop

    movsd [r13 + r15*8], xmm10
    inc r15
    jmp beginLoop

done:
pop rax

input_done:
    mov rax, r15
   
    
popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp

ret        