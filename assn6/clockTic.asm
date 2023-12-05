extern printf, getfrequency

global clockTic

segment .data

intro_prompt db "The assembly module has completed the benchmarking phase." ,0ah,"Here is the report",0ah,0ah,0,10
before_push_prompt db "Time on the clock before the push instruction: %lld tics",0ah,0
after_push_prompt db "Time on the clock after the push instruction: %lld tics ",0ah,0
exection_time_prompt db "Execution time was %lld tics",0
before_add_prompt db "Time on the clock before the add instruction: %lld tics",0ah,0
after_add_prompt db "Time on the clock after the add instruction: %lld tics ",0ah,0
exit_prompt db "Now you know which instruction was faster and which was slower",0ah,"The fast execution time will be sent to the driver.",0ah,0ah,0
nano_prompt db ", which is %1.01lf ns.",0ah,0ah,10,0




segment .bss
segment .text


clockTic:
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

;intro
mov rax, 0
mov rdi, intro_prompt
call printf

;calculate tics
xor rdx, rdx
xor rax, rax
Cpuid 
Rdtsc 
shl rdx, 32
add rdx, rax
mov r13, rdx

;print tics
mov rdi, before_push_prompt
mov rsi, r13
call printf

;do push operation
push rdx
;no pop here = seg fault ( could be wrong)
pop rdx

;calculate tics again to show time passed
xor rdx, rdx
xor rax, rax
Cpuid 
Rdtsc 
shl rdx, 32
add rdx, rax
mov r14, rdx

;print tics
mov rdi, after_push_prompt
mov rsi, r14
call printf


;sub intitial with final and print to show tic diff
sub r14,r13

;get freq value
Mov rax, 1
call getfrequency
Movsd xmm15,xmm0 ;Xmm0 = freq
Cvtsi2sd xmm11, r14 
Divsd xmm11, xmm15


;print tic diff
mov rdi, exection_time_prompt
mov rsi, r14
call printf
;print nanoseconds
mov rdi, nano_prompt
movsd xmm0, xmm11
call printf

;calculate tics
xor rdx, rdx
xor rax, rax
Cpuid 
Rdtsc 
shl rdx, 32
add rdx, rax
mov r13, rdx

;print tics
mov rdi, before_add_prompt
mov rsi, r13
call printf

;add instruction
add  rbx,rcx

;calculate tics again to show time passed
xor rdx, rdx
xor rax, rax
Cpuid 
Rdtsc 
shl rdx, 32
add rdx, rax
mov r14, rdx

;print tics agaain
mov rdi, after_add_prompt
mov rsi, r14
call printf

;calculate tic diff
sub r14,r13

;get freq value
Mov rax, 1
call getfrequency
Movsd xmm15,xmm0 ;Xmm0 = freq
Cvtsi2sd xmm11, r14 
Divsd xmm11, xmm15

mov rdi, exection_time_prompt
mov rsi, r14
call printf

;not pretty to have back to back printf's
;but having them on one print statement was giving errors and i cba to fix
;this will do
mov rdi, nano_prompt
movsd xmm0, xmm11
call printf

;now you know which instr.....
mov rax, 0
mov rdi, exit_prompt
call printf

;return value to C++
mov rax, r14
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