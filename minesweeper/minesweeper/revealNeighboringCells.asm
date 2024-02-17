.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	move $s0, $a0 #endereço do board
	move $s1, $a1 #em a1 está a linha
	move $s2, $a2 #en a2 está a coluna
	
	li $v0, 0
	
	addi $s3, $s1, -1
	addi $s4, $s1, 1 
	fordoi:
		bgt $s3, $s4,finalfordoi
	
	addi $s5,$s2,-1
	addi $s6,$s2,1
	fordoj:
		bgt $s5, $s6, finalfordoj
	
	blt $s3,$zero,continua
	bge $s3, SIZE,continua
	blt $s5,$zero,continua
	bge $s5,SIZE,continua
	
	sll $t1,$s3,5
	sll $t2,$s5,2
	
	add $t0,$t1,$t2
	add $t0,$t0,$s0
	lw $s7,0($t0)
	
	bne $s7, -2, continua
	
	#chamando a função countadjacentbombs 
	move $a1,$s3
	move $a2,$s5 
	addi $sp, $sp,-4
	sw $s0,0($sp)
	move $a3,$t0
	jal countAdjacentBombs
	addi $sp, $sp,4
	sw $v0,0($a3)
	

	move $a1, $s3
	move $a2, $s5 
	
	bne $v0,$zero,continua
	addi $sp, $sp,-4
	sw $s0,0($sp)
	jal revealNeighboringCells
	addi $sp, $sp,4
	
	
	continua:
		addi $s5,$s5,1
		j fordoj
	
	finalfordoj:
		addi $s3,$s3,1
		j fordoi
	
	finalfordoi:
		restore_context
		jr $ra
