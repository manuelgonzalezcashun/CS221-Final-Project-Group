.globl random_int
random_int:
    lw $t1, 0($sp) #lower bound aka arg 1
    lw $t2, 4($sp) #upper bound aka arg 2
    li $v0, 42     #generate value between certain range
    move $a0, $t1
    move $a1, $t2
    syscall
    sw $a0, 12($sp)#where the return value will be stored in
    jr $ra

