#	Arquitetura e Organiza��o de Computadores
#		Semestre 2022.1
#
#		1� Atividade Avaliativa
#
# Lucas Rayan Guerra da Silva
#
# Este arquivo � referente a 3� quest�o
#
# O objetivo desse arquivo � calcular o n-�simo valor da
# sequ�ncia de Fibonacci utilizando recursividade para
# qualquer valor n >= 0

.data						# Se��o de dados
	n: .word 10				# Valor de entrada n

.text						# Se��o de c�digo
	la $t0, n				# Carrega o endere�o de n em $t0
	lw $a0, 0($t0)				# Carrega o valor de n em $a0
	jal fibonacci				# Chama a fun��o fibonacci
	
	add $a0, $zero, $v0			# Coloca o resultado em $a0
	li $v0, 1				# Define o valor 1 para o syscall de print_int
	syscall					# Executa uma chamada de sistema
	
	li $v0, 10				# Define o valor 10 para o syscall de sa�da
    	syscall					# Executa uma chamada de sistema
    	
	fibonacci:
		beqz $a0, retornarZero		# Se $a0 for 0, retorna 0
		nop				# Nop para completar o ciclo de instru��es corretamente
		
		li $t0, 1			# Coloca 1 em $t0
		beq $a0, $t0, retornarUm	
		nop				# Nop para completar o ciclo de instru��es corretamente
		
		addi $sp, $sp, -12		# Alocando espa�o para os registradores
		sw $ra, 0($sp)			# Salvando os registradores
		sw $a0, 4($sp)			# Salvando os registradores
		addi $a0, $a0, -1		# $a0 = $a0 - 1
		jal fibonacci			# Chama a fun��o fibonacci
		nop				# Nop para completar o ciclo de instru��es corretamente
		sw $v0, 8($sp)			# Salvando os registradores
		lw $a0, 4($sp)			# Carrega o valor de n em $a0
		addi $a0, $a0, -2		# $a0 = $a0 - 2
		jal fibonacci			# Chama a fun��o fibonacci
		nop				# Nop para completar o ciclo de instru��es corretamente
		lw $t0, 8($sp)			# Carrega o valor de n em $a0
		add $v0, $v0, $t0		# $v0 = $v0 + $t0
		lw $ra, 0($sp)			# Carrega o valor de n em $a0
		addi $sp, $sp, 12		# Desalocando espa�o para os registradores
		jr $ra				# Retorna para o endere�o de retorno
	
	retornarZero:
		li $v0, 0			# Coloca $v0 em 0
		jr $ra				# Retorna para o endere�o de retorno
		nop				# Nop para completar o ciclo de instru��es corretamente
	
	retornarUm:
		li $v0, 1			# Coloca $v0 em 1
		jr $ra				# Retorna para o endere�o de retorno
		nop				# Nop para completar o ciclo de instru��es corretamente
