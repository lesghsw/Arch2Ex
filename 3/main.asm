.data
prompt: .asciiz "Inserisci un numero: "
output: .asciiz "\nSequenza di Collatz: "
length_msg: .asciiz "\nLunghezza: "
space: .asciiz " "

.text
.globl main
main:
    li $v0, 4              # Syscall to print string
    la $a0, prompt
    syscall
    
    li $v0, 5              # Syscall to read an integer
    syscall
    move $t0, $v0          # Store the initial number in $t0 for the sequence generation
    
    li $v0, 4              # Print the "Sequenza di Collatz: " string
    la $a0, output
    syscall
    
    li $t1, 0              # Counter for the length of the sequence

collatz_loop:
    move $a0, $t0          # Set the current value of n for next_collatz
    li $v0, 1              # Syscall to print integer
    move $a0, $t0          # Move current n into $a0 for printing
    syscall
    
    li $v0, 4              # Print a space
    la $a0, space
    syscall
    
    jal next_collatz       # Calculate the next Collatz number
    move $t0, $v0          # Update $t0 with the returned value
    
    addi $t1, $t1, 1       # Increment the sequence length
    bne $t0, 1, collatz_loop # Continue until n becomes 1

    # Print the final 1 and a space
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, space
    syscall

    # Print the length message
    li $v0, 4
    la $a0, length_msg
    syscall
    
    li $v0, 1              # Print the sequence length
    move $a0, $t1
    syscall
    
    # End the program
    li $v0, 10             # Syscall to exit the program
    syscall
 next_collatz:
    # Verifica se n è pari o dispari
    andi $t0, $a0, 1       # $t0 = n % 2
    beqz $t0, even         # Se n è pari, vai a "even"
    
    # Se n è dispari: 3n + 1
    li $t1, 3
    mul $t1, $a0, $t1      # $t1 = 3 * n
    addi $v0, $t1, 1       # $v0 = 3n + 1
    jr $ra                 # Ritorna al chiamante

even:
    # Se n è pari: n / 2
    sra $v0, $a0, 1        # $v0 = n / 2
    jr $ra                 # Ritorna al chiamante
