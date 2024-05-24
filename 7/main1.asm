.text
.globl main

main:
	l.s $f5, num

	li $t0, 0
	li $t1, 5
	
addnum:
	li $v0, 5
	syscall
	
	add $t0, $v0, $t0
	
	addi $t1, $t1, -1
	bnez $t1, addnum
	
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0
	
	div.s $f12, $f0, $f5
	
	#cvt.w.s $f1, $f1
	#mfc1 $t0, $f1
	
	li $v0, 2
	syscall
	
	li $v0, 10
	syscall

.data
	num: .float 5.0