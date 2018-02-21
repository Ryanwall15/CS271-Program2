ITLE Program Template     (Project02.asm)

; Author: Ryan Wallerius
; Course / Project ID Assignment 2           Date: 4/23/17
; Description: For this assignment I must get the user's name, and ask how many Fibonacci terms
;they want to display. I need 5 spaces in between each number and after 5 numbers on each line I 
;need to go to a new line. Then I need to display a parting message with the user's name and say goodbye

INCLUDE Irvine32.inc

UPPERBOUND = 46

.data
intro			BYTE	"Hello. Welcome to my program! My name is Ryan Wallerius! ", 0
ask_username	BYTE	"What is your name? ", 0
username		BYTE    33 DUP(0)
greeting		BYTE	"Nice to meet you ", 0
greeting_1      BYTE	"!", 0
instructions	BYTE	"Please enter number of Fibonacci terms [1...46]: ", 0
terms			DWORD	?
wrong_terms		BYTE	"Your number of terms is not within the valid range. Please enter again", 0
good			BYTE	"Good", 0
passed_input	BYTE	"You wanted to display ", 0
passed_input1	BYTE	" numbers ", 0
spaces			BYTE	"     ", 0
goodbye			BYTE	"Thank you for using my program ", 0
goodbye1		BYTE	"I hope you enjoyd this program ", 0




.code
main PROC

mov edx, OFFSET intro
call WriteString
call CrLf

mov edx, OFFSET ask_username
call WriteString
mov edx, OFFSET username
mov ecx, 32
call ReadString
call CrLf

mov edx, OFFSET greeting
call WriteString
mov edx, OFFSET username
call WriteString
mov edx, OFFSET greeting_1
call WriteString
call CrLf

mov edx, OFFSET instructions
call WriteString
call ReadDec
mov terms, eax
call CrLf

;Validating user input
cmp eax, 1
JL  not_valid
cmp eax, UPPERBOUND
JG  not_valid
jbe valid

not_valid:
	mov edx, OFFSET wrong_terms
	call WriteString
	call CrLf
	mov edx, OFFSET instructions
	call WriteString
	mov edx, OFFSET terms
	call ReadDec
	mov terms, eax
	cmp eax, 1
	JL not_valid
	cmp eax, UPPERBOUND
	JG not_valid
	jbe valid
	

valid:
	mov edx, OFFSET passed_input
	call WriteString
	mov eax, terms
	call WriteDec
	mov edx, OFFSET passed_input1
	call WriteString
	call CrLf


	mov ecx, terms		;loop counter
	mov eax, 0			;prev
	mov ebx, 1			;curr
	mov edi, 1			;Picked random register I'm not using for number counter

go:
	mov edx, eax
	add edx, ebx
	mov eax, ebx
	mov ebx, edx
	call WriteDec
	mov edx, OFFSET spaces
	call WriteString
	cmp edi, 5
	JE five
	inc edi
	JNE not_five

five:
	call CrLf				;Every 5th number we need a new line
	mov	 edi, 1				;Resets counter for 5th number back down to 1
not_five:
	loop go					;Keeps the loop going

	call CrLf
	call CrLf
	mov edx, OFFSET goodbye
	call WriteString
	mov edx, OFFSET username
	call WriteString
	mov edx, OFFSET greeting_1
	call WriteString
	call CrLf
	call CrLf
	mov edx, OFFSET goodbye1
	call WriteString
	call CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
