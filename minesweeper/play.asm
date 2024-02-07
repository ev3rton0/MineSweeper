.include "macros.asm"

.globl play

play:
	save_context
	move $s0, $a0 #endereço do board
	move $s1, $a1 #em a1 está a linha
	move $s2, $a2 #en a2 está a coluna
	
	sll $t1, $s1, 5 #Multiplica o que ta em s1(a linha desejada) por 2 elevado a 5, pois é 8 colunas e cada uma usa 4bit logo 32 
	sll $t2, $s2, 2 #Multiplica o que ta em s2(a coluna desejada) mesmo esquema
	
	add $t0, $t1, $t2 #soma a quantidade de "casas no vetor", ou seja, soma os endereços da linha e das colunas e armazena em t0
	add $t0, $t0, $s0 #soma o endereço do board com os endereços das linhas e colunas 
	lw $t4, 0($t0)
	
	beq $t4, -1, retorne0 #se t4 for igual a -1 pula para retorne 0 (encontrou uma bomba)
	bne $t4, -2, retorne1 #se t4 for diferente de -2 pula para retorne 1 
	
	addi $sp, $sp, -4 #aloca espaço na pilha 
	sw $s0, 0($sp) #guarda em s0 o endereço do ponteiro sp
	move $a3, $t0 #move o endereço do board para a3 //
	jal countAdjacentBombs #chama a função 
	addi $sp, $sp, 4 #libera o espaço alocado 
	sw $v0, 0($a3) #guarda em a3 valor retornado da função
	
	move $a0, $s0 
	move $a1, $s1 
	move $a2, $s2 
	
	bne $v0, $zero, retorne1 #se a celula revelada nao tiver o valor zero, pula pra retorne1
  	addi $sp, $sp, -4 #aloca espaço na pilha
  	sw $s0, 0 ($sp) #guarda em s0 o endereço do ponteiro sp
  	jal revealNeighboringCells #chama a função 
  	addi $sp, $sp, 4 #libera o espaço alocado 
	
	retorne1:
		li $v0, 1
		restore_context
		jr $ra  
	retorne0:
		li $v0, 0
		restore_context
		jr $ra  
