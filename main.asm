#Ellmaer, Alex, Nik, Manny
#Due; {5/8}


.data
introduction_text: .asciiz "Welcome to 21, the modified version of Black Jack!\n{Please read rules.txt for game rules!}\n"
player_choice: .asciiz "Enter a choice:\nEnter (1) to play\nEnter (2) to exit\n----> "
lower_bound: .word 1 #minimum value of a card 
upper_bound: .word 11 #maximum value of card
player_array: .space 100 #space to put user card/values
computer_array: .space 100 #space to put the computers card/values
player_card_read: .asciiz "\nThe player's values: "
computer_card_read: .asciiz "\nThe computer's values: "
player_rolled: .asciiz "\nPlayer drew: "
comp_rolled: .asciiz "\nComputer drew: "
exit_output: .asciiz "\nThanks for playing our game!"


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
	li $t3, 0 # $t3 will be our counter for player_array
	li $t4, 0 # $t4 will be our counter for computer_array
	#MAIN GAME LOOP
	MAIN_LOOP:

		#CREATE PLAYER HAND
		li $v0, 4
		la $a0, player_rolled
		syscall
		jal ROLL_CARD
		# Store rolled number into player array
		addi $t3, $t3, 1
		sw $t1, ($s1)
		
		
		#CREATE COMPUTER HAND
		li $v0, 4
		la $a0, comp_rolled
		syscall
		jal ROLL_CARD
		# Store rolled number into comp array
		addi $t4, $t4, 1
		sw $t1, ($s2)
		b CHECK_VALUES
		
		ROLL_CARD:
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
		#li $v0, 1
		#la $a0, player_array($zero)
		#lw $a0, ($a0)
		#syscall
		
		li $v0, 1
		move $a0, $t1
		syscall
		jr $ra


		#CHECK VALUES
		CHECK_VALUES:
			DISPLAY_CARDS:
				PLAYER_DISPLAY:
				la $a0, player_card_read
				li $v0, 4
				syscall
				#We need a loop that takes in the array + array length, then loops to display the cards of the player / comp
				addiu $sp, $sp -12
				sw $t3, 0($sp)
				sw $s1, 4($sp)
				jal display_cards
				lw $ra, 8($sp)
				addiu $sp, $sp, 12
			
				COMP_DISPLAY:
				la $a0, computer_card_read
				li $v0, 4
				syscall
				#We need a loop that takes in the array + array length, then loops to display the cards of the player / comp
				addiu $sp, $sp -12
				sw $t4, 0($sp)
				sw $s2, 4($sp)
				jal display_cards
				lw $ra, 8($sp)
				addiu $sp, $sp, 12
			
		#CHECK GAME_STATE {WIN/LOSS}
		# We need a loop to go through every number in each array, add it all up, then display total.
		# We then need to check if this total goes over 21.
			# If value is 21, end game with win depending on who was checked
			# If value is less than 21, ask player if they wish to draw another (y/n)
			# If value is over 21, end game with win depeneding on who was checked
			# If computer value is less than a number [Like 16], computer will draw a card afterwards
				# Otherwise, computer will no longer draw
			# IF both computer and player choose not to draw, compare totals, end game with win depending on larger value 



	EXIT_GAME:
	li $v0, 4
	la $a0, exit_output
	syscall
	#TERMINATE THE PRORGAM
    li $v0, 10
    syscall




#Eventually add a way to check for invalid inputs and print out a generic output, making the user_restart the entire program #
