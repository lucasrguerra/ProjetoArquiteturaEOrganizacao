#	Arquitetura e Organiza��o de Computadores
#		Semestre 2022.1
#
#		1� Atividade Avaliativa
#
# Lucas Rayan Guerra da Silva
#
# Este arquivo � referente a 4� quest�o
#
# O objetivo desse arquivo � implementar em Assembly MIPS
# algumas das fun��es da biblioteca "string.h" da Linguagem
# C, as fun��es s�o as seguintes:
#
# - strcpy
# - memcpy
# - strcmp
# - strncmp
# - strcat

.text							# Se��o de c�digo
	strcpy:					# Copia uma string passada como par�metro
						# $a0: endere�o da string de origem
						# $a1: endere�o da string de destino
						# $a2: tamanho da string a ser copiada
						
		add $t0, $zero, $a2			# armazena o tamanho da string em $t0
		
		loop_strcpy:				# Percorre a string enquanto houver caracteres
			lb $t1, 0($a0)			# carrega o pr�ximo caractere da string de origem
			sb $t1, 0($a1)			# armazena o caractere na string de destino
			addi $a0, $a0, 1		# incrementa o ponteiro da string de origem
			addi $a1, $a1, 1		# incrementa o ponteiro da string de destino
			addi $t0, $t0, -1		# decrementa o contador de caracteres
			bgtz $t0, loop_strcpy		# repete o loop enquanto houver caracteres restantes
			nop				# Nop para completar o ciclo de instru��es corretamente
			jr $ra				# Retorna para o endere�o de retorno
		
	memcpy:					# Copia dados na mem�ria passada como par�metro
						# $a0: endere�o dos dados de origem
						# $a1: endere�o da mem�ria de destino
						# $a2: tamanho dos dados em bytes
						
		add $t0, $zero, $a2			# armazena o tamanho dos dados em $t0
		
		loop_memcpy:				# Percorre os dados enquanto houver bytes
			lb $t1, 0($a0)			# carrega o pr�ximo byte dos dados de origem
			sb $t1, 0($a1)			# armazena o byte na mem�ria de destino
			addi $a0, $a0, 1		# incrementa o ponteiro dos dados de origem
			addi $a1, $a1, 1		# incrementa o ponteiro da mem�ria de destino
			addi $t0, $t0, -1		# decrementa o contador de bytes
			bgtz $t0, loop_memcpy		# repete o loop enquanto houver bytes restantes
			nop				# Nop para completar o ciclo de instru��es corretamente
			jr $ra				# Retorna para o endere�o de retorno
		
	strcmp:					# Compara duas strings passadas como par?metro
						# $a0: endere�o da string str1
						# $a1: endere�o da string str2
						
		move $t0, $a0				# $t0 recebe o ponteiro para a string str1
		move $t1, $a1				# $t1 recebe o ponteiro para a string str2

		loop_strcmp:				# Percorre as strings at� encontrar o primeiro caractere diferente
			lbu $s0, 0($t0)			# Carrega o byte apontado por $t0 em $s0
			lbu $s1, 0($t1)			# Carrega o byte apontado por $t1 em $s1

			bne $s0, $s1, diferente_strcmp	# Se $s0 e $s1 s�o diferentes, desvia para diferente_strcmp
			nop				# Nop para completar o ciclo de instru��es corretamente
			beq $s0, $zero, fim_strcmp	# Se $s0 � o caractere NULL, retorna zero
			nop				# Nop para completar o ciclo de instru��es corretamente

			addi $t0, $t0, 1		# Incrementa o ponteiro de $t0 para o pr�ximo byte
			addi $t1, $t1, 1		# Incrementa o ponteiro de $t1 para o pr�ximo byte
			j loop_strcmp			# Volta para o in�cio do loop
			nop				# Nop para completar o ciclo de instru��es corretamente

		diferente_strcmp:			# Encontrou um caractere diferente
			slt $s2, $s0, $s1		# $s2 recebe 1 se $s0 � menor do que $s1, e 0 caso contr�rio
			beq $s2, $zero, maior_strcmp	# Se $s0 � maior do que $s1, desvia para maior_strcmp
			nop				# Nop para completar o ciclo de instru��es corretamente
			li $v0, -1			# Carrega o valor -1 em $v0
			j fim_strcmp			# Pula para o fim_strcmp
			nop				# Nop para completar o ciclo de instru��es corretamente

		maior_strcmp:				# Se $s0 � maior do que $s1, retorna um inteiro positivo
			li $v0, 1			# Carrega o valor 1 em $v0
			j fim_strcmp			# Pula para o fim_strcmp
			nop				# Nop para completar o ciclo de instru��es corretamente

		fim_strcmp:				# Fim da fun��o, retorna o valor em $v0
			jr $ra				# Retorna para o endere�o de retorno
			nop				# Nop para completar o ciclo de instru��es corretamente
	
	strncmp:				# Compara duas strings passadas como parametro
						# $a0: endere�o da string str1
						# $a1: endere�o da string str2
						# $a2: n?mero m�ximo de caracteres a comparar
	
		move $t0, $a0				# $t0 recebe o ponteiro para a string str1
		move $t1, $a1				# $t1 recebe o ponteiro para a string str2
		move $t2, $a3				# $t2 recebe o n�mero m�ximo de caracteres a comparar
		
		loop_strncmp:				# Percorre as strings at� encontrar o primeiro caractere diferente ou at� comparar num caracteres
			lbu $s0, 0($t0)			# Carrega o byte apontado por $t0 em $s0
			lbu $s1, 0($t1)			# Carrega o byte apontado por $t1 em $s1

			bne $s0, $s1, diferente_strncmp	# Se $s0 e $s1 s�o diferentes, desvia para diferente_strncmp
			nop				# Nop para completar o ciclo de instru��es corretamente
			beq $s0, $zero, fim_strncmp	# Se $s0 � o caractere NULL, retorna zero
			nop				# Nop para completar o ciclo de instru��es corretamente
			beqz $t2, fim_strncmp		# Se num chegou a zero, retorna zero
			nop				# Nop para completar o ciclo de instru��es corretamente

			addi $t0, $t0, 1		# Incrementa o ponteiro de $t0 para o pr�ximo byte
			addi $t1, $t1, 1		# Incrementa o ponteiro de $t1 para o pr�ximo byte
			addi $t2, $t2, -1		# Decrementa o contador num
			j loop_strncmp			# Volta para o in�cio do loop
			nop				# Nop para completar o ciclo de instru��es corretamente

		diferente_strncmp:			# Encontrou um caractere diferente
			slt $s2, $s0, $s1		# $s2 recebe 1 se $s0 � menor do que $s1, e 0 caso contr�rio
			beq $s2, $zero, maior_strncmp	# Se $s0 � maior do que $s1, desvia para maior_strncmp
			nop				# Nop para completar o ciclo de instru��es corretamente
			li $v0, -1			# Carrega o valor -1 em $v0
			j fim_strncmp			# Pula para o fim_strncmp
			nop				# Nop para completar o ciclo de instru��es corretamente

		maior_strncmp:				# Se $s0 � maior do que $s1, retorna um inteiro positivo
			li $v0, 1			# Carrega o valor 1 em $v0
			j fim_strncmp			# Pula para o fim_strncmp
			nop				# Nop para completar o ciclo de instru��es corretamente

		fim_strncmp:				# Fim da fun��o, retorna o valor em $v0
			jr $ra				# Retorna para o endere�o de retorno
			nop				# Nop para completar o ciclo de instru��es corretamente

	strcat:					# Concatena duas strings passadas como parametro
						# $a0: endere�o da string destination
						# $a1: endere�o da string source
		
		move $t0, $a0				# $t0 recebe o ponteiro para a string destination
		move $t1, $a1				# $t1 recebe o ponteiro para a string source

		loop_strcat:				# Percorre a string destination
			lbu $s0, 0($t0)			# Carrega o byte apontado por $t0 em $s0
			beq $s0, $zero, loop_source	# Se $s0 � o caractere NULL, vai para loop_source
			nop				# Nop para completar o ciclo de instru��es corretamente

			addi $t0, $t0, 1		# Incrementa o ponteiro de $t0 para o pr�ximo byte
			j loop_strcat			# Volta para o in�cio do loop_strcat
			nop				# Nop para completar o ciclo de instru��es corretamente

		loop_source:				# Percorre a string source
			lbu $s0, 0($t1)			# Carrega o byte apontado por $t1 em $s0
			sb $s0, 0($t0)			# Armazena o byte apontado por $s0 em $t0
			beq $s0, $zero, fim_strcat	# Se $s0 � o caractere NULL, vai para fim_strcat
			nop				# Nop para completar o ciclo de instru��es corretamente

			addi $t0, $t0, 1		# Incrementa o ponteiro de $t0 para o pr�ximo byte
			addi $t1, $t1, 1		# Incrementa o ponteiro de $t1 para o pr�ximo byte
			j loop_source			# Volta para o in�cio do loop_source
			nop				# Nop para completar o ciclo de instru��es corretamente

		fim_strcat:				# Fim da fun��o, retorna o endere�o da string concatenada
			sb $zero, 0($t0)		# Adiciona o caractere NULL no final da string concatenada
			move $v0, $a0			# Retorna o endere�o da string concatenada em $v0
			jr $ra				# Retorna para o endere�o de retorno
			nop				# Nop para completar o ciclo de instru��es corretamente
	
