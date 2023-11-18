;--------------------------------------------------------------
;CMPR 154 - Fall 2023
;Team Name: Death Eaters
;Team Member Names: Genesis Bejarano, Guadalupe Roman Sanchez, Albert H, Abby 
;Creation Date: 
;Collaboration: 
;
;--------------------------------------------------------------
 
INCLUDE Irvine32.inc

.data  ; VARIABLES FOR THIS PROJECT!!

mainMenu BYTE "*** Death Eaters ***",0dh, 0ah, 0dh, 0ah, 0dh, 0ah,
			  "*** MAIN MENU ***",0dh, 0ah, 0dh, 0ah,
			  "Please Select one of the following: ",0dh, 0ah, 0dh, 0ah,
			  "	1: Display my available credit ",0dh, 0ah,
			  "	2: Add credits to my account ",0dh, 0ah,
			  "	3: Play the guessing game ",0dh, 0ah,
			  "	4: Display my statistics ",0dh, 0ah,
			  "	5: To exit",0dh, 0ah,
			  "	Choice : ",0

displayMaxError BYTE "=> ERROR: Maximum allowable credit is $20.00. TRY AGAIN!",0

				  
menuOpt1 BYTE "=> Your available balance is : $",0
menuOpt2 BYTE "=> Please enter the amount you would like to add : $",0

balance WORD 0		; initlize the balance to 0 
MAXB	WORD 20		; max credit is 20 
amount  WORD 0		; User's input 
countGuesses WORD 0 ; user's total of guesses

menuChoice WORD ? 	; 


menuERROR BYTE "ERROR: Invalid Input must be from 1-5. TRY AGAIN! ", 0 

 
.code
main PROC

read: 
	call clrscr  ; 

	mov edx,OFFSET mainMenu     ; calling the main menu
	call WriteString			; displays the main menu

	;;;;;;;;;;;;;;   validate user input  menuChoice       ;;;;;;;;;;;;;;;;;;;

	call ReadInt				; Now we need to read the user input 
	cmp ax, 1
	jl badInput						
	cmp ax, 5
	ja badInput					; 
	jno goodInput				; validates it 

	;; if (user input == 1 ) ;;
	cmp ax, 1
	je option1					;  jump to option 1


	cmp ax, 2
	je option2					; jump to option 2


	cmp ax, 3
	je option3




badInput: 
	mov edx, OFFSET menuERROR	; display ERROR 
	call WriteString 
	mov eax, 1500				; delay 3 seconds 
	call Delay
	jmp read					; go input again

goodInput:
	mov menuChoice, ax			; store good value

	;;; move the balance to the registerr   ;;; 
	;;; some how jump to option1            ;;;


	COMMENT !

				WRITE THE OPTIONS 1-5 UNDER THIS COMMENT BLOCK

	!


option1: 
	call Clrscr
	mov edx,OFFSET menuOpt1     ;calling the main menu
	call WriteString
	mov ax, balance				;
	call WriteDec				

option2:
	call Clrscr
	mov edx,OFFSET menuOpt2    ;calling the main menu
	call WriteString
	
	call ReadDec              ;grabbing user input

	;;NEED TO FIGURE OUT HOW TO ADD USE INPUT INTO BALANCE;;
	;add balance, eax

	cmp ax, 20				  ;input validation
	ja aboveTwenty

aboveTwenty:
	mov edx, OFFSET displayMaxError	; display ERROR 
	call WriteString 
	mov ax, 2000				; delay 2 seconds 
	call Delay
	jmp option2					; go input again

option3:





option4:





option5: 


exit

main endp
end main