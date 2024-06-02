.text
.globl main

main:
	li $v0, 5
	syscall
	move $a0, $v0
	
	jal f
	
	move $a0, $v0
	
	li $v0, 1
	syscall
	
end:    li $v0, 10
	syscall
	
f:
	ble $a0, 1, endf  # Base Case

	subiu $sp, $sp, 8 # Prepare stack
	
	# Call to f(n-1)
	sw $ra, 0($sp) # Store RA

	subi $a0, $a0, 1
	jal f # Call with a0 = a0 - 1
	addi $a0, $a0, 1

	lw $ra, 0($sp) # Get RA back

	sw $v0, 0($sp) # Store result of f(n-1)


	# Call to f(n-2)
	sw $ra, 4($sp) # Store RA

	subi $a0, $a0, 2
	jal f # Call with a0 = a0 - 2
	addi $a0, $a0, 2
	
	lw $ra, 4($sp) # Get RA back

	lw $v1, 0($sp) # Get f(n-1) back
	addiu $sp, $sp, 8 # Restore stack

	add $v0, $v0, $v1 # f(n-2)+fib(n-1)
	jr $ra # Back to last iteration/main

endf:
	li $v0, 1
	jr $ra
	
