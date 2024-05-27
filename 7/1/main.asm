# Scrivere un programma in linguaggio assembaltivo MIPS/MARS che
# legga da tastiera cinque numeri interi e
# stampi su videoterminale il risultato della media tra i cinque numeri

.data
num: .float 5.0 # Number of elements of which we calculate the mean

.text
.globl main

main:
	l.s $f5, num # Load num in f5

	li $t0, 0 # Register where we will store the sum
	li $t1, 5 # Loop counter
	
addnum:
	li $v0, 5
	syscall
	
	# Add input to sum
	add $t0, $v0, $t0
	
	# Update counter and loop again if necessary
	addi $t1, $t1, -1
	bnez $t1, addnum
	
	# If loop ended we can convert the sum to float
	mtc1 $t0, $f0 # Move value in coprocessor 1
	cvt.s.w $f0, $f0 # Convert from word to single precision floating point (s.w) (final.initial)
	
	div.s $f12, $f0, $f5 # Apply formula
	
	li $v0, 2 # Print the mean
	syscall
	
end:	li $v0, 10
	syscall
