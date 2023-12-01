global fill_random_array
extern printf

segment .data

print db "r13 is %d r14 is %d",0
print2 db "the nu222m is %d",0

output_format db "Random Number: 0x%016lx", 10, 0  ; Format string for printf

segment .bss


segment .text


fill_random_array:
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


;when r14 and r13 are equal that means the first iteration of random nums have been generated
cmp r13, r14
;jump to second iteration of random nums 
je fill_again

;if they are not equal that means r13 holds some random value
;zero out r13 and proceed with initial random generation
xor r13,r13

loop:
;loop condition
cmp r13,r14
jge done

;put random num into rax
rdrand rax

;move random number into array
mov r12, rax
mov [r15 + r13*8], r12
;debbug
;mov rdi, print 
;mov rsi, [r15 + r13*8] 
;call printf
inc r13
jmp loop



fill_again:
xor rcx, rcx


loop_with_range:
cmp rcx, r13
jge done

;;; normalize code goes here
inc rcx


jmp loop_with_range

done:

mov rax, r13


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