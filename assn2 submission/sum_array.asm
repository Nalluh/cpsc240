;This program takes values in an array and sums them together 



global sum_array
extern printf 

segment .data

segment .bss 


segment .text
sum_array:

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

mov r13, rdi    ;arrayA
mov r14, rsi    ;arrayB
mov r12, rdx    ;size of arrayA
mov r11, r12    ;copy of size
sub r11, 1      ;subtract 1 from size to access address of last float
mov r15, 0      ;counter

beginLoop:
    cmp r15, r12
    je exitLoop
    movsd xmm10, [r13 + 8*r11]
    movsd [r14 + 8*r15], xmm10
    inc r15
    dec r11
    jmp beginLoop

exitLoop:









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