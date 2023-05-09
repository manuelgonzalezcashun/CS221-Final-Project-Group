#Ellmaer, Alex, Nik, Manny
#Due; {5/8}

.data
introduction_text: .asciiz "Welcome to 21, the modified version of Black Jack!\n\n{Please read [rules.txt] for game rules!}\n"
player_choice: .asciiz "\nEnter a choice:\nEnter (1) to CONTINUE\nEnter (2) to EXIT\n----> "
player_array: .space 100 #space to put user card/values
computer_array: .space 100 #space to put the computers card/values
continue_prompt: .asciiz "\nEnter a choice:\nEnter (1) to HIT\nEnter (2) to STAND\n----> "

player_card_read: .asciiz "\nThe player's values: "
computer_card_read: .asciiz "\nThe computer's values: "

player_total_output: .asciiz "\nPlayers' current total: "
computer_total_output: .asciiz "\nComputer's current total: "

exit_output: .asciiz "\nThanks for playing our game!"

player_won: .asciiz "\nCongradulations!!, You Won!!"
computer_won: .asciiz "\nSorry, looks like you lost! Better luck next time!"
tie_prompt: .asciiz "\nLooks like no one wins! This round is a Tie!"

error: .asciiz "Please input a valid number!"


.text 
.globl main
main: # Where everything is running
	#print the introdcution and take the user_choice
	li $v0, 4 # print string
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
	beq $t0, 1, before_MAIN_LOOP # User wants to play game
	beq $t0, 2, EXIT_GAME # User doesn't want to play game
	bgt $t0, 1, INVALID_NUMBER_p1 #User entered invalid choice
	blt $t0, 2, INVALID_NUMBER_p1 #User entered invalid choice

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
				addiu $sp, $sp, -20 #allocates space on the stack
				sw $s1, 0($sp)      #address of player array
				sw $t1, 4($sp) 		#address of player_card_read
				sw $t2, 8($sp)		#address of the player_total_output
				sw $ra, 12($sp)		#save the $ra
				jal update_hand     #going to call update function
				lw $t1, 16($sp)		#Load the return total
				lw $ra, 12($sp)		#Load the return address
				addiu $sp, $sp, 20  #Deallocates space on the stack
				move $t5, $t1       #save the total to the global register
				
		part_2:
			#create computer hand, display the array, return the totals += to global variables
				la $t1, computer_card_read
				la $t2, computer_total_output
				addiu $sp, $sp, -20 #allocates space on the stack
				sw $s2, 0($sp)      #address of computer array
				sw $t1, 4($sp) 		#address of computer_card_read
				sw $t2, 8($sp)		#address of the computer_total_output
				sw $ra, 12($sp)		#save the $ra
				jal update_hand     #going to call update function
				lw $t1, 16($sp)     #Load the return total
				lw $ra, 12($sp)     #Load the return address
				addiu $sp, $sp, 20  #Deallocates space on the stack
				move $t6, $t1       #save the total to the global register

		get_user_choice:
			li $v0, 4 # print continue_propmt string
			la $a0, continue_prompt # print the continue_prompt
			syscall 
			li $v0, 5 # Get User input fromt continue_prompt
			syscall 

			beq $v0, 1, user_choice_1 # User wants to hit
			beq $v0, 2, user_choice_2 # User wants to stand
			bgt $v0, 1, INVALID_NUMBER_p2 #User entered invalid choice
			blt $v0, 2, INVALID_NUMBER_p2 #User entered invalid choice
			#ask the user (stand or hit?)
			user_choice_1: #hit
				la $t1, player_card_read
				la $t2, player_total_output
				addiu $sp, $sp, -20 #allocates space on the stack
				sw $s1, 0($sp)      #address of player array
				sw $t1, 4($sp) 		#address of player_card_read
				sw $t2, 8($sp)		#address of the player_total_output
				sw $ra, 12($sp)		#save the $ra
				jal update_hand		#going to call update function
				lw $t1, 16($sp)  	#Load the return total
				lw $ra, 12($sp)		#Load the return address
				addiu $sp, $sp, 20	#Deallocates space on the stack
				move $t5, $t1       #save the total to the global register

				#JUST DISPLAY COMPUTER TOTAL
				li $v0, 4 #print string
				la $a0, computer_total_output #print the computer total points 
				syscall
				li $v0, 1 #loading computer total into register
				move $a0, $t6 #Saves computer total output to computer total global variable
				syscall
				

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
				jal update_hand		#going to call update function
				lw $t1, 16($sp)		#Load the return total
				lw $ra, 12($sp)		#Load the return address
				addiu $sp, $sp, 20  #Deallocates space on the stack
				move $t6, $t1       #save the total to the global register

				#JUST DISPLAY PLAYER TOTAL
				li $v0, 4 #print string
				la $a0, player_total_output #print player_total_output
				syscall
				li $v0, 1 #load player_total_output into register
				move $a0, $t5 #Saves player total output to player total global variable
				syscall
				

				bgt $t6, 21, player_wins			#computer got greedy, bust
				beq $t6, 21, computer_wins			#computer got lucky

				b user_choice_2

			compare_computer_player:
			#check if computer wins?
			bgt $t6, $t5, computer_wins #If computer is closer to 21 or is 21,  computer wins 
			bgt $t5, $t6, player_wins #If player is closer to 21 or is 21, player wins

			#TIE, by default
			li $v0, 4 #print string
			la $a0, tie_prompt #prints tie_prompt
			syscall
			b EXIT_GAME #Exits the game

			player_wins:
			li $v0, 4 #print string
			la $a0, player_won #prints player_won prompt
			syscall
			b EXIT_GAME #Exits the game

			computer_wins:
			li $v0, 4 #print string
			la $a0, computer_won #prints computer_won prompt
			syscall
			b EXIT_GAME #Exits the game
			
	INVALID_NUMBER_p1:
	li $v0, 4 #print string
	la $a0, error #prints error prompt to user
	syscall
	b main_2 #returns to main_2
	
	INVALID_NUMBER_p2:
	li $v0, 4 #print string
	la $a0, error #print error prompt to user
	syscall
	b get_user_choice #returns to get_user_choice

		
	EXIT_GAME:
	li $v0, 4 #print string
	la $a0, exit_output #print exit prompt to user
	syscall
	#TERMINATE THE PRORGAM
    li $v0, 10
    syscall


# Error Catcher if there is an invalid input (Input is anything other than 1 or 2)

.kdata
register: .space 8
bad_input: .asciiz "You must input a valid number"

.ktext 0x80000180
# Saving registers for the address, and our $a0 and $v0 values
move $k1, $at
la $k0, register
sw $a0, 0($k0)
sw $v0, 4($k0)

# Get the cause of the error
mfc0 $k0, $13
srl $k0, $k0, 2
andi $k0, $k0, 15

# Output prompt that shows error. (This case, the error is the same given an invalid input)
li $v0, 4
la $a0, bad_input
syscall

# Instead of moving forward in the code, shift back to re-load the prompt
mfc0 $k0, $14
addi $k0, $k0, -20
mtc0 $k0, $14

# Cause register is reset
mtc0 $zero, $13

# Clear status register by retrieving, doing andi with 0xFFFD and setting it back in place
mfc0 $k0, $12
andi $k0, $k0, 0xFFFD
ori $k0, $k0, 1
mtc0 $k0, $12

# Load back our register, along with $a0 and $v0. After, move back with our "new" return address
la $k0, register
lw $a0, 0($k0)
lw $v0, 4($k0)
move $at, $k1
eret
