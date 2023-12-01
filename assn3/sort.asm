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
;    File name: sort.asm
;    Language: X86, 64-bit target machine
;    Max page width: 132 columns
;    Assemble: nasm -f elf64 -o sort.o sort.asm

;===== Begin code area ==============================================================================================================
global sort
extern printf
segment .data
segment .bss
align 64
storedata resb 832
segment .text


sort:
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


;bubble sort in cpp
;Void bubbleSort(int arr[], int n)
;{
;   int i, j;
;  for (i = 0; i < n -1 ; i++) {
;       for (j = 0; j < n - i - 1; j++) {
;           if (arr[j] > arr[j + 1]) {
;               swap(arr[j], arr[j + 1]);
                ; temp = arr[j]
                ; arr[j] = arr[j+1]
                ; arr[j+1] = temp
;           }
;       }
;
;      
;  }
;}
;Back up the incoming parameter
mov r14, rdi  ;r13 is the array
mov r15, rsi  ;r14 is the count of valid numbers in the array
xor r13,r13 ;r13 is i loop counter
xor r12,r12 ;r12 is j loop parameter
mov rcx, 0  ;rcx is j counter



outer_loop:     ;  for (i = 0; i < n -1 ; i++) 

cmp r13,r15 ;i < n , r13 =i
jge done     ;if r13 is greater than or equal to r15 exit loop
    
;j counter limit    
mov r12, rsi    ;r12 = n
dec r12         ;r12 = n-1
sub r12,r13     ;r12 = n - i - 1

inner_loop: ;for (int j = 0; j < n - i - 1; j++) 

;j < n - i - 1 
cmp rcx, r12 ;rcx = j , r12 = n - i - 1
;if rcx >= r12 we have compared all the values and need to move i++
jge next_outer 

;else move on to swapping 
mov r11, [r14 + rcx*8] ;*arr[j]
mov r10, [r14 + rcx*8+8] ;*arr[j]

;dereference pointers and get values
movsd xmm15, [r11]      ; arr[j]
movsd xmm14, [r10]       ; arr[j+1] 


;if (arr[j]  > arr[j + 1]
ucomisd xmm15,xmm14 ;compare 
jbe next_inner      ; if xmm15 is less than or equal to xmm14 go to next j++

;if xmm15 greater than xmm14 -- swap
movsd xmm13, xmm15  ; temp = arr[j]
movsd xmm15, xmm14  ; arr[j] = arr[j+1]
movsd xmm14, xmm13  ;arr[j+1] = temp

;load values back to registers for array
movsd [r11],xmm15   
movsd [r10],xmm14

;load pointers back into original array  
mov [r14 + rcx*8], r11
mov [r14 + rcx*8+8], r10

;once the swap has occured
;increment j for next index
jmp next_inner 

next_inner:
inc rcx ;j++
jmp inner_loop

next_outer:
inc r13 ;i++
mov rcx, 0      ;reset inner loop for next iteration
jmp outer_loop


done:

; restore the original values using xrstor 
mov rax, 7
mov rdx, 0
xrstor [storedata]

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
