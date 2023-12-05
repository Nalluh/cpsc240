;Author: Floyd Holliday
;Library program name: Get Processor Frequency
;Purpose: Extract the CPU max speed from the processor

;Prototype:  double getfreq()

;Translation: nasm -f elf64 -o freq.o getfrequency.asm

global getfrequency

extern atof

segment .data

segment .bss

segment .text
getfrequency:

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

;Extract data from processor in the form of two 4-byte strings
mov rax, 0x0000000080000004
cpuid
;Answer is in ebx:eax as big endian strings
mov       r15, rbx      ;Second part of string saved in r15
mov       r14, rax      ;First part of string saved in r14


;Catenate the two short strings into one 8-byte string in big endian
and r15, 0x00000000000000FF    ;Convert non-numeric chars to nulls
shl r15, 32
or r15, r14                    ;Combined string is in r15


;Convert string to quadword numeric double.
push r15
mov rax,1
mov rdi,rsp
call atof          ;The number is now in xmm0
pop rax


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

ret