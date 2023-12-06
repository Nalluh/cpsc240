global sqroot

extern printf,scanf


segment .data
;0x%016lx 
Number_prompt db "Number is 0x%016lx  ",0ah,0
sqroot_prompt db "Sqrt is 0x%016lx  ",0ah,0
clock_before_prompt db "Clock time before the computation  is %lld tics",0ah,0
clock_after_prompt db "Clock time after the computation  is %lld tics",0ah,0
time_req_prompt db "Time required for computation is %lld tics",0ah, 0  
cpu_num_user_prompt db "Please enter the max frequency of your CPU (GHz): ",0
execution_prompt db 0ah, "The execution time is %d nanosec",0ah,0,10
invalid_prompt db "Invalid number found.  Get another.",0ah,0
eight_byte_format db "%d",0



segment .bss
segment .text





sqroot:
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

start:
;creates random value put it in r15
rdrand rax
mov r15, rax

;print value
mov rax, 0
mov rdi, Number_prompt
mov rsi, r15
call printf

;if value is less than 0 its negative 
cmp r15, 0
jl isNeg

;skip if not neg
jmp cont

;print that its neg and find another
isNeg:
mov rax, 0
mov rdi, invalid_prompt
call printf
jmp start

cont:
;doesnt do anytthing i guess suppossed to convert to float but does not ahahhahahahahahahahahahahahahahahahahhahahahahahahahahahahahahahahahahhahahahahahahahahahahahahahahahahhahahahahahahahahahahahahahahahahhahahahahahahahahahahahahahah
cvtsi2sd xmm11, r15 

;calculate tics
xor rdx, rdx
xor rax, rax
Cpuid 
Rdtsc 
shl rdx, 32
add rdx, rax
mov r13, rdx

;operation
sqrtsd xmm14,xmm11

;calculate tics
xor rdx, rdx
xor rax, rax
Cpuid 
Rdtsc 
shl rdx, 32
add rdx, rax
mov r14, rdx

;print sqrt value
mov rax, 0
mov rdi, sqroot_prompt
movsd xmm13, xmm14
call printf

;tics before
mov rax, 0
mov rdi, clock_before_prompt
mov rsi, r13
call printf

;tics after
mov rax, 0
mov rdi, clock_after_prompt
mov rsi, r14
call printf

;find tic difference
sub r14,r13

;print the difference
mov rax, 0
mov rdi, time_req_prompt
mov rsi, r14
call printf

;get cpu num from user
mov rax, 0
mov rdi, cpu_num_user_prompt
call printf

                                       
mov qword  rax, 0                                           
mov        rdi, eight_byte_format                           
mov        rsi, rsp                                         
call       scanf                                            
mov     r13, [rsp]                          


;divide tics by user num
mov rax, r14       
mov rdx, 0         
mov rbx, r13      
div rbx            

mov r11, rax
mov r10,r11

;print out value
mov rax, 0
mov rdi, execution_prompt
mov rsi, r11
call printf

;calculation again to send to c++
mov rax, r14       
mov rdx, 0         
mov rbx, r13      
div rbx            

;idk if its my computer or what but i cannot convert r14 to float cvtsi2sd does nothing. so value is int 

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