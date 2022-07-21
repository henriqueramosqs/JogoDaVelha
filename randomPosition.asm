.data
STRING: .string "\n"

.text
		#procedimento gera a posição aleatória para a matriz em a0


POS_ALEATORIA:
	li a7, 41	#guarda em a0 o numero pseudo aleatório gerado
	
	mv t0, a0
	li t1, 9
	remu t0, t0, t1	#gera o número de 0 a 8 correspondente à matriz de posições

	mv a0, t0
	li a7, 1
	ecall

	li a7, 10
	ecall

