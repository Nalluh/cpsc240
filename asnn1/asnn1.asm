;CPSC 240-01
; Allan Cortes
; CWID 889755740
;Assignment 1 




extern printf                                               ;External C++ function for writing to standard output device

extern scanf                                                ;External C++ function for reading from the standard input device

global trip_info                                            

;total_distance equ 0x4053E00000000000     

segment .data                                               ;Place initialized data here


firstMessage db "Please enter the speed for the initial segment of the trip(mph):", 0

secondMessage db "For how many miles will you maintain this average speed? ", 0

thirdMessage db "What will be your speed during the final segment of the trip(mph)? ", 0

fourthMessage db "",0ah,"Your average speed will be %1.02lf mph", 10, 0

fifthMessage db "The total travel time will be %1.02lf hours", 10, 0


stringformat db "%s", 0                                     ;general string format

invalid_input db "An invalid speed was entered. Please run the program again and enter correct data.", 0ah,"Your average speed was not calculated.", 0ah,"The total travel time was not calculated." , 10 ,0 


invalid_input_miiles db "An invalid amount of miles was entered. Please run the program again and enter correct data." , 10 ,0 

eight_byte_format db "%lf", 0                               ;general 8-byte float format

total_distance dq 253.5

segment .bss                                                ;Place un-initialized data here.



segment .text                                               

trip_info:                                          ;Entry point.  Execution begins here.

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
pushf                                                       ;Back up rflags



startapplication: 

;Show the first message (From c++ and message asking for initial speed)
push qword 0                                                
mov qword  rax, 0                                           
mov        rdi, stringformat                                
mov        rsi, firstMessage        ; show first message asking for first leg of trip speed                       
call       printf                                                         



;Obtain value for intial segment 
push qword 0                                                
mov qword  rax, 0                                           
mov        rdi, eight_byte_format                           
mov        rsi, rsp                                         
call       scanf                                            
movsd      xmm9, [rsp]           ; get value of first leg trip speed and insert it into xmm9                           
pop        rax


xorpd xmm15, xmm15    ;xmm15 = 0
ucomisd xmm9,xmm15    ; if xmm9 (which is first input) is less than xmm15 (zero) 
jb neg                ; that means xmm9 is negative
                      ; when xmm9 is negative skip code and jump below to block that starts with neg


;Show the second message (For how many miles ?)
push qword 0                                                
mov qword  rax, 0                                           
mov        rdi, stringformat                                
mov        rsi, secondMessage                   ; show second message asking for the distance so far                   
call       printf  
pop rax  

;Obtain value for how many miles
push qword 0                                                
mov qword  rax, 0                                           
mov        rdi, eight_byte_format                           
mov        rsi, rsp                                         
call       scanf                                            
movsd      xmm10, [rsp]                 ;get value of distance and place it in xmm10                     
pop        rax

movsd xmm13, qword[total_distance]  ;assign 253.5 to xmm13
ucomisd xmm13, xmm10                ; check if input is greater than 253.5
jb tooManyMiles                     ; if input is greater move to tooManyMiles block

;Show the third message (speed for final segment): 
push qword 0                                                
mov qword  rax, 0                                           
mov        rdi, stringformat                                
mov        rsi, thirdMessage                                ; show third message asking for final speed of second leg of trip         
call       printf  
pop rax  

;Obtain a final segment value 
push qword 0                                               
mov qword  rax, 0                                          
mov        rdi, eight_byte_format                          
mov        rsi, rsp                                         
call       scanf                                            
movsd      xmm11, [rsp]               ; get value of speed from second leg                       

xorpd xmm15, xmm15          ;xmm15 =0
ucomisd xmm11,xmm15         ; if xmm11 is negative it jump below to neg2
jb neg2                     ; else continue with math 


;calculates total hours on drive 
movsd xmm0, xmm10 ;copy second value aka 107.4 xmm0 = 107.4
divsd xmm10, xmm9 ;1.48 value   xmm10 = 107.4/72.5                      Second input / first input 
movsd xmm1, qword[total_distance] ; xmm1 = 253.5                        put the total distance into xmm1
subsd xmm1, xmm0 ; give length of second leg  xmm1 = 253.5 - 107.4      subtract total distance by first distance to get remaining distance
divsd xmm1, xmm11 ; 1.65    xmm1 = xmm1 / xmm11 = 146.4 / 88.5          Get time for second lef of tri
addsd xmm10,xmm1 ; Total hours of travel 3.13 xmm10 = 1.48 + 1.65        Add first leg and second leg times  `````total hours values ``````
movsd xmm2, qword[total_distance]  ; xmm2 = 253.5                       copy total distance once again
divsd xmm2,xmm10 ; xmm2 = 253.5 / 3.13                                   divide total distance by total time spent riding to get mph `````avg speed value``````

mov rdi, fourthMessage
movsd xmm0, xmm2 ; this will return avg speed 
call printf

mov rdi, fifthMessage
movsd xmm0, xmm10 ; this will return hours of trip
call printf



pop rax

jmp continue ;when values are valid skip neg blocks 

neg:            ;when xmm9 is negative code will print message stating to try again with valid input
mov rax, 0
mov rdi, invalid_input
movsd xmm10, qword[total_distance]            ;move 253.5 into xmm10 because we use xmm10 to return to c++ file
call printf
jmp continue   ;this jmp is here to skip the neg2 block
                ; neg2 is for validating third input 
                ;cannot use same neg block for third input
                ;because we will seg fault for not popping rax
                ;we cannot pop rax in this block because when xmm9 is negative
                ; we skip the push that we are popping 


tooManyMiles:
mov rax, 0
mov rdi, invalid_input_miiles ;this block is activated when miles input is greater than 253.5
movsd xmm10, qword[total_distance]            ;move 253.5 into xmm10 because we use xmm10 to return to c++ file
call printf
jmp continue                 ;we jmp to continue to avoid neg2 block and the seg fault 



neg2:                       ;this block is for third input 
mov rax, 0                  
mov rdi, invalid_input
movsd xmm10, qword[total_distance]          ;move 253.5 into xmm10 because we use xmm10 to return to c++ file
call printf
pop rax
continue:


; second input / first input = Time of first leg     1 
; total_distance - second input = second length      2
; second length / third input  = time of second leg  3

; HoT = 1 + 3 (hours on trip)
; avg speed = total_distance / Hot







pop        r14                                             


setreturnvalue:
push       r14                                              
movsd      xmm0, xmm10     ; return value to c++ file                                 
pop        r14                                              

;Restore the original values to the GPRs
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