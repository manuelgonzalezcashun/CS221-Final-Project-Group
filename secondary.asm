#Ellmaer, Alex, Nik, Manny
.data
delimiter: .asciiz " " #delimter is just a space





.text
.globl append_to_array
append_to_array: #APPEND RANDOM VALUE TO ARRAY OF TYPE PASSED (for either user or computer)
    lw $t1, 0($sp) #value to append
    lw $t2, 4($sp) #address of where to append 
    loop:
        lw $t3, 0($t2)
        beqz $t3, yes_append
        addi $t2, $t2, 4
        b loop
    yes_append:
    sw $t1, 0($t2) #save the new value to the array of the passed address
    jr $ra


.globl display_array
display_array:
    lw $t1, 0($sp) #address of array passed
    loop1:
        lw $t2, 0($t1)
        beqz $t2, done
        li $v0, 1
        move $a0, $t2
        syscall
        li $v0, 4
        la $a0, delimiter
        syscall
        addi $t1, $t1, 4
        b loop1

    done:
    jr $ra





.globl get_totals
get_totals: 
	lw $t1, 0($sp) #address of array of either player of computer
	li $t3, 0      #$t3 will hold the total value of the array
	loop4:
		lw $t2, 0($t1)
		beqz $t2, done4
		add $t3, $t3, $t2
		addi $t1, $t1 ,4
		b loop4
		
	done4:
	sw $t3, 8($sp)
    jr $ra






.globl random_int
random_int: #GENERATE RANDOM VALUE for
    lw $t1, 0($sp) #lower bound aka arg 1
    lw $t2, 4($sp) #upper bound aka arg 2
    li $v0, 42     #generate value between certain range
    #move $a0, $t1
    move $a1, $t2
    syscall
    addi $a0, $a0, 1
    sw $a0, 12($sp)#where the return value will be stored in
    jr $ra

