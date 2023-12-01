
;****************************************************************************************************************************
;Program name: "Ampere".  This program calculates work of electricity           *
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
;   Program name: Ampere
;   Programming languages: One module in C++ and four modules in X86
;   Date program began: 2023-Nov-10
;  Date of last update: 2023-Nov-10
;  Date of reorganization of comments: 2023-Nov-10
;   Files in this program: ampere.cpp, farady.asm, isfloat.asm
;   File isfloat.asm was produced by prof Holliday all credit to him 
;   Status: completed
; 
;This file
;    File name: faraday.asm
;    Language: X86, 64-bit target machine
;    Max page width: 132 columns
;    Assemble: nasm -f elf64 -o f.o faraday.asm

;===== Begin code area ==============================================================================================================
extern printf,  scanf ,fgets, stdin , strlen , atof, isfloat                                 ;External C++ function for writing to standard output device

global faraday
  
maxInput equ 64

segment .data                                               ;Place initialized data here

name_prompt db "Please enter your name: " , 0
title_prompt db "Please enter your title or profession: " ,0
welcome_prompt db "We always welcome a %s to our electrical lab.",10 ,0
voltage_prompt db 0ah,"Please enter the volatage of the electrical system at your site (volts): ",0
electrical_prompt db "Please enter the electrical resistance in the system at your site (ohms): ",0
time_prompt db "Please enter the time your system was operating (seconds): " ,0
invlaid_prompt db 0ah,"Attention %s. Invlaid inputs have been encountered. Please run the program again.",10,0
answer_prompt db 0ah,"Thank you %s." ,0
answer_cont_prompt db " We at Majestic are pleased to inform you that your system performed %.02f joules of work." , 0
congradulations_prompt db 0ah,0ah,"Congratulations %s. Come back any time and make use of our software.", 0ah,"Everyone with title %s is welcome to use our programs at a reduced price.",10,0


stringformat db "%s", 0   
eight_byte_format db "%lf", 0                              

segment .bss                                                

usersName resb 32
usersProfession resb 32
num resb maxInput
segment .text                                               

faraday:                                          ;Entry point.  Execution begins here.

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
pushf                                                       ;Back up rflags



;ask for name
mov rax, 0 
mov rdi, name_prompt
call printf


;----------------
;gets name
mov rax, 0
mov rdi, usersName
mov       rsi, maxInput                                         
mov       rdx, [stdin]                                      
call      fgets    

;format name input to remove \n
mov rax, 0
mov rdi, usersName
call strlen
mov byte[usersName +rax -1 ],byte 0

;asks for title
mov rax, 0 
mov rdi, title_prompt
call printf

;----------------
;gets title
mov rax, 0
mov rdi, usersProfession
mov       rsi, maxInput                                         
mov       rdx, [stdin]                                      
call      fgets  

;formats title input to remove \n
mov rax, 0
mov rdi, usersProfession
call strlen
mov byte[usersProfession +rax -1 ],byte 0

;print
;We always welcome  a _____ to our lab 
mov rax, 0 
mov rdi, welcome_prompt
mov rsi, usersProfession
call printf



;this entire block will handle the number input and verification of correct float for the first input
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;print
;Please enter the volatage....
mov rax, 0 
mov rdi, voltage_prompt
call printf

;get input
mov rax, 0
mov rdi, num
mov rsi, maxInput
mov rdx, [stdin]
call fgets

;formats input to remove \n
mov rax, 0
mov rdi, num
call strlen
mov byte [num + rax-1], byte 0

;check if a float
mov rax, 0
mov rdi, num
call isfloat                    

; if rax contains 0 (false) -> invalid 
cmp rax, 0
je invalid

;mov to xmm
mov rax, 0
mov rdi, num
call atof    
movsd xmm15, xmm0 
;--------------------------------------------------------------------------------------------------------------



;this entire block will handle the number input and verification of correct float for the second input
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;print
;Please enter the resistance....
mov rax, 0 
mov rdi, electrical_prompt
call printf

;get input
mov rax, 0
mov rdi, num
mov rsi, maxInput
mov rdx, [stdin]
call fgets

;formats input to remove \n
mov rax, 0
mov rdi, num
call strlen
mov byte [num + rax-1], byte 0

;check if a float
mov rax, 0
mov rdi, num
call isfloat   

; if rax contains 0 (false) -> invalid 
cmp rax, 0
je invalid

;mov to xmm
mov rax, 0
mov rdi, num
call atof    
movsd xmm14, xmm0 
;--------------------------------------------------------------------------------------------------------------



;this entire block will handle the number input and verification of correct float for the third input
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;print
;Please enter the seconds....
mov rax, 0
mov rdi, time_prompt
call printf


;get input
mov rax, 0
mov rdi, num
mov rsi, maxInput
mov rdx, [stdin]
call fgets

;formats input to remove \n
mov rax, 0
mov rdi, num
call strlen
mov byte [num + rax-1], byte 0

;check if a float
mov rax, 0
mov rdi, num
call isfloat   

; if rax contains 0 (false) -> invalid 
cmp rax, 0
je invalid

;mov to xmm
mov rax, 0
mov rdi, num
call atof    ; convert to float
movsd xmm13, xmm0 ;save in diff register bc some functions might change xmm0, save it in more stable regist
;--------------------------------------------------------------------------------------------------------------


;skip invalid condition
jmp cont

;when input is not a float prit this message
;then jump to end to skip calculation
invalid:
mov rdi, invlaid_prompt
mov rsi , usersProfession
call printf
jmp end

cont: 
;print title
mov rax, 0 
mov rdi, answer_prompt
mov rsi, usersProfession
call printf

;sqaure voltage
movsd xmm0, xmm15
mulsd xmm15,xmm0

;divide voltage by resistance
divsd xmm15, xmm14

;multiply value by seconds
mulsd xmm15,xmm13

;print calculation
mov rdi, answer_cont_prompt
movsd xmm0, xmm15
call printf

;print congrats
;Congratulations Diego de Las V......
mov rax, 0 
mov rdi, congradulations_prompt
mov rsi, usersName
mov rdx, usersProfession
call printf

;mov final value to new xmm 
;this is done because if value is not moved when user inputs invalid value
;on second or third input the first input value will be sent back to main
;avoid sending back first value xmm to main
;---- pretty much final value is in xmm15 but xmm15 also takes in first input
movsd xmm12, xmm15
end:
push       r14                                              
movsd      xmm0, xmm12   ; return value to c++ file                                 
pop        r14    
        

;Restore the original values to the GPRs
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