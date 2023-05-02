#Ellmaer, Alex, Nik, Manny
#Due; {5/8}


.data
introduction_text: .asciiz "Welcome to 21, the modified version of Black Jack!\n{Please read rules.txt for game rules!}"
lower_bound: .word 1 #minimum value of a card 
upper_bound: .word 13 #maximum value of card
player_array: .space 100
computer_array: .space 100
player_card_read: .asciiz "The player"


.text 
.globl main
main:
	#print the introdcution
	li $v0, 4
	la $a0, introduction_text
	syscall 

	#CREATE GAME LOGIC


	#CREATE PLAYER HAND




	#CREATE COMPUTER HAND



	done:
	#TERMINATE THE PRORGAM
    li $v0, 10
    syscall


