# Definire una matrice 10x10 di byte.
# Realizzare un programma in linguaggio assemblativo
# che inizializza la matrice con valori casuali 0 e 1.
# Permettere ad un utente di scegliere riga e colonna e
# decidere dopo cinque tentativi quanti elementi con valore 1 ha individuato.
# Ogni volta che individua un 1 l'elemento è settato a 0.

.data
rowIn: .asciiz "Insert Row: "
colIn: .asciiz "Insert Col: "
outOnesFound: .asciiz "Number of 1s found: "
IndexErrorStr: .asciiz "Error: Index Out of Range, quitting."
matrix: .byte 0:100
newLine: .byte 10

.text
.globl main

main:
	# Get system time in a0
	li $v0, 30
	syscall
	
	# Set seed to system time
	li $v0, 40
	move $a1, $a0
	li $a0, 0
	syscall
	
	li $t0, 0 # Index for iteration

MatrixInitLoop:

	# Get random bit in a0	
	li $v0, 42
	li $a0, 0
	li $a1, 2
	syscall
	
	sb $a0, matrix($t0)
	
	addi $t0, $t0, 1
	
	blt $t0, 100, MatrixInitLoop
	
	
	jal MatrixPrint

	# Begin game fase
	
	li $t9, 0 # Iterator
	li $t8, 0 # Counter
GameLoop:
	
	li $v0, 4
	la $a0, rowIn
	syscall
	
	li $v0, 5
	syscall
	
	subi $t0, $v0, 1
	
	bgt $t0, 9, IndexError
	
	li $v0, 4
	la $a0, colIn
	syscall
	
	li $v0, 5
	syscall
	
	subi $t1, $v0, 1
	
	bgt $t1, 9, IndexError
	
	mul $t0, $t0, 10
	
	add $t1, $t1, $t0
	
	lb $t2, matrix($t1)
	beq $t2, 1, one
endIfEqOne:
	
	addi $t9, $t9, 1
	
	blt $t9, 5, GameLoop
	
	jal MatrixPrint
	
	li $v0, 4
	la $a0, outOnesFound
	syscall
	
	li $v0, 1
	move $a0, $t8
	syscall
	
	
end:    li $v0, 10
	syscall

one:
	sb $zero, matrix($t1)
	addi $t8, $t8, 1
	
	j endIfEqOne
	
MatrixPrint:

	li $t0, 0 # Iterator

MatrixPrintLoop:
	lb $a0, matrix($t0)
	
	li $v0, 1
	syscall
	
	addi $t0, $t0, 1
	
	blt $t0, 100, MatrixPrintLoop
	
	li $v0, 11
	lb $a0, newLine
	syscall
	
	jr $ra

IndexError:
	li $v0, 4
	la $a0, IndexErrorStr
	syscall
	
	j end