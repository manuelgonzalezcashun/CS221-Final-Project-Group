#Ellmaer, Alex, Nik, Manny
.data
delimiter: 





.text
.globl append_to_array
append_to_array: #APPEND RANDOM VALUE TO ARRAY OF TYPE PASSED (for either user or computer)
    lw $t1, 0($sp) #value to append
    lw $t2, 4($sp) #address of where to append 
    
    sw $t1, 0($t2) #save the new value to the array of the passed address
    jr $ra



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
    sw $a0, 12($sp)#where the return value will be stored in
    jr $ra

