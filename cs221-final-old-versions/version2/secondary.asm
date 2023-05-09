#Ellmaer, Alex, Nik, Manny
.data
delimiter: .asciiz ", "
new_line: .asciiz "\n"





.text
.globl append_to_array
append_to_array: #APPEND RANDOM VALUE TO ARRAY OF TYPE PASSED (for either user or computer)
    #lw $t1, 0($sp) #value to append
    #lw $t2, 4($sp) #address of where to append 
    
    #sw $t1, 0($t2) #save the new value to the array of the passed address
    #jr $ra



.globl get_totals
get_totals: 
    jr $ra






.globl random_int
random_int: #GENERATE RANDOM VALUE for
    lw $t1, 0($sp) #lower bound aka arg 1
    lw $t2, 4($sp) #upper bound aka arg 2
    li $v0, 42     #generate value between certain range
    move $a0, $t1
    move $a1, $t2
    syscall
    addi $a0, $a0, 1
    sw $a0, 12($sp)#where the return value will be stored in
    jr $ra

.globl display_cards
display_cards:
	lw $t1, 0($sp) #Length of array
	lw $t2, 4($sp) #Array of either comp or player
	move $t0, $t1
	display_loop:
	blez $t0, finish
	lw $a0, ($t2)
	li $v0, 1
	syscall
	ble $t0, 1, deliminter_exit
	la $a0, delimiter
	li $v0, 4
	syscall
	deliminter_exit:
		# Step 5: Count down the loop using addi (Add integer). Count up the array address by 4 bytes to change index of array
		addi $t0, $t0, -1
		addi $t2, $t2, 4
		# Restart the loop
		b display_loop
	finish:
		jr $ra
