#Ellmaer, Alex, Nik, Manny
#Due; {5/8}


.data
introduction_text: .asciiz "Welcome to 21, the modified version of Black Jack!\n{Please read rules.txt for game rules!}\n"
player_choice: .asciiz "\nEnter a choice:\nEnter (1) to continue\nEnter (2) to exit\n----> "
lower_bound: .word 1
upper_bound: .word 11 #maximum value of card
player_array: .space 100 #space to put user card/values
computer_array: .space 100 #space to put the computers card/values

player_rolled: .asciiz "\nPlayer drew: "
computer_rolled: .asciiz "\nComputer drew: "
player_card_read: .asciiz "\nThe player's values: "
computer_card_read: .asciiz "\nThe computer's values: "

exit_output: .asciiz "\nThanks for playing our game!"


.text 
.globl main
main:
	#print the introdcution and take the user_choice
	li $v0, 4
	la $a0, introduction_text
	syscall 
	main_2:
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
	la $s1, player_array    #$s1 will be a global variable holding the address of the player_array
	la $s2, computer_array  #$s2 will be a global variable holding the address of the computer_array
	li $a3, 0 				#will hold the loop counter for specific parts of MAIN_LOOP & other parts
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

		#DISPLAY CARD JUST DRAWN
		li $v0, 4
		la $a0, player_rolled
		syscall
		li $v0, 1
		move $a0, $t1
		syscall

		#STORE PLAYER HAND TO PLAYER ARRAY
		#call append array
		addiu $sp, $sp, -16
		sw $t1, 0($sp) #value to store
		sw $s1, 4($sp) #player array
		sw $ra, 8($sp)
		jal append_to_array
		lw $ra, 8($sp)
		addiu $sp, $sp, 16

		#CREATE COMPUTER HAND
		#call rand int
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

		#DISPLAY CARD JUST DRAWN
		li $v0, 4
		la $a0, computer_rolled
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		
		#STORE PLAYER HAND TO PLAYER ARRAY
		#call append array
		addiu $sp, $sp, -16
		sw $t1, 0($sp) #value to store
		sw $s2, 4($sp) #player array
		sw $ra, 8($sp)
		jal append_to_array
		lw $ra, 8($sp)
		addiu $sp, $sp, 16
		
		addi $a3, $a3, 1
		blt $a3, 2, MAIN_LOOP #MAIN_LOOP WILL HAPPEN AT LEAST 2x
		
		# AT THIS POINT EACH PLAYER HAS ONE CARD, DRAW AGAIN AND THEN CHECK TOTALS
		#DISPLAY THE ENTIRE ARRAY (player)
		li $v0, 4
		la $a0, player_card_read
		syscall
		#call displayarray
		addiu $sp, $sp, -16
		sw $s1, 0($sp)
		sw $ra, 4($sp)
		jal display_array
		lw $ra, 4($sp)
		addiu $sp, $sp, -16
		
		#DISPLAY THE ENTIRE ARRAY (computer)
		li $v0, 4
		la $a0, player_card_read
		syscall
		#call displayarray
		addiu $sp, $sp, -16
		sw $s2, 0($sp)
		sw $ra, 4($sp)
		jal display_array
		lw $ra, 4($sp)
		addiu $sp, $sp, -16

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
