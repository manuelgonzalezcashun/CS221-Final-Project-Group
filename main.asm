#Ellmaer, Alex, Nik, Manny
#Due; {5/8}


.data
input: .asciiz "Enter an integer: "
output: .asciiz "Your Output is: "




.text 

.globl main
main:
	#print the input prompt
	li $v0, 4
	la $a0, input
	syscall 
	
	#take in the first input 
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	#print the input prompt again
	li $v0, 4
	la $a0, input
	syscall 
	
	#take in the second input 
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	

	#Call random_int function 
	addiu $sp, $sp, -16 #allocate stack space 
	sw $t1, 0($sp) #pass in arg 1
	sw $t2, 4($sp) #pass in arg 2
	sw $ra, 8($sp) #save $ra
	jal random_int #call & link the random_int function
	lw $a0, 12($sp)#get return value into $ra
	lw $ra, 8($sp) #restore $ra
	addiu $sp, $sp, 16 #reallocate space on the stack
	move $t0, $a0 #$t0, hold the random value between the two random values
	
	li $v0, 4
	la $a0, output
	syscall
	
	
	
    li $v0, 1 #random 
    move $a0, $t0
    syscall


	#TERMINATE THE PRORGAM
    li $v0, 10
    syscall


