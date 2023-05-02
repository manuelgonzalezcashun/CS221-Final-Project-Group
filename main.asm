#Ellmaer, Alex, Nik, Manny
#Due; {5/8}


.data
introduction_text: .asciiz "Welcome to 21, the modified version of Black Jack!\n{Please read rules.txt for game rules!}\n"
player_choice: .asciiz "Enter a choice:\nEnter (1) to play\nEnter (2) to exit\n----> "
lower_bound: .word 1 #minimum value of a card 
upper_bound: .word 11 #maximum value of card
player_array: .space 100 #space to put user card/values
computer_array: .space 100 #space to put the computers card/values
player_card_read: .asciiz "The player's values: "
computer_card_read: .asciiz "The computer's values: "

exit_output: .asciiz "Thanks for playing our game!"


.text 
.globl main
main:
	#print the introdcution and take the user_choice
	li $v0, 4
	la $a0, introduction_text
	syscall 
	li $v0, 4
	la $a0, player_choice
	syscall 
	li $v0, 5 #take user_choice 
	syscall
	move $t0, $v0 #move user_choice to $t0

	#check beginning input of the user
	beq $t0, 1, before_MAIN_LOOP
	beq $t0, 2, EXIT_GAME
	bgt $t0, 1, EXIT_GAME
	blt $t0, 2, EXIT_GAME


	before_MAIN_LOOP:
	la $s1, player_array  #$s1 will be a global variable holding the address of the player_array
	la $s2, computer_array  #$s2 will be a global variable holding the address of the computer_array
	#MAIN GAME LOOP
	MAIN_LOOP:

		#CREATE PLAYER HAND
		la $t1, lower_bound #load the address of lower_bound
		lw $t1, ($t1)	    #load the value at address lower_bound
		la $t2, upper_bound #load the address of the upper_bound
		lw $t2, ($t2)	    #load the value at address upper_bound
		#call random int
		addiu $sp, $sp, -16
		sw $t1, 0($sp)
		sw $t2, 4($sp)
		sw $ra, 8($sp)
		jal random_int
		lw $t1, 12($sp) # $t1 hold the newly generated random int
		lw $ra, 8($sp)
		addiu $sp, $sp, 16
		
		#Just to see what gets printed out, the rand_int() function works as intended 
		li $v0, 1
		la $a0, player_array($zero)
		lw $a0, ($a0)
		syscall


		


		#CREATE COMPUTER HAND



		#CHECK VALUES


		#CHECK GAME_STATE {WIN/LOSS}



	EXIT_GAME:
	li $v0, 4
	la $a0, exit_output
	syscall
	#TERMINATE THE PRORGAM
    li $v0, 10
    syscall




#Eventually add a way to check for invalid inputs and print out a generic output, making the user_restart the entire program #
