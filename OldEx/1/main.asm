# Realizzare un programma in assembly MIPS che permetta l'immissione, da input, 
# di un valore x intero (word) e stampa, a video, y così definito:
#
# y = abs(log_2(x))
#
# Gestire eventuali casi anomali

	.data
invalid: .asciiz "IMPOSSIBILE"
	.text
.globl main

main:
	li $t0, 0
	li $t9, 0
	
	li $v0, 5
	syscall
	
	add $t0, $t0, $v0
	
	beq $t0, 1, endlog2
	blez $t0, invalidinput
	
log2:
	srl $t0, $t0, 1
	addi $t9, $t9, 1
	bgt $t0, 1, log2
	
endlog2:
	
	li $v0, 1
	move $a0, $t9
	syscall
	j end

invalidinput:
	li $v0, 4
	la $a0, invalid
	syscall
	

end:
	li $v0, 10
	syscall