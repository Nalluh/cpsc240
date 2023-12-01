; this program will take the values that were entered into the array by the user and display them to the terminal

extern printf
global display


segment .data

dataline db  "%1.10lf",10,0


segment .bss


segment .text
display:

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
pushf                                             ;Backup rflags


;Back up the incoming parameter
mov r13, rdi  ;r13 is the array
mov r14, rsi  ;r14 is the count of valid numbers in the array


;Block to create a loop
xor r15,r15   ;r15 is the loop counter
begin_loop:
cmp r15,r14 ;if r15 == r14 array is filled jump to done
je done
mov rax,1
mov rdi,dataline       ;display values
movsd xmm0,[r13+8*r15] ;load values into xmm0
call printf
inc r15                 ;r15++
jmp begin_loop          
done:


 
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
