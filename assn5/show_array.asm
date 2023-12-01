global show_array
extern printf
segment .data
header_output db 0ah,"IEEE754                 Scientific Decimal",10,0
output_format db "0x%016lx      %18.13g", 10, 0  ; Format string for printf

segment .bss
segment .text

show_array:
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

mov r14, rsi    ;user input num
mov r15, rdi    ;the array
xor r13,r13


mov rax, 0
mov rdi, header_output
call printf
loop:
;loop condition
cmp r13,r14
jge done

movsd xmm0, [r15 + r13*8]



mov rdi, output_format 
mov rsi, [r15 + r13*8]
movsd xmm10,xmm0
call printf
inc r13
jmp loop






done:









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
