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
;   Files in this program: main.cpp, manage.asm, fill_array.asm, display.asm, and sort.asm
;   Status: completed
; 
;This file
;    File name: display.asm
;    Language: X86, 64-bit target machine
;    Max page width: 132 columns
;    Assemble: nasm -f elf64 -o display.o display.asm

;===== Begin code area ==============================================================================================================

global display
extern printf

segment .data
dataline db  "%1.2lf",10,0


segment .bss
align 64
storedata resb 832

segment .text

display:
;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                          ;Backup rbp
mov  rbp,rsp                                      ;The base pointer now points to top of stack
push rdi                                          ;Backup rdi
push rsi                                          ;Backup rsi
push rdx                                          ;Backup rdx
push rcx                                          ;Backup rcx
push r8                                           ;Backup r8
push r9                                           ;Backup r9
push r10                                          ;Backup r10
push r11                                          ;Backup r11
push r12                                          ;Backup r12
push r13                                          ;Backup r13
push r14                                          ;Backup r14
push r15                                          ;Backup r15
push rbx                                          ;Backup rbx
pushf                    

;Perform a back up using xsave
mov         rax, 7
mov         rdx, 0
xsave       [storedata]

;Back up the incoming parameter
mov rbx, rdi  ;r13 is the array
mov r14, rsi  ;r14 is the count of valid numbers in the array


;Block to create a loop
xor r15,r15   ;r15 is the loop counter
begin_loop:
cmp r15,r14 ;if r15 == r14 array is filled jump to done
je done
mov rax,1
mov rdi,dataline       ;display values
movsd xmm0,[r13+8*r15] ;load values into xmm0
call printf
inc r15                 ;r15++
jmp begin_loop          
done:

; restore the original values using xrstor 
mov         rax, 7
mov         rdx, 0
xrstor      [storedata]

;Restore all the previously pushed registers.
popf                                    ;Restore rflags
pop rbx                                 ;Restore rbx
pop r15                                 ;Restore r15
pop r14                                 ;Restore r14
pop r13                                 ;Restore r13
pop r12                                 ;Restore r12
pop r11                                 ;Restore r11
pop r10                                 ;Restore r10
pop r9                                  ;Restore r9
pop r8                                  ;Restore r8
pop rcx                                 ;Restore rcx
pop rdx                                 ;Restore rdx
pop rsi                                 ;Restore rsi
pop rdi                                 ;Restore rdi
pop rbp                                 ;Restore rbp

ret                                     ;Pop the integer stack and jump to the address equal to the popped value.
