#	Arquitetura e Organiza��o de Computadores
#		Semestre 2022.1
#
#		1� Atividade Avaliativa
#
# Lucas Rayan Guerra da Silva
#
# Este arquivo � referente a 2� quest�o
#
# O objetivo desse arquivo � calcular o comprimento de
# uma string

.data							# Se��o de dados
	str: .asciiz "Hello, world!"			# Declara uma string de exemplo
	
.text							# Se��o de c�digo
	la $a0, str					# Carrega o endere�o da string em $a0
	jal strlen					# Chama a fun��o strlen para calcular o comprimento da string
	nop						# Nop para completar o ciclo de instru��es corretamente
	move $a0, $v0					# Move o comprimento da string para o argumento da syscall para imprimir inteiro
	li $v0, 1					# Carrega o c�digo da syscall para imprimir inteiro (1) em $v0
	syscall						# Imprime o comprimento da string na tela

	li $v0, 10					# Carrega o c�digo da syscall para sair do programa (10) em $v0
	syscall						# Encerra o programa
	
	strlen:					# Calcula o comprimento de uma string
						# $a0: ponteiro para a string
		
		addi $sp, $sp, -4			# faz espa�o na pilha
		sw $ra, ($sp)				# salva o endere�o de retorno
		li $t0, 0				# inicializa o contador de comprimento com zero
		loop_strlen:				# Percorre a string at� encontrar o caractere NULL
			lb $t1, 0($a0)			# carrega um byte da string
			beqz $t1, fim_strlen		# verifica se chegou ao final da string
			nop				# Nop para completar o ciclo de instru��es corretamente
			addi $a0, $a0, 1		# incrementa o ponteiro da string
			addi $t0, $t0, 1		# incrementa o contador de comprimento
			j loop_strlen			# volta para o in�cio do loop
			nop				# Nop para completar o ciclo de instru��es corretamente

		fim_strlen:				# Fim da fun��o, retorna o comprimento da string
			lw $ra, ($sp)			# recupera o endere�o de retorno
			addi $sp, $sp, 4		# libera espa�o na pilha
			move $v0, $t0			# retorna o comprimento da string em $v0
			jr $ra				# retorna para o endere�o de chamada
			nop				# Nop para completar o ciclo de instru��es corretamente
