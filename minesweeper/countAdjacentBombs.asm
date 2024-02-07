.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
	save_context
	move $s0, $a0 #endereço do board
	move $s1, $a1 #em a1 está a linha
	move $s2, $a2 #en a2 está a coluna
	
	li $v0, 0 #cont = 0
	
	addi $s3, $s1, -1 #pegando o valor das linhas e diminuindo 1 e colocando em i, row - 1 = i
	addi $s4, $s1, 1 #somando um ao valor das linhas, row + 1 
	fordoi:
		bgt $s3, $s4, finaldofordoi #(pule se for maior) pula para o finaldofordoi se o valor de s3(i) for maior que o valor de s4
	
	addi $s5, $s2, -1 #pegando o valor das colunas e diminuindo 1 e colocando em j, column - 1 = j
	addi $s6, $s2, 1 #somando um ao valor das linhas, column + 1
	fordoj:
		bgt $s5, $s6, finaldofordoj #pula para o finaldofordoj se o valor de s5(j) for maior que o valor de s6
	
	blt $s3, $zero, continua #se o numero de linhas for menor que zero, sai do for, no caso vai para o continua
	bge $s3, SIZE, continua #se o numero de linhas for maior que o tamanha, sai do for
	blt $s5, $zero, continua #se o numero de colunas for menor que zero, sai do for, no caso vai para o continua
	bge $s5, SIZE, continua #mesma coisa das linhas
	
	sll $t1, $s3, 5 #esquema para andar no vetor(board) 2^5=32, que é a mesma coisa de 8*4
	sll $t2, $s5, 2 #ele "anda para esquerda" na verdade pega o valor que ta em s5 multiplica por 2^2 e guarda em t2
	
	add $t0, $t1, $t2 #soma os valores da linhas e colunas e guarda em t0, pra andar no board
	add $t0, $t0, $s0 #soma as cordenadas e localiza no board
	lw $s7, 0($t0) #guarda em s7 o valor de t0
	
	bne $s7, -1, continua #se o valor que tiver em s7 não for igual a -1(uma bomba) ele sai do for
	
	addi $v0, $v0, 1 #cont++ 
	
	continua:
		addi $s5, $s5, 1 #j++
		j fordoj #pula para o fordoj, ou seja, continua o for
	
	finaldofordoj:
		addi $s3, $s3, 1 #i++
		j fordoi #mesmo esquema
		
	finaldofordoi:
		restore_context
		jr $ra
	
