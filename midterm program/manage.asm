;****************************************************************************************************************************
;Program name: "Shift Numbers Right".  This program demonstrates how to shift numbers in an array to the right          *
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
;This file
;    File name: manage.asm
;    Language: X86, 64-bit target machine
;    Max page width: 132 columns
;    Assemble: nasm -f elf64 -o manage.o manage.asm

;===== Begin code area ==============================================================================================================
index_total equ 10
extern printf
extern fill_array
extern display
extern rot_right
global manage_arrays
extern sum_array
extern global_value

segment .data
welcome db "We will take care of all your array needs",10,0
info db "Please enter floating point numbers speparated by ws, After the last valid input enter one more ws followed by ctrl - d.",10,0
sum db 0ah,"The sum of the numbers in the array is  %2.10lf", 10, 0
ShowArray db 0ah,"This is the array: ", 0
ArrayHere db 0ah,"Here is the array: ", 0
rotCalled db 0ah,0ah,"Function rot_right was called 1 time",0ah , 0
rotCalled3Times db 0ah,0ah,"Function rot_right was called 3 times consecutively.",0ah , 0
rotCalled2Times db 0ah,0ah,"Function rot_right was called 2 times consecutively.",0ah , 0

segment .bss
index resq index_total



segment .text
manage_arrays:
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


;prints how to run program
;Please enter float numbers speparated by ws,....
mov rax, 0
mov rdi,info
call printf


;block gives index number and size 
;then calls fill_array to populate array
mov rax,0
mov rdi,index
mov rsi,index_total
call fill_array
mov r15,rax     

;displays value in array
;This is the array:
mov rax,0
mov rdi,ShowArray
call printf


; block gives index count and array pointer
; then display is called upon to show the array elements 
mov rax,0
mov rdi,index
mov rsi,r15
call display


; block gives index count and array pointer
;then calls rot_right to shift numbers over once 
mov rax,0
mov rdi,index
mov rsi,r15
call rot_right

;display message
; function rot_right was called 1 time
mov rax,0
mov rdi,rotCalled
call printf



;displays value in array
;This is the array:
mov rax,0
mov rdi,ArrayHere
call printf

; block gives index count and array pointer
; then display is called upon to show the array elements 
mov rax,0
mov rdi,index
mov rsi,r15
call display


;********************************************************************************
;Block performs function rot_right once
mov rax,0
mov rdi,index
mov rsi,r15
call rot_right

;Block performs function rot_right twice

mov rax,0
mov rdi,index
mov rsi,r15
call rot_right

;Block performs function rot_right third time

mov rax,0
mov rdi,index
mov rsi,r15
call rot_right

;display message
; function rot_right was called 3 time
mov rax,0
mov rdi,rotCalled3Times
call printf

;********************************************************************************

mov rax,0
mov rdi,ArrayHere
call printf

; block gives index count and array pointer
; then display is called upon to show the array elements 
mov rax,0
mov rdi,index
mov rsi,r15
call display


;*******************************************************************************
;Block performs function rot_right once
mov rax,0
mov rdi,index
mov rsi,r15
call rot_right

;Block performs function rot_right twice
mov rax,0
mov rdi,index
mov rsi,r15
call rot_right

;display message
; function rot_right was called 2 times
mov rax,0
mov rdi,rotCalled2Times
call printf

;*******************************************************************************


mov rax,0
mov rdi,ArrayHere
call printf

; block gives index count and array pointer
; then display is called upon to show the array elements 
mov rax,0
mov rdi,index
mov rsi,r15
call display

;block sums the arry
call sum_array





;sends value back to C driver 
setreturnvalue:
push       r14              
movsd xmm0,xmm13
               
pop        r14   

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