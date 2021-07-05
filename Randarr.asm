TITLE Randarr     (Randarr.asm)

; Author: Jawad Alamgir
; Description: CS271 Program 4
; Date: 08/04/2020
; Description:  Program accepts integer input in the range 10-200 and then generates as many random numbers and
;               displays them. It then sorts the numbers(in descending order) and finds the median and prints
;               both

INCLUDE Irvine32.inc

MIN equ 10
MAX equ 200
LO equ 100
HI equ 999

.data

;intro
intro_prompt           BYTE   "Welcome to Ranarr.asm. My name is Jawad Alamgir.", 0
instruct_prompt        BYTE   "This program takes integer input(range 10-200) and generates random numbers and then displays them."
                       BYTE   "It then calculates the median and sorts the numbers and diplays both.", 0

;get input
input_prompt           BYTE   "Please enter a number in the range 10-200 ", 0
invalid_input          BYTE   "Invalid input", 0
user_num               DWORD   ?

;formatting
spaces                 BYTE   "     ", 0
line_counter           DWORD   1           ;counter for newline

;print
unsorted_prompt        BYTE   "Unsorted numbers: ", 0
sorted_prompt          BYTE   "Sorted numbers:", 0
median_prompt          BYTE   "median: ", 0
unsorted_prompt2       BYTE   "The unsorted random numbers:", 0

;array
array_capacity         DWORD   MAX DUP(?)   ;MAX capacity of array
array_size             DWORD   ?            ;number of elements in array
range                  DWORD   ?


.code

main PROC
   call       Randomize               ;seed
   call       intro
   ;get user input and validate it
   push       OFFSET input_prompt
   push       OFFSET invalid_input
   push       OFFSET user_num
   call       get_info
   ;generate random numbers and fill array with them
   push       OFFSET range
   push       user_num
   push       OFFSET array_capacity
   push       OFFSET array_size
   call       rand_num_gen
   ;print unsorted numbers
   push       OFFSET unsorted_prompt
   push       OFFSET array_capacity
   push       array_size
   call       print_array
   ;sort array
   push       OFFSET array_capacity
   push       array_size
   call       desc_sort
   ;print sorted numbers
   push       OFFSET sorted_prompt
   push       OFFSET array_capacity
   push       array_size
   call       print_array
   ;median
   push       OFFSET median_prompt
   push       OFFSET array_capacity
   push       array_size
   call       calc_median
   exit
main ENDP


;Gives the introduction and instructions
intro PROC
   mov    edx, OFFSET intro_prompt
   call   WriteString
   call   CrLf
   mov    edx, OFFSET instruct_prompt
   call   WriteString
   call   CrLf
   call   CrLf
   ret
intro ENDP


;takes input from user and validates it(parameters = user_num, input_prompt, invalid_input)
get_info PROC
   push   ebp
   mov    ebp, esp
get_input:
   mov    edx, OFFSET input_prompt                           ;input_prompt
   call   WriteString
   call   ReadInt
   mov    [ebp+8], eax                           ;user_num
   call   CrLf
   ;validation
   cmp     eax, min
   jl      validation_fail
   cmp     eax, max
   jg      validation_fail
   jmp     validation_pass

validation_fail:
   mov       edx, [ebp+12]                           ;invalid_input
   call      WriteString
   call      CrLF
   jmp       get_input

validation_pass:
   mov       user_num, eax
   pop       ebp
   ret       8
get_info ENDP


;generates random numbers and stores them in an array(parameters = user_num)
rand_num_gen PROC
   push      ebp
   mov       ebp, esp
   ;range = HI-LO
   mov       eax, HI
   sub       eax, LO
   inc       eax
   mov       ebx, [ebp+20]                           ;range
   mov       [ebx], eax
   ;Generate random numbers and store them in array
   mov       ecx, [ebp+16]                           ;user_num
   mov       esi, [ebp+12]                           ;first element of array

num_gen:
   mov       ebx, [ebp+20]                           ;range adress
   mov       eax, [ebx]                               ;range value
   call      Randomrange
   add       eax, LO
   mov       [esi], eax
   add       esi, 4
   ;size+=1
   mov       ebx, [ebp+8]                           ;array_size
   mov       eax, 1
   add       [ebx], eax
   loop   num_gen
   pop       ebp
   ret       16
rand_num_gen ENDP


;prints all the elements of the array(parameters = unsorted_prompt, array_capacity, array_size)
print_array PROC
   push      ebp
   mov       ebp, esp
   ;Display array
   mov       edx, [ebp+16]
   call      WriteString
   call      CrLf
   mov       ecx, [ebp+8]                           ;array_size
   mov       esi, [ebp+12]                          ;array

newline:
   mov       eax, [esi]
   call      WriteDec
   ;Formatting
   mov       edx, OFFSET spaces
   call      WriteString
   mov       eax, line_counter
   mov       ebx, 10
   mov       edx, 0
   div       ebx
   cmp       edx, 0
   jne       no_newline
   call      CrLf

no_newline:
   add       esi, 4
   inc       line_counter
   loop      newline
   call      CrLF
   pop       ebp
   ret       12
print_array ENDP


;sorts array in descending order(parameters = unsorted_prompt, array_capacity, array_size)
desc_sort PROC
   push      ebp
   mov       ebp, esp
   mov       ecx, [ebp+8]                           ;array_size

current:
   mov       esi, [ebp+12]                           ;current_element
   mov       edx, ecx

current_greater:
   mov       eax, [esi]
   mov       ebx, [esi+4]
   cmp       ebx, eax
   jle       current_lesser
   mov       [esi], ebx
   mov       [esi+4], eax

current_lesser:
   add       esi, 4
   loop      current_greater
   mov       ecx, edx
   loop      current
   pop       ebp
   ret       8
desc_sort ENDP


;calculates median of the user input and prints it(parameters = median_prompt, array_capacity, array_size)
calc_median PROC
   push      ebp
   mov       ebp, esp
   ;even or odd
   mov       eax, [ebp + 8]                           ;array_size
   mov       edx, 0
   mov       ebx, 2
   div       ebx
   cmp       edx, 0
   je        num_even
   inc       eax
   jmp       print

num_even:
   mov       ebx, eax
   inc       ebx
   add       eax, ebx
   mov       ebx, 2
   div       ebx
   jmp       print

print:
   mov    edx, OFFSET median_prompt
   call   WriteString
   call   WriteDec
   call   CrLf
   pop       ebp
   ret       12
calc_median ENDP


END main
