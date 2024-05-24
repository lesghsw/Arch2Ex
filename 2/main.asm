# Realizzare un programma in assembly MIPS che acquisita una stringa da input stringin
# valuta il numero di dittonghi ascendenti relativi alla sola lettera I presenti in stringin.
# I dittonghi ascendente della sola lettera I sono:
# IA, IE, II, IO e IU NB: Valore ASCII di A=65; E=69; I=73; O=81; U=85.

.data
	stringin: .space 50
	stringinlen: .word 50
.text
.globl main

main:
	li $t0, 0
	la $t1, stringin
	la $t2, stringinlen
	lw $t2, 0($t2)
	
	li $v0, 8
	move $a0, $t1
	move $a1, $t2
	syscall
loop:
	lb $t0, 0($t1)
	beqz $t0, endloop
	
	bne $t0, 73, incrloop
	
	addi $t1, $t1, 1
	lb $t0, 0($t1)
	
	beq $t0, 65, incrloopditt
	beq $t0, 69, incrloopditt
	beq $t0, 73, incrloopditt
	beq $t0, 81, incrloopditt
	beq $t0, 85, incrloopditt
	
incrloop:
	addi $t1, $t1, 1
	j loop
incrloopditt:
	addi $t1, $t1, 1
	addi $t9, $t9, 1
	j loop
endloop:

end:
	li $v0, 10
	syscall
