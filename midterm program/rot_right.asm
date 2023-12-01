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
;    File name: rot_right.asm
;    Language: X86, 64-bit target machine
;    Max page width: 132 columns
;    Assemble: nasm -f elf64 -o rot.o rot_right.asm

;===== Begin code area ==============================================================================================================
extern printf
global rot_right


segment .data
dataline db  "1. %1.1lf  ",0



segment .text
rot_right:

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
pushf                                             ;Backup rflags


;Back up the incoming parameter
mov r13, rdi  ;r13 is the array
mov r14, rsi  ;r14 is the count of valid numbers in the array
xor r15,r15   ;r15 is the loop counter


mov r12, r14 ;give r12 the size
dec r12     ; get last index   array.length -1 


movsd xmm1,[r13+r12*8] ;give xmm0 last value of array 


begin_loop:
cmp r12,0 ;if r12 > 0 loop is done 
jle done
mov r11, r12
dec r11     ;get array length -2 
movsd xmm10,[r13+r11*8]     ;mov arr[size-2] into xmm10
movsd [r13+r12*8] ,xmm10    ;mov xmm10 into arr[size -1 ]
dec r12 ;top down approach go to next bottom index 
jmp begin_loop          
done:

;give first index of array the last value
movsd [r13+r12*8], xmm1

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
