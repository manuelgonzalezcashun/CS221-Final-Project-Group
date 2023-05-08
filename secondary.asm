#Ellmaer, Alex, Nik, Manny
.data
delimiter: .asciiz " " #delimter is just a space


.text
.globl update_hand
update_hand: 
    lw $t9, 0($sp)              # load the memory address from the stack pointer
    lw $t8, 4($sp)              # The values (string)
    lw $t7, 8($sp)              # The totals (string)

    # call the random_int()
        addiu $sp, $sp, -12     # allocate stack space
        sw $ra, 0($sp)          # return address stored
        jal random_int
        lw $t1, 4($sp)          # random value restored
        lw $ra, 0($sp)          # return address returned
        addiu $sp, $sp, 12      # deallocate stack space

    # call the append_to_array()
        addiu $sp, $sp, -12
        sw $t1, 0($sp)          # random value passed
        sw $t9, 4($sp)          # memory address passed
        sw $ra, 8($sp)
        jal append_to_array
        lw $ra, 8($sp)
        addiu $sp, $sp, 12
        lw $t9, 0($sp)          # reset the memory address
    
    # call the display_array()
        addiu $sp, $sp, -12
        sw $t9, 0($sp)          # memory address passed
        sw $t8, 4($sp)          # string values passed
        sw $ra, 8($sp)          
        jal display_array
        lw $ra, 8($sp)
        addiu $sp, $sp, 12
        lw $t9, 0($sp)          # reset the memory address

    # call the get_totals()
        addiu $sp, $sp, -16
        sw $t9, 0($sp)          # memory address passed
        sw $t7, 4($sp)          # current total passed
        sw $ra, 8($sp)          # string values passed
        jal get_totals
        lw $ra, 8($sp)
        lw $t3, 12($sp)         # restores the total
        addiu $sp, $sp, 16

        sw $t3, 16($sp)         # stores total back onto stack


    jr $ra



.globl append_to_array
append_to_array:                 # APPEND RANDOM VALUE TO ARRAY OF TYPE PASSED (for either user or computer)
    lw $t1, 0($sp)               # value to append
    lw $t2, 4($sp)               # address of where to append 
    loop:
        lw $t3, 0($t2)
        beqz $t3, yes_append     # branch to yes_append if end of array is reached
        addi $t2, $t2, 4         # move to the next element
        b loop
    yes_append:
    sw $t1, 0($t2)                # save the new value to the array of the passed address
    jr $ra


.globl display_array
display_array:
    lw $t1, 0($sp)                 # address of array passed
    lw $t3, 4($sp)                 # display "x values:"

    # display to I/O
    li $v0, 4
    move $a0, $t3                  # display "x values:"
    syscall

    loop1:
        lw $t2, 0($t1)
        beqz $t2, done             # branch to done if every element in array is printed
        li $v0, 1
        move $a0, $t2
        syscall
        li $v0, 4
        la $a0, delimiter
        syscall
        addi $t1, $t1, 4           # loop counter updated
        b loop1

    done:
    jr $ra



.globl get_totals
get_totals: 
    lw $t1, 0($sp)                 # address of array of either player of computer
    lw $t4, 4($sp)                 # prints "x totals: "
    li $t3, 0                      # $t3 will hold the total value of the array
    li $v0, 4
    move $a0, $t4
    syscall
    loop4:
        lw $t2, 0($t1)             # loads next element in array
        beqz $t2, done4            # branches to done4 if all elements have been added
        add $t3, $t3, $t2          # calculated the total
        addi $t1, $t1 ,4           # loop counter updated
        b loop4

    done4:                         # print out the totals
        li $v0, 1
        move $a0, $t3
        syscall
        sw $t3, 12($sp)            # stores total on the stack
        jr $ra


.globl random_int
random_int:                        # GENERATE RANDOM VALUE between 1 - 11
    li $v0, 42                     # random number call        
    li $a1, 11                     # upper bound
    syscall
    addi $a0, $a0, 1               # lower bound
    sw $a0, 4($sp)                 # where the return value will be stored in
    jr $ra
