#	Arquitetura e Organização de Computadores
#		Semestre 2022.1
#
#		1ª Atividade Avaliativa
#
# Lucas Rayan Guerra da Silva
#
# Este arquivo é referente a 3ª questão
#
# O objetivo desse arquivo é calcular o n-ésimo valor da
# sequência de Fibonacci utilizando recursividade para
# qualquer valor n >= 0

.data						# Seção de dados
	n: .word 10				# Valor de entrada n

.text						# Seção de código
	la $t0, n				# Carrega o endereço de n em $t0
	lw $a0, 0($t0)				# Carrega o valor de n em $a0
	jal fibonacci				# Chama a função fibonacci
	
	add $a0, $zero, $v0			# Coloca o resultado em $a0
	li $v0, 1				# Define o valor 1 para o syscall de print_int
	syscall					# Executa uma chamada de sistema
	
	li $v0, 10				# Define o valor 10 para o syscall de saída
    	syscall					# Executa uma chamada de sistema
    	
	fibonacci:
		beqz $a0, retornarZero		# Se $a0 for 0, retorna 0
		nop				# Nop para completar o ciclo de instruções corretamente
		
		li $t0, 1			# Coloca 1 em $t0
		beq $a0, $t0, retornarUm	
		nop				# Nop para completar o ciclo de instruções corretamente
		
		addi $sp, $sp, -12		# Alocando espaço para os registradores
		sw $ra, 0($sp)			# Salvando os registradores
		sw $a0, 4($sp)			# Salvando os registradores
		addi $a0, $a0, -1		# $a0 = $a0 - 1
		jal fibonacci			# Chama a função fibonacci
		nop				# Nop para completar o ciclo de instruções corretamente
		sw $v0, 8($sp)			# Salvando os registradores
		lw $a0, 4($sp)			# Carrega o valor de n em $a0
		addi $a0, $a0, -2		# $a0 = $a0 - 2
		jal fibonacci			# Chama a função fibonacci
		nop				# Nop para completar o ciclo de instruções corretamente
		lw $t0, 8($sp)			# Carrega o valor de n em $a0
		add $v0, $v0, $t0		# $v0 = $v0 + $t0
		lw $ra, 0($sp)			# Carrega o valor de n em $a0
		addi $sp, $sp, 12		# Desalocando espaço para os registradores
		jr $ra				# Retorna para o endereço de retorno
	
	retornarZero:
		li $v0, 0			# Coloca $v0 em 0
		jr $ra				# Retorna para o endereço de retorno
		nop				# Nop para completar o ciclo de instruções corretamente
	
	retornarUm:
		li $v0, 1			# Coloca $v0 em 1
		jr $ra				# Retorna para o endereço de retorno
		nop				# Nop para completar o ciclo de instruções corretamente
