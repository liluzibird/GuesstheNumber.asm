;--------------------------------------------------------------
;CMPR 154 - Fall 2023
;Team Name: Death Eaters
;Team Member Names: Genesis Bejarano, Guadalupe Roman Sanchez, Albert H, Abby 
;Creation Date: 
;Collaboration: 
;
;--------------------------------------------------------------

INCLUDE Irvine32.inc

.data
mainMenu BYTE "*** Death Eaters ***",0dh, 0ah, 0dh, 0ah, 0dh, 0ah,
			  "*** MAIN MENU ***",0dh, 0ah, 0dh, 0ah,
			  "Please Select one of the following:",0dh, 0ah, 0dh, 0ah,
			  "	1: Display my available credit",0dh, 0ah,
			  "	2: Add credits to my account",0dh, 0ah,
			  "	3: Play the guessing game",0dh, 0ah,
			  "	4: Display my statistics",0dh, 0ah,
			  "	5: To exit",0dh, 0ah,
			  "Choice -->",0dh, 0ah,
choice DWORD ?
choiceOne DWORD 1
choiceTwo DWORD 2
choiceThree DWORD 3
choiceFour DWORD 4
choiceFive DWORD 5

.code
main PROC
	

	mov edx,OFFSET mainMenu     ;calling the main menu
	call WriteString

read:	call ReadInt     ;grabbing input from the user
	mov choice, eax




;choice 1: displaying the available credit
	;mov eax choice

;choice 2: Add credits to my account


;choice 3: Play the guessing game


;choice 4: Display my statistics


;choice 5: To exit


exit

main endp
end main