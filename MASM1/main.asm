;--------------------------------------------------------------
;CMPR 154 - Fall 2023
;Team Name: Death Eaters
;Team Member Names: Genesis Bejarano, Guadalupe Roman Sanchez, Albert H, Abby, Atanacia Tany Sanchez --->OPTION 4 + counters in OPTION 3
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

option2VALID BYTE "=> Credits added to account. . . ",0


balance DWORD 0		; initlize the balance to 0 
MAXB	DWORD 20	; max credit is 20 
amount  DWORD 0		; User's input 
countGuesses DWORD 0 ; user's total of guesses

menuChoice DWORD ? 	; 


menuERROR BYTE "ERROR: Invalid Input must be from 1-5. TRY AGAIN! ", 0 

randVal DWORD 10
randomNumberMessage BYTE "Random number: ",0
displayGuessMessage BYTE "Enter your guess: ",0
displayLoseMessage BYTE "You lost!",0
displayWinMessage BYTE "Congratulations, you guessed correctly!",0

displayBrokeMessage BYTE "You need at least $1 to play.",0
displayaskPlayAgain BYTE "Do you want to play again? [y/n]",0

;OPTION 4 Variables

;Name Variables
MAX_CHARACTERS = 15
MAX_STRING = 100
username BYTE(MAX_STRING) DUP(?) ; 15 max characters plus one for null terminatior
actualSize DWORD 0 ;
inputPrompt BYTE "Enter your name (max 15 characters): ", 0
errorPrompt BYTE "ERROR:Name exceeds 15 characters or no name was entered. Try again.", 0
inputNameSuccess BYTE "Name successfully saved!",0

;DisplayStats variables

displayStatsMessage BYTE "Here are your stats ",0
displayUnderlay BYTE "------------------------",0
displayName BYTE "Name: ",0
displayAvailableCredit BYTE "Available Credit: ",0
displayGamesPlayed BYTE "Games Played: ",0
displayCorrectGuesses BYTE "Correct Guesses: ",0
displayMissedGuesses BYTE "Missed Guesses: ",0
displayMoneyWon BYTE "Money Won:$ ",0
displayMoneyLost BYTE "Money Lost:$ ",0
displayExit BYTE "Press any key to return to the main menu...",0
displayStatsEnterKey BYTE "Press any key to Display Stats....",0

;counter variables
missedGuesses DWORD 0
correctGuesses DWORD 0
gamesPlayed DWORD 0

testDisplay BYTE "TEST:I am in option 4",0

;end of option 4 variables
 
.code
main PROC

read: 
	call clrscr  ; clear screen 

	mov edx,OFFSET mainMenu     ; calling the main menu
	call WriteString			; displays the main menu

	;;;;;;;;;;;;;;   validate user input  menuChoice       ;;;;;;;;;;;;;;;;;;;

	call ReadInt				; Now we need to read the user input 
	cmp eax, 1
	jl badInput						
	cmp eax, 5
	ja badInput					
	jno goodInput				; validates it 

badInput: 
	mov edx, OFFSET menuERROR	; display ERROR 
	call WriteString 
	mov eax, 1500				; delay 3 seconds 
	call Delay
	jmp read					; go input again

goodInput:
	mov menuChoice, eax			; store good value

	
	COMMENT !

		Here we are going to check what the user inputed
		and jump to where needed. 
	!

	cmp eax, 1
	je option1					;  jump to option 1


	cmp eax, 2
	je option2					; jump to option 2

	
	cmp eax, 3 
	je option3					; jump to option 3

	
	cmp eax, 4 
	je option4					; jump to option 4
	
	cmp eax, 5 
	je option5					; jump to option 5

	COMMENT !

				WRITE THE OPTIONS 1-5 UNDER THIS COMMENT BLOCK

	!


option1: 
	call Clrscr
	mov edx,OFFSET menuOpt1     ;calling the main menu
	call WriteString
	mov eax, balance				
	call WriteDec				


	mov eax, 2000				; delay 
	call Delay

	jmp read					; go back to main menu


option2:
	call Clrscr
	mov edx,OFFSET menuOpt2    ;calling the main menu
	call WriteString
	
grabInput:

	call ReadDec               ;grabbing user input

	cmp eax, 20			       ; if ( eax <=20 )	
	jbe validAmount	

	
	mov edx, OFFSET displayMaxError		; display ERROR 
	call WriteString 
	mov eax, 1000						; delay 1 seconds 
	call Delay
	jmp option2							; go input again

validAmount:
	
	mov amount, eax				        ; get the total amount 
    add balance, eax						; add the amount into balance 

	
	mov edx, OFFSET option2VALID		; display we got their amount  
	call WriteString 
	mov eax, 1000						; delay 1 seconds 
	call Delay

	jmp read 


option3:
	;--------------Display Balance---------------------
	call Clrscr
	add gamesPlayed, 1 ;counter
	


	;------------See if have money------------------

	cmp balance, 0
	je Broke


	;---------------Take Fee---------------
	sub balance, 1						; take $1 fee from balance 

	;--------Generating Random Number-------
	mov eax,0010
	call RandomRange
	inc eax
	mov randVal,eax
	mov eax, randVal
	
	mov edx, OFFSET randomNumberMessage		; Display random number
	call WriteString 
	call WriteDec				
	call Crlf


	mov eax, 1500				; delay 3 seconds 
	call Delay


	;---------Grab user input---------------------
	mov edx, OFFSET displayGuessMessage		; display Guess message

	call WriteString 
	mov eax, 1000						; delay 1 seconds 
	call Delay
	;Grab user guess
	mov eax, 0
	call readDec

	;-----------Cmp Guess---------------

	;Comparing random value with user guess
	cmp eax, randVal
	
	;jump if equal WIN

	je Win
	add missedGuesses, 1 ; counter
	mov edx, OFFSET displayLoseMessage	; display Lose message
	 
	call WriteString 
	mov eax, 1000						; delay 1 seconds 
	call Delay

	
	;cmp with 





	jmp askPlayAgain
	jmp read					; go back to main menu


Broke:
	mov edx, OFFSET displayBrokeMessage		; display Broke message
	call WriteString 
<<<<<<< Updated upstream
	mov eax, 1000						; delay 1 second
=======
	mov eax, 1000						; delay 1 seconds 
>>>>>>> Stashed changes
	call Delay
	jmp read 

Win:
	
	add balance, 1						; add the amount into balance 

	add correctGuesses, 1 ;counter
	mov edx, OFFSET displayWinMessage	; display Win message
	call WriteString 
	mov eax, 1000						; delay 1 seconds 
	call Delay
	jmp askPlayAgain
	jmp read


askPlayAgain:
	call Crlf
	mov edx, OFFSET displayaskPlayAgain		; display play again message

	call WriteString 
	mov eax, 1000						; delay 1 seconds 
	call Delay


	;Grab user guess
	mov al, 0

	call readChar

	cmp al, 'y'			       ; if ( al = 'y' )	

	je option3

	jmp read					; go back to main menu



option4:

	call Clrscr
	
inputName:

	call Clrscr
	;prompt user to input name
	mov edx, OFFSET inputPrompt
	call WriteString

	;capture the user Name
	mov edx, OFFSET username 
	mov ecx, SIZEOF username
	call ReadString
	
	;verify input
	cmp eax, MAX_CHARACTERS 
	ja ErrorName; if above 15 characters
	cmp eax, 1
	jb ErrorName; if user enters 0 characters
	

	;if correct display name.
	mov edx, OFFSET inputNameSuccess
	call WriteString
	call Crlf
	mov eax, 1500				 
	call Delay

	;display enter message to display stats
	mov edx,OFFSET displayStatsEnterKey    
	call WriteString
	mov eax, 1500				 
	call Delay
	call ReadChar
	jmp displayStats


ErrorName:
	
	mov edx, OFFSET errorPrompt
	call WriteString
	call Crlf
	mov eax, 1500				 
	call Delay
	jmp inputName

displayStats:
	call Clrscr

	;call displayStats
	;display stats message
	mov edx,OFFSET displayStatsMessage     
	call WriteString
	call crlf

	;display underlay
	mov edx,OFFSET displayUnderlay     
	call WriteString
	call crlf

	;display name
	mov edx,OFFSET displayName     
	call WriteString
	mov edx, OFFSET username
	call WriteString
	call crlf

	;display available credit
	mov edx, OFFSET displayAvailableCredit     
	call WriteString
	mov eax, balance
	call WriteDec
	call crlf

	;display games played
	mov edx,OFFSET displayGamesPlayed
	call WriteString
	mov eax, gamesPlayed 
	call WriteDec
	call crlf

	;display correct guesses
	mov edx,OFFSET displayCorrectGuesses    
	call WriteString
	mov eax, correctGuesses
	call WriteDec
	call crlf

	;display missed guesses
	mov edx,OFFSET displayMissedGuesses  
	call WriteString
	mov eax, missedGuesses
	call WriteDec
	call crlf

	;display money won
	mov edx,OFFSET displayMoneyWon     
	call WriteString
	mov eax, correctGuesses
	mov ebx, 2
	mul ebx
	call WriteDec
	call crlf

	;display money lost
	mov edx,OFFSET displayMoneyLost     
	call WriteString
	mov eax, missedGuesses
	call WriteDec
	call crlf

	;display exit message
	mov edx,OFFSET displayExit     
	call WriteString
	mov eax, 1500				 
	call Delay
	call ReadChar				; input a character to go to main menu
	jmp read					; go back to main menu


	
option5:
	call Clrscr							; Clear Screen
	exit								; exit


exit

main endp

end main