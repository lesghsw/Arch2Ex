#Definire una matrice 5x5 di halfword.
#Realizzare un programma in linguaggio assemblativo
#che consente ad un utente di inserire da tastiera
#il numero di riga ed il numero di colonna e visualizzare su schermo l'elemento.

.data
# 1  2  3  4  5
# 6  7  8  9  10
# 11 12 13 14 15
# 16 17 18 19 20
# 21 22 23 24 25

rowIn: .asciiz "Insert Row: "
colIn: .asciiz "Insert Col: "
IndexErrorStr: .asciiz "Error: Index Out of Range, quitting."
matrix: .half 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25

.text
.globl main

main:
	li $v0, 4
	la $a0, colIn
	syscall
	
	li $v0, 5
	syscall
	
	subi $t0, $v0, 1
	
	bgt $t0, 4, IndexError
	
	li $v0, 4
	la $a0, rowIn
	syscall
	
	li $v0, 5
	syscall
	
	subi $t1, $v0, 1
	
	bgt $t1, 4, IndexError
	
	mul $t1, $t1, 5
	add, $t0, $t0, $t1
	
	mul $t0, $t0, 2
	
	lh $t9, matrix($t0)
	
	li $v0, 1
	move $a0, $t9
	
	syscall
	

end:    li $v0, 10
	syscall

IndexError:
	li $v0, 4
	la $a0, IndexErrorStr
	syscall
	
	j end
