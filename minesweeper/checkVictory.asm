.include "macros.asm"

.globl checkVictory

checkVictory:
	save_context
	move $s0, $a0
	
	li $v0, 0 #cont = 0
	
	li $s3, 0 # i = 0
	li $s4, SIZE 
	
	fordoi:
		bgt $s3, $s4, finaldofordoi
		
	li $s5, 0
	li $s6, SIZE
	fordoj:
		bgt $s5, $s6, finaldofordoj
		
	#if aq
	sll $t1, $s3, 5
	sll $t2, $s5, 2
	
	addi $t0, $t1, $t2
	addi $t0, $t0, $s0
	lw $s7, 0($t0)
	
	blt $s7, $zero, continua 
	
	addi $v0, $v0, 1
	
	 
