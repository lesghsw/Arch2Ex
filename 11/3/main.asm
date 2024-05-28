# Si scriva la routine assembler MIPS che implementa la funzione ricorsiva definita come segue:
# f(x,y,z)=8 se x*y*z=0
# f(x,y,z)=x*y*z*f(z,x,y-1) altrimenti
# Si assuma che x, y, z siano sempre maggiori o uguali a 0

.text
.globl main

main:
	li $v0, 5
	syscall
	move $a0, $v0 # x
	
	li $v0, 5
	syscall
	move $a1, $v0 # y
	
	li $v0, 5
	syscall
	move $a2, $v0 # z
	
	jal f # Call f
	
	move $a0, $v0 # Get the function result ($v0) ready to be printed
	
	li $v0, 1
	syscall

end:    li $v0, 10
	syscall

f:
	mul $t0, $a0, $a1
	mul $t0, $t0, $a2
	beqz $t0, endf # Check base case
	
	subiu $sp, $sp, 16 # Prepare stack for 4 words (x, y, z, ra)
	
	# Store x, y, z, ra in the stack
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $ra, 12($sp)

	# Update parameters according to the formula (x, y, z) -> (z, x, y-1)
	subi $t0, $a1, 1
	move $t1, $a0
	
	move $a0, $a2
	move $a1, $t1
	move $a2, $t0
	
	jal f # Call f with new parameters
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	
	addiu $sp, $sp, 16 # Restore stack
	
	# Calculate f(x,y,z)
	mul $v0, $v0, $a0
	mul $v0, $v0, $a1
	mul $v0, $v0, $a2
	
	jr $ra # Go back to last iteration or main function
	
endf:
	li $v0, 8 # Base case value
	jr $ra