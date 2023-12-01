;Allan Cortes
;Program that calls 3 sub programs 
;First program takes in user input that will be stored into an array
;second program will add all the values in the array togther
;third program will display all the values that are present in the array 
;once all three programs are executed the sum is return to the driver 

index_total equ 9
extern printf
extern fill_array
extern display
global manage_arrays
extern sum_array
extern global_value

segment .data
welcome db "We will take care of all your array needs",10,0
info db "Please input float numbers speparated by ws, After the last number press ws followed by ctrl - d.",10,0
sum db 0ah,"The sum of the numbers in the array is  %2.10lf", 10, 0
Thanks db 0ah,"Thank you. The numbers in the array are:",0ah , 0
ThanksAgain db "Thank you for using Array Management System.",0ah , 0

segment .bss
index resq index_total
index2 resq index_total



segment .text
manage_arrays:
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

;prints welcome message 
mov rax, 0
mov rdi,welcome
call printf

;prints how to run program
mov rax, 0
mov rdi,info
call printf


;block gives index number and size 
;then calls fill_array to populate array
mov rax,0
mov rdi,index
mov rsi,index_total
call fill_array
mov r15,rax     

; thank you the numbers in the array are .....
mov rax,0
mov rdi,Thanks
call printf


; block gives index count and array pointer
; then display is called upon to show the array elements 
mov rax,0
mov rdi,index
mov rsi,r15
call display


; block gives index count and array pointer
;then calls sum_array to do the math of adding all elements 

push qword 0
mov rax, 0
mov rdi, index
mov rsi, index2
mov rdx, r15
call sum_array
pop rax


mov rax,0
mov rdi,index2
mov rsi,r15
call display

; block displays the sum of the array ... "The sum of the numbes in array ...."

mov rdi, sum
movsd xmm0,xmm10
call printf


;block displays the thank you for using array manage...
mov rax,0
mov rdi,ThanksAgain
call printf




;sends value back to C driver 
setreturnvalue:
push       r14              
movsd xmm0,xmm10
               
pop        r14   

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