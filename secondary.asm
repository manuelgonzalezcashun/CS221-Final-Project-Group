#Ellmaer, Alex, Nik, Manny
.data
delimiter: .asciiz " " #delimter is just a space


.text
.globl big_chungus
big_chungus: #only parameter will be the addrress of the array we are using
    lw $t9, 0($sp) #load the memory address from the stack pointer
    lw $t8, 4($sp) #The values
    lw $t7, 8($sp) #The totals
    random_int1:
        li $v0, 42     
        li $a1, 11
        syscall
        addi $a0, $a0, 1
        move $t1, $a0

    append_to_array1: 
        loop0:
            lw $t3, 0($t9)
            beqz $t3, yes_append
            addi $t9, $t9, 4
            b loop0
        yes_append:
        sw $t1, 0($t9) #save the new value to the array of the passed address
        lw $t9, 0($sp) #reset the memory address
    
    display_arra1y:
    li $v0, 4
    move $a0, $t8 #display "x values:"
    syscall
    
    loop1:
        lw $t2, 0($t9)
        beqz $t2, done
        li $v0, 1
        move $a0, $t2
        syscall
        li $v0, 4
        la $a0, delimiter
        syscall
        addi $t9, $t9, 4
        b loop1

        done:

    get_totals1: 
        lw $t9, 0($sp) #address of array of either player of computer
        li $t3, 0      #$t3 will hold the total value of the array
        
        li $v0, 4
        move $a0, $t7
        syscall
        loop4:
            lw $t2, 0($t9)
            beqz $t2, done4
            add $t3, $t3, $t2
            addi $t9, $t9 ,4
            b loop4
		
        done4: #print the total and also save to return address
            li $v0, 1
            move $a0, $t3
            syscall
            sw $t3, 16($sp)  # 4($sp) is the return value, aka the total
            
            jr $ra

