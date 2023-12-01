;****************************************************************************************************************************
;Program name: "Array sort in ASM".  This program takes in float values from a user and then rearranges them to be in       *
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
;   Date program began: 2023-Oct-01
;  Date of last update: 2023-Oct-05
;  Date of reorganization of comments: 2023-Oct-05
;   Files in this program: main.cpp, manage.asm, fill_array.asm, print.cpp, and sort.asm
;   Status: completed
; 
;This file
;    File name: fill_array.asm
;    Language: X86, 64-bit target machine
;    Max page width: 132 columns
;    Assemble: nasm -f elf64 -o fill.o fill_array.asm

;===== Begin code area ==============================================================================================================

global fill_array
extern printf
extern scanf
extern malloc
segment .data
floatform db "%lf", 0  
segment .bss
align 64
storedata resb 832

segment .text

fill_array:

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
    

;Perform a back up using xsave
mov         rax, 7
mov         rdx, 0
xsave       [storedata]

mov r14, rdi ;r14 is array
mov r15, rsi ;r15 is counter limit
xor r13,r13 ;input counter

begin:
    
    cmp r13, r15    ;loop parameter
    jge input_done  ; if counter >= size jump to input_done
    mov rdi, 8      ;make space
    call malloc     
    mov  r12, rax   
    mov  rdi, floatform ;take in float
    mov  rsi, r12       ;r12 will have input
    call scanf    
    mov [r14 + r13 * 8], r12    ;mov input into array
    cdqe               
    cmp rax, -1      ;if user enters ctrl + d
    je input_done    ;exit loop
    inc  r13         ;i++
    jmp  begin       ;take anout input

input_done:


mov         rax, 7
mov         rdx, 0
xrstor      [storedata]

mov         rax, r13 

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