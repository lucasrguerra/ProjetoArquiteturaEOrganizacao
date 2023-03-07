#	Arquitetura e Organiza��o de Computadores
#		Semestre 2022.1
#
#		1� Atividade Avaliativa
#
# Lucas Rayan Guerra da Silva
#
# Este arquivo � referente ao projeto
#
# O objetivo desse arquivo � ser um sistema de
# gest�o de condom�nio	

.data
	dados: .space 800	  		# Alocando 200 espa?os de 4 bytes na mem?ria

.text
	li $a0, 1
	li $a1, 2
	jal enderecoBaseApartamento
	nop
	
	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall
	add $a0, $zero, $v1
	addi $v0, $zero, 1
	syscall
	
	addi $v0, $zero, 10
	syscall
	
	retornar:
		jr $ra				# Retorna para o endere�o de retorno
		nop				# Nop para completar o ciclo de instru��es
	
	apartamentoExiste:
		addi $t0, $zero, 10		# $to = 10
		sle $t1, $a0, $t0		# Se $a0 < $t0, $t1 = 1
		sgt $t2, $a0, $zero	  	# Se $a1 > 0, $t2 = 1
		and $t3, $t1, $t2		# Se as 2 condi��es anteriores forem verdadeiras, $t3 = 1
	
		addi $t0, $zero, 4		# $t0 = 4
		sle $t1, $a1, $t0	  	# Se $a1 < $t0, $t1 = 1
		sgt $t2, $a1, $zero		# Se $a1 > 0, $t2 = 1
 		and $t4, $t1, $t2	    	# Se as 2 condi��es anteriores forem verdadeiras, $t4 = 1
	
		and $v0, $t3, $t4		# Se as 2 condi��es anteriores forem verdadeiras, $v0 = 1
		jr $ra				# Retorna para o endere�o de retorno
		nop				# Nop para completar o ciclo de instru��es
	
	enderecoBaseApartamento:
		addi $sp, $sp, -4		# subtrair 4 do valor de $sp para criar espa�o na pilha
		sw $ra, 0($sp)			# salvar o valor de $ra no endere�o apontado por $sp
		jal apartamentoExiste		# Chama a fun��o apartamentoExiste
		nop				# Nop para completar o ciclo de instru��es
		lw $ra, 0($sp)			# carregar o valor de $ra do endere�o apontado por $sp
		addi $sp, $sp, 4		# adicionar 4 ao valor de $sp para liberar o espa�o ocupado na pilha
		beq $v0, $zero, retornar	# Se $v0 = 0, retorna para o endere�o de retorno
		nop				# Nop para completar o ciclo de instru��es
		
		addi $t0, $a0, -1		# $t0 = $a0 - 1
		addi $t1, $zero, 20		# $t1 = 20
		mul $t2, $t0, $t1		# $t2 = $t0 * $t1
		
		addi $t0, $a1, -1		# $t0 = $a1 - 1
		addi $t1, $zero, 5		# $t1 = 5
		mul $t3, $t0, $t1		# $t3 = $t0 * $t1
		
		add $v0, $t2, $t3		# $v0 = $t2 + $t3
		addi $t0, $zero, 4		# $t0 = 4
		mul $v0, $v0, $t0		# $v0 = $v0 * 4
		addi $v1, $zero, 1		# $v1 = 1
		jr $ra				# Retorna para o endere�o de retorno
		nop				# Nop para completar o ciclo de instru��es
