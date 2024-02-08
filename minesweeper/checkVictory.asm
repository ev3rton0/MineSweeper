.include "macros.asm"

.globl checkVictory

checkVictory:
	save_context
	move $s0, $a0
	
	li $v0, 0 # count = 0
	
	li $s3, 0 # i = 0
	li $s4, SIZE 
	
	fordoi:
		bge $s3, $s4, finalfordoi
		
		li $s5, 0
		li $s6, SIZE
		
	fordoj:
		bge $s5, $s6,finalfordoj
		
		#if aq
		sll $t1, $s3, 5 # t1 = i*32
		sll $t2, $s5, 2 #
	
		add $t0, $t1, $t2
		add $t0, $t0, $s0
		
		lw $s7, 0($t0)
	
		bge $s7, 0, continua 
	
		addi $v0, $v0, 1    # Incrementa count
			
		continua:
			addi $s5, $s5, 1    # Incrementa j
			j fordoj
	
	finalfordoj:
		addi $s3, $s3, 1        # Incrementa i
		j fordoi
	
	finalfordoi:
	
		beq $v0,BOMB_COUNT, retorne1
		li $v0,0
		jr $ra                 
  
	retorne1:
		li $v0, 1
		restore_context
		jr $ra
