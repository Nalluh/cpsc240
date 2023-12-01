;This program takes input from a user (numbers) and stores them into an array to be used in upper tier program
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