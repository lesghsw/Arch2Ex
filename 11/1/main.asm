# Si scriva la routine assembler MIPS che implementa la funzione ricorsiva definita come segue:
# f(x,y) = 1 se uno (almeno) tra x,y vale 0
# f(x,y) = x * f(y,x-1) altrimenti
# Si assuma che x, y siano immessi da input sempre maggiori o uguali a 0

.text
.globl main

main:
	li $v0, 5
	syscall
	
	move $a0, $v0 # a0 = x
	
	li $v0, 5
	syscall
	
	move $a1, $v0 # a1 = y
	
	jal  f # Begin recursion
	move $a0, $v0 # get the function result ($v0) ready to be printed
	
	li $v0, 1
	syscall

end:    li $v0, 10
	syscall

f:	# Check base case
	beqz $a0, endf
	beqz $a1, endf
	
	subu $sp, $sp, 8 # Prepare stack for 2 words
	
	# Store x and ra (it is not needed to store y because it's not part of the formula)
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	# Update x and y according to the formula (x,y) -> (y, x-1)
	sub $t0, $a0, 1
	move $a0, $a1
	move $a1, $t0
	
	jal f # Call f with new x, y
	
	# Get old x and ra
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	
	addi $sp, $sp, 8 # Restore stack pointer
	
	mul $v0, $v0, $a0 # Apply formula to update return value
	
	jr $ra # Go back to last iteration or main function

endf:
	li $v0, 1 # Base case value
	jr $ra