#Ellmaer, Alex, Nik, Manny
#Due; {5/8}


.data
introduction_text: .asciiz "Welcome to 21, the modified version of Black Jack!\n{Please read rules.txt for game rules!}\n"
player_choice: .asciiz "\nEnter a choice:\nEnter (1) to continue\nEnter (2) to exit\n----> "
player_array: .space 100 #space to put user card/values
computer_array: .space 100 #space to put the computers card/values
continue_prompt: .asciiz "\nEnter a choice:\nEnter (1) to hit\nEnter (2) to stand\n----> "

player_card_read: .asciiz "\nThe player's values: "
computer_card_read: .asciiz "\nThe computer's values: "

player_total_output: .asciiz "\nPlayers total: "
computer_total_output: .asciiz "\nComputers total: "

exit_output: .asciiz "\nThanks for playing our game!"

player_won: .asciiz "\nCongrats, You Won!!"
computer_won: .asciiz "\nSorry, looks like you lost!"
tie_prompt: .asciiz "\nLooks like no one wins!"


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
	li $t5, 0				#players totals global variable
	li $t6, 0 				#computers totals global variable
	
	#MAIN GAME LOOP
	MAIN_LOOP:
		part_1:
			#create player hand, display the array, return the totals += to global variables
				la $t1, player_card_read
				la $t2, player_total_output
				addiu $sp, $sp, -20
				sw $s1, 0($sp)      #address of player array
				sw $t1, 4($sp) 		#address of player_card_read
				sw $t2, 8($sp)		#address of the player_total_output
				sw $ra, 12($sp)		#save the $ra
				jal big_chungus
				lw $t1, 16($sp)
				lw $ra, 12($sp)
				addiu $sp, $sp, 20
				move $t5, $t1       #save the total to the global register
				
		part_2:
			#create computer hand, display the array, return the totals += to global variables
				la $t1, computer_card_read
				la $t2, computer_total_output
				addiu $sp, $sp, -20
				sw $s2, 0($sp)      #address of computer array
				sw $t1, 4($sp) 		#address of computer_card_read
				sw $t2, 8($sp)		#address of the computer_total_output
				sw $ra, 12($sp)		#save the $ra
				jal big_chungus
				lw $t1, 16($sp)
				lw $ra, 12($sp)
				addiu $sp, $sp, 20
				move $t6, $t1       #save the total to the global register



		get_user_choice:
			li $v0, 4
			la $a0, continue_prompt
			syscall
			li $v0, 5
			syscall 

			beq $v0, 1, user_choice_1
			beq $v0, 2, user_choice_2
			bgt $v0, 1, EXIT_GAME
			blt $v0, 2, EXIT_GAME
			#ask the user (stand or hit?)
			user_choice_1: #hit
				la $t1, player_card_read
				la $t2, player_total_output
				addiu $sp, $sp, -20
				sw $s1, 0($sp)      #address of player array
				sw $t1, 4($sp) 		#address of player_card_read
				sw $t2, 8($sp)		#address of the player_total_output
				sw $ra, 12($sp)		#save the $ra
				jal big_chungus
				lw $t1, 16($sp)
				lw $ra, 12($sp)
				addiu $sp, $sp, 20
				move $t5, $t1       #save the total to the global register

				#check for bust
				bgt $t5, 21, computer_wins			#player got greedy, bust
				beq $t5, 21, player_wins			#player got lucky
				
				b get_user_choice


			user_choice_2: #stand (hit only when < 16)
				bge $t6, 16, compare_computer_player
				la $t1, computer_card_read
				la $t2, computer_total_output
				addiu $sp, $sp, -20
				sw $s2, 0($sp)      #address of computer array
				sw $t1, 4($sp) 		#address of computer_card_read
				sw $t2, 8($sp)		#address of the computer_total_output
				sw $ra, 12($sp)		#save the $ra
				jal big_chungus
				lw $t1, 16($sp)
				lw $ra, 12($sp)
				addiu $sp, $sp, 20
				move $t6, $t1       #save the total to the global register

				bgt $t6, 21, player_wins			#computer got greedy, bust
				beq $t6, 21, computer_wins			#computer got lucky

				b user_choice_2

			compare_computer_player:
			#check if computer wins?
			bgt $t6, $t5, computer_wins
			bgt $t5, $t6, player_wins

			#TIE, by default
			li $v0, 4
			la $a0, tie_prompt
			syscall
			b EXIT_GAME

			player_wins:
			li $v0, 4
			la $a0, player_won
			syscall
			b EXIT_GAME

			computer_wins:
			li $v0, 4
			la $a0, computer_won
			syscall
			b EXIT_GAME

		
	EXIT_GAME:
	li $v0, 4
	la $a0, exit_output
	syscall
	#TERMINATE THE PRORGAM
    li $v0, 10
    syscall


#Eventually add a way to check for invalid inputs and print out a generic output, making the user_restart the entire program #
