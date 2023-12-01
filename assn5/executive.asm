extern printf,  scanf ,fgets, stdin , strlen, fill_random_array, show_array                           ;External C++ function for writing to standard output device

global randomGen

maxInput equ 64
array_size equ 100

segment .data
name_prompt db "Please enter your name: " , 0
title_prompt db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): " ,0
welcome_prompt db "Nice to meet you %s %s ",0ah,10 ,0
info_prompt db "This Program will generate 64-IEEE float numbers.",0ah,0
get_num_prompt db "How many numbers do you want. Today's limit is 100 per customer.",0
num_stored_prompt db "Your numbers have been stored in an array.  Here is that array.",0
normalize_prompt db 0ah,"The array will now be normalized to the range 1.0 to 2.0  Here is the normalized array", 0ah,10,0
print db "the num is %d",0
goodbye_prompt db 0ah,"Goodbye %s. You are welcome anytime.",0ah,10,0
eight_byte_format db "%d", 0
stringformat db "%s", 0                                     ;general string format
output_format db "Random Number: %d", 10, 0  ; Format string for printf


segment .bss 

array   resq array_size
usersName resb 32
usersProfession resb 32
segment .text




randomGen:
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
call printf


;asks for title
mov rax, 0 
mov rdi, name_prompt
call printf


;gets name
mov rax, 0
mov rdi, usersName
mov       rsi, maxInput                                         
mov       rdx, [stdin]                                      
call      fgets    

;format name input to remove \nxmm15
mov rax, 0
mov rdi, usersName
call strlen
mov byte[usersName +rax -1 ],byte 0

;asks for title
mov rax, 0 
mov rdi, title_prompt
call printf

;----------------
;gets title
mov rax, 0
mov rdi, usersProfession
mov       rsi, maxInput                                         
mov       rdx, [stdin]                                      
call      fgets  

;formats title input to remove \n
mov rax, 0
mov rdi, usersProfession
call strlen
mov byte[usersProfession +rax -1 ],byte 0

;print
;nice to mee you _______--
mov rax, 0 
mov rdi, welcome_prompt
mov rsi, usersProfession
mov rdx, usersName
call printf

;information promp
mov rax, 0
mov rdi, info_prompt
call printf

;prompt for user input
mov rax, 0
mov rdi, stringformat                                
mov rsi, get_num_prompt
call printf


;gets user input
;and is stored in r15
mov qword  rax, 0                                           
mov rdi, eight_byte_format                           
mov rsi, rsp                                         
call scanf                                            
mov r15, [rsp]                                 


mov rax, 0
mov rdi, array 
mov rsi, r15    ;size
call fill_random_array
mov r13, rax

mov rax, 0
mov rdi, num_stored_prompt
call printf

;call another function to display array
mov rax, 0
mov rdi, array
mov rsi, r13
call show_array

;prompt
mov rax, 0
mov rdi, normalize_prompt
call printf

;call another function to normalize
mov rax, 0
mov rdi, array 
mov rsi, r15    ;size
call fill_random_array
mov r13, rax

;call another function to display array
mov rax, 0
mov rdi, array
mov rsi, r13
call show_array

;tell the user goodbye
mov rax,0
mov rdi, goodbye_prompt
mov rsi, usersProfession
call printf

;load address of name so it can be used in c++
mov rax,usersName


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
