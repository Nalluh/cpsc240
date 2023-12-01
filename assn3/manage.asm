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
;    File name: manage.asm
;    Language: X86, 64-bit target machine
;    Max page width: 132 columns
;    Assemble: nasm -f elf64 -o manage.o manage.asm

;===== Begin code area ==============================================================================================================

global director
extern cpp_display 
extern sort
index equ 10
extern printf,scanf
extern fill_array
extern display
extern fgets
extern stdin


segment .data
welcome db "This Program will sort all of your doubles",10,0
info db "Please enter floating point numbers speparated by white space, After the last numeric input enter at least one more white space and press ctrl+d",10,0
Thanks db 0ah,"Thank you. You entered these numbers",0ah , 0
EndOutPut db 0ah,"End of output of array.",0ah, "The array is now being sorted without moving any numbers.",0ah,"The data in the array are now ordered as follows",0ah,10, 0
    
   stringformat db "%s", 0                                     ;general string format
 
format_input db "Enter a name : ", 0    
format_output db "I received the name : ", 0  

segment .bss
align 64
storedata resb 832
index_total resq index
cpparray resq 2
name resb 32



segment .text

director:
;=========== Back up all the GPRs whether used in this program or not =========================================================

push rbp                                              ;Save a copy of the stack base pointer
mov  rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push rbx                                              ;Back up rbx
push rcx                                              ;Back up rcx
push rdx                                              ;Back up rdx
push rsi                                              ;Back up rsi
push rdi                                              ;Back up rdi
push r8                                               ;Back up r8
push r9                                               ;Back up r9
push r10                                              ;Back up r10
push r11                                              ;Back up r11
push r12                                              ;Back up r12
push r13                                              ;Back up r13
push r14                                              ;Back up r14
push r15                                              ;Back up r15
pushf      


;Perform a back up using xsave
mov rax, 7
mov rdx, 0
xsave [storedata]


;print out welcome text
;This program will sort all of y.....
mov rax, 0
mov rdi, welcome
call printf

;***********************************************************************************************************
mov rax, 0
mov rdi, stringformat
mov rsi, format_input
call printf


mov qword rax, 0                                           
mov       rdi, name                 
mov       rsi, 32                                           
mov       rdx, [stdin]                                      
call      fgets        
;***********************************************************************************************************



mov rax, 0
mov rdi, stringformat
mov rsi, format_output
call printf

mov        rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, name                         ;Place a pointer to the programmer's name in rsi
call       printf     


;print out info text
;Please enter floating point numbers seperat.....
mov rax, 0
mov rdi, info
call printf

;block gives index number and size 
;then calls fill_array to populate array
mov rax, 0 
mov rdi, index_total
mov rsi, index
call fill_array    
mov  rbx, rax

;print out thank you text
;Thank you. you entered these......
mov rax, 0
mov rdi, Thanks    
call printf


; block gives index count and array pointer
; then display is called upon to show the array elements 
mov rax, 0
mov rdi, index_total
mov rsi, rbx
call cpp_display


;print out End of output text
;End of output array. The array is now........
mov rax, 0
mov rdi, EndOutPut    
call printf

; block gives index count and array pointer
; then call sort to sort the array
mov rax, 0 
mov rdi, index_total
mov rsi, rbx
call sort

; block gives index count and array pointer
; then display is called upon to show the array elements 
mov rax, 0
mov rdi, index_total
mov rsi, rbx
call cpp_display



;***********************************************************************************************************
mov        rax, 0                                         
mov        rdi, stringformat                              
mov        rsi, name                      
call       printf     
;***********************************************************************************************************



;block moves array count and array address into cpparray variable
mov [cpparray], rbx     ;cpparray[0] = r13 aka the address
mov r11, index_total    ;r12 = index_total which is array count
mov [cpparray +8], r11  ;cpparray[1] = array count





; restore the original values using xrstor 
mov rax, 7
mov rdx, 0
xrstor [storedata]

;send to main.cpp the array that contains the count and the address of the array with values 
mov rax, cpparray
    
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
 

