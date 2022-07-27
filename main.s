
.data
.include "images_data/Menu.data"
.include "images_data/UnselectedHardLevel.data"
.include "images_data/UnselectedMediumLevel.data"
.include "images_data/UnselectedEasyLevel.data"
.include "images_data/SelectedHardLevel.data"
.include "images_data/SelectedMediumLevel.data"
.include "images_data/SelectedEasyLevel.data"
.include "images_data/Instructions.data"
.include "images_data/GameBackground.data"
.include "images_data/TicTacToeStructure.data"
.include "images_data/MarkedSelection.data"
.include "images_data/Unmarked.data"
.include "images_data/X.data"
.include "images_data/O.data"
.include "images_data/VoceVenceu.data"
.include "images_data/JuliaVenceu.data"
.include "images_data/Velha.data"
.include "images_data/Round.data"
.include "images_data/zero.data"
.include "images_data/um.data"
.include "images_data/dois.data"
.include "images_data/tres.data"
.include "images_data/quatro.data"
.include "images_data/cinco.data"
.include "images_data/seis.data"
.include "images_data/sete.data"
.include "images_data/oito.data"
.include "images_data/nove.data"
.include "images_data/TicTacToeCover.data"
.include "images_data/MenuButtonSelected.data"
.include "images_data/MenuButtonUnselected.data"
.include "images_data/RestartButtonSelected.data"
.include "images_data/RestartButtonUnselected.data"
.include "images_data/CoverRest.data"

matriz: .byte 	
		0,0,0
		0,0,0,
		0,0,0,

		
frame_zero: .word 0xFF000000
frame_one:  .word 0xFF100000

.text	
Start:
	lw a3, frame_zero
	j velhaInTotal
	
	la a0,Menu
	lw a3, frame_zero
	jal drawImage
	
	la a0,SelectedEasyLevel
	li  a1,85
	li a2,90
	jal drawImage
	
	la a0,UnselectedMediumLevel
	li  a1,85
	li a2,130
	jal drawImage
	
	la a0,UnselectedHardLevel
	li  a1,85
	li a2,170
	jal drawImage
	
menuLoop:				#s1 armazenará status da seleção
	jal readKeyBlocking	
	li t0, 'w'
	li t1, 's'
	li t2, ' '
	li t3, 3
	beq a0, t0, moveUp
	beq a0,t1, moveDown
	bne a0,t2,menuLoop
	j showRules
moveUp:
	addi s1,s1,-1
	bge s1,zero,nonNegativeCase
	addi s1,s1,3
nonNegativeCase:
	j drawMenuOptions
moveDown:
	addi s1,s1,1
drawMenuOptions:
	rem s1,s1,t3
	li t0,0
	li t1,1
	beq s1,t0,firstMenuOption
	beq s1,t1,secondMenuOption
	
	la a0,UnselectedEasyLevel	# nível difícil selecionado
	li  a1,85
	li a2,90
	jal drawImage
	
	la a0,UnselectedMediumLevel
	li  a1,85
	li a2,130
	jal drawImage
	
	la a0,SelectedHardLevel
	li  a1,85
	li a2,170
	jal drawImage
	
	j menuLoop			# volta para loop do menu
firstMenuOption:			# nível fácil selecionado

	la a0,SelectedEasyLevel
	li  a1,85
	li a2,90
	jal drawImage
	
	la a0,UnselectedMediumLevel
	li  a1,85
	li a2,130
	jal drawImage
	
	la a0,UnselectedHardLevel
	li  a1,85
	li a2,170
	jal drawImage
	j menuLoop		 # volta para loop do menu

secondMenuOption:		# nível médio selcionado
	la a0,UnselectedEasyLevel
	li  a1,85
	li a2,90
	jal drawImage
	
	la a0,SelectedMediumLevel
	li  a1,85
	li a2,130
	jal drawImage
	
	la a0,UnselectedHardLevel
	li  a1,85
	li a2,170
	jal drawImage
	
	j menuLoop		#volta para loop do menu
	

showRules:	

	la a0,Instructions
	li  a1,0
	li a2,0
	jal drawImage
	
	jal readKeyBlocking
	
	li s1,0	 	# s1 maraca pontuação do jogador
	li s2,0		# s2 marca a pontuação da máquina
	li s7,0 	# s7 marca quantidade total de partidas até então
	li s8,9		# s8 marca quantidade máxima de jogadas
startGame:
	li s3,0 	# s3 marca a posição do no eixo x do jogador
	li s4,0		# s4 marca a posição do no eixo y do jogador
	li s9,0		# s9 marca contador de jogadas por partida
	
	jal resetMatrix
	
	li  a1,0
	li a2,0
	la a0,GameBackground
	jal drawImage
	
	la a0,TicTacToeStructure
	li a1,85
	li a2,67
	jal drawImage

	jal printPlacar
	
gameLoop:
	jal readKeyBlocking	# Lê entrada do usuário
	mv s5,a0		# s5 armazena ascci do digitado
	li t0,' ' 
	beq a0,t0,doesntChange
	beq s6,zero,postPrintPrior
	
	jal calculateXCoordinate
	mv a1, a0
	
	jal calculateYCoordinate
	mv a2,a0
	
	la a0,Unmarked
	jal drawImage
	
postPrintPrior:
	mv a0,s5
	jal changePosition
doesntChange:
	mv a0,s3
	mv a1,s4
	jal checkPosition	# dada a posição, armazena em a0 o itme daquela posição na matriz
	li s6,0
	bne a0,zero,gameLoop	# se a posição estiver preenchida, reitera o game loop
	
	jal calculateXCoordinate
	mv a1, a0
	
	jal calculateYCoordinate
	mv a2,a0
	
	li t0,' '
	bne t0,s5,notPicking
	jal markPosition
	la a0,X
	li s6,0
	j paintPosition
notPicking:
	la a0,MarkedSelection
	li s6,1	#s6 marca se o item anterior tinha sido destacado
paintPosition:
	lw a3,frame_zero
	jal drawImage
	
	li a0, 'x' #checa se usuário é vencedor
	jal checkWin
	bne a0,zero,userWon #se for o caso
	
	addi s9,s9,1
	beq s9,s8,velha
	
	#IA JOGA
	
	#li a0, 'o' #checa se máquina é vencedor
	#jal checkWin
	#bne a0,zero,machineWon
	#addi s9,s9,1
	#beq s9,s8,velha
	
	j gameLoop
	
userWon:
	addi s1,s1,1 # incrementa pontuacao do jogador
	addi s7,s7,1 # incrementa a quantidade de partidas até então
	
	li t0,5				#condicionais de contagem
	beq s1,t0,userWonInTotal
	li t0,20
	beq s7,t0,velhaInTotal
	j startGame  			#começa outro jogo
machineWon:
	addi s2,s2,1	#incrementa pontuação da máquina
	addi s7,s7,1 # incrementa a quantidade de partidas até então
	
	li t0,5				#condicionais de contagem
	beq s2,t0,machineWonInTotal
	li t0,20
	beq s7,t0,velhaInTotal
	j startGame  
velha:
	addi s7,s7,1 # incrementa a quantidade de partidas até então
	li t0,20
	beq s7,t0,velhaInTotal
	j startGame  
  

userWonInTotal:
	
	lw a3,frame_zero
	la a0,TicTacToeCover
	li a1,85
	li a2,67
	jal drawImage

	la a0,VoceVenceu	
	li a1,15
	li a2,57
	j endGameMenu
machineWonInTotal:
	lw a3,frame_zero
	la a0,TicTacToeCover
	li a1,85
	li a2,67
	jal drawImage
	
	la a0,JuliaVenceu	
	li a1,15	
	li a2,57
	lw a3,frame_zero
	j endGameMenu
velhaInTotal:
 	la a0,CoverRest
 	li a1,0
 	li a2,0
 	lw a3,frame_zero
 	jal drawImage
 	
	la a0,Velha
	li a1,39	
	li a2,8
	lw a3,frame_zero
endGameMenu:
	jal drawImage
	li s1,0 #s1 agora marca opção do jogador
	
	j printFirstEndOption
	
endGameLoop:				#paridade s1 armazenará status da seleção
	jal readKeyBlocking	
	li t0, 'w'
	li t1, 's'
	li t2, ' '

	beq a0,t0,addOne
	beq a0,t1,addOne	# se digitar w ou s, mesmo resultado
	bne a0,t2, endGameLoop	#se não tiver ditado w,s,ou espaço, não faça nada
	
	li t0,2
	rem t0,s1,t0
	beq t0,zero,backToMenu	#se tiver na primeira tela, volta pro menu
	j startGame		#se tiver na segunda, restarta o jogo
backToMenu:
	j Start
	

addOne:
	addi s1,s1,1
	
	li t0,2
	rem t0,s1,t0
	beq t0,zero,printFirstEndOption	#printa primeira opcao do menu
	j printSecondEndOption		#printa segunda opção de menu
	
printFirstEndOption:
	la a0,MenuButtonSelected
	li a1,85
	li a2,140
	lw a3,frame_zero
	jal drawImage
	
	la a0,RestartButtonUnselected
	li a1,85
	li a2,186
	lw a3,frame_zero
	jal drawImage
	
	j endGameLoop

printSecondEndOption:
	la a0,MenuButtonUnselected
	li a1,85
	li a2,140
	lw a3,frame_zero
	jal drawImage
	
	la a0,RestartButtonSelected
	li a1,85
	li a2,186
	lw a3,frame_zero
	jal drawImage
	
	j endGameLoop

	

drawImage:	# a0= endereço da imagem, a1= coord_x, a2=coord_y, a3=frame

	lw t0,0(a0)	# t0 armazena largura da imagem
	lw t1,4(a0)	# t1 armazena altura da imagem

	li t2,320
	mul t2,a2,t2
	add t2,t2,a1
	add t2,t2,a3	# t2 armazena endereco inicial/atual da área de pintura
	
	li t3,320
	mul t3,t3,t1
	add t3,t3,t0
	add t3,t3,t2 	# t3 armazena enderço final da área de pintura
	addi t3,t3,-320
		
	addi a0,a0,8	# muda a0 para o endereço inicial das cores
	li t5,0 	# t5 é um marcador de passos à direita
	li t4, 0xC7

drawLoop:
	beq t2,t3,finishDraw # se endereço atual = endereço final, finaliza pintura
	bne t5,t0, keepDraw
	
	addi t2,t2,320		#muda t2 para primeira posição da linha debaixo
	sub t2,t2,t0	
	add t5,zero,zero
keepDraw:
	lb t6,(a0) # t6 carrega coloração do pixel
	beq t4,t6,transparent
	sb t6,0(t2)
transparent:
	addi t2,t2,1  # muda para póximo endereço
	addi t5,t5,1  #passa o contador de passos para a direita
	addi a0,a0,1
	j drawLoop
finishDraw:
	ret


readKeyBlocking:
# Pausa o programa e espera que o usu?rio pressione uma tecla para continuar
#
# caractere pressiona -> a0
	
	li t1, 0xFF200000		# Carrega o endere?o de status do KDMMIO
rkb_loop:
	lw t0, 0(t1)		# Carrega o status do teclado
	andi t0, t0, 0x0001	# Mascara o bit menos significativo. Por qu??!
	beq t0, zero, rkb_loop	# Se n?o houver tecla pressionada repete at? que o usu?rio aperte algo
	lw a0, 4(t1)			# Carrega o caractere que foi pressionado
	sw a0, 12(t1)			# Escreve o caractere lido no display 
	ret	

readKeyNonBlocking:
# Verifica se o usu?rio pressionou uma tecla, se não continua o programa, se
# sim, retorna o caractere pressionado
#
# caractere -> a0
	
	li t1, 0xFF200000	# Carrega o endereço de status do KDMMIO
	lw t0, 0(t1)		# Carrega o status do teclado
	andi t0, t0, 0x0001	# Mascara o bit menos significativo
	beq t0, zero, rknb_end	# Se não houver tecla pressionada continua
	lw t2, 4(t1)		# Carrega o caractere que foi pressionado
	lw a0, 4(t1)		# Carrega em a0 (vari?vel de retorno) o caractere
	sw t2, 12(t1)		# Escreve o caractere lido no display
rknb_end:
	ret
	
changePosition:	# :void, recebe em a0 o caracter em ascii que o usuario pressionou
	li t0,'w'
	li t1,'a'
	li t2,'d'
	li t3,3
	beq a0,t0,cursorUp
	beq a0,t1,cursorLeft
	beq a0,t2,cursorRight
	addi s4,s4,1
	rem s4,s4,t3
	ret
cursorUp:
	addi s4,s4,-1
	rem s4,s4,t3
	bge s4,zero,cursorUpNonNegativeCase
	addi s4,s4,3
cursorUpNonNegativeCase:
	ret
cursorLeft:
	addi s3,s3,-1
	rem s3,s3,t3
	bge s3,zero,cursorLeftNonNegativeCase
	addi s3,s3,3
cursorLeftNonNegativeCase:
	ret
cursorRight:
	addi s3,s3,1
	rem s3,s3,t3
	ret
	
checkPosition:	# a0= pos_x, a1=pos_y, retorna item correspondente à posicao na matriz
	li t0,3
	mul t0,t0,a1
	add t0,t0,a0
	la t1,matriz
	add t1,t1,t0
	lb a0,(t1)	
	ret
	
markPosition:	# s3= pos_x, s4=pos_y, marca item correspondente à posicao na matriz
	li t0,3
	mul t0,t0,s4
	add t0,t0,s3
	la t1,matriz
	add t1,t1,t0
	li t0, 'x'
	sb t0,(t1)	
	ret
	
calculateXCoordinate:	# s3= pos_x retorna em a0 a coordenada x
	li t0,51
	mul a0,t0,s3
	addi a0,a0,85
	ret

calculateYCoordinate:	#s4= pos_y retorna em a0 a coordenada y
	li t0,51
	mul a0,s4,t0
	addi a0,a0,67
	ret
	
checkWin: #:bool, recebe em a0 o caracter que deve ser analisado
	addi sp,sp,-8
	sw a0,(sp)	#prepara pilha para chamada do procedimento
	sw ra,4(sp)
	
	jal checkLines
	bne a0,zero,checkWinFinish # se tiver fechado alguma linha,acaba o procedimento
		
	lw a0,(sp)		#pega de volta o caracter que deve ser analisado
	jal checkColumns
	bne a0,zero,checkWinFinish # se tiver fechado alguma coluna,acaba o procedimento

	lw a0,(sp)		#pega de volta o caracter que deve ser analisado
	jal checkMainDiagonal
	bne a0,zero,checkWinFinish # se tiver fechado a diagonal principal,acaba o procedimento

	lw a0,(sp)		#pega de volta o caracter que deve ser analisado
	jal checkSecondaryDiagonal
checkWinFinish:
	lw ra,4(sp)	#se tiver ou não fechado, restaura a pilha e retorna o valor de a0
	addi sp,sp,8
	ret
	
checkLines:	# recebe em a0 o caracter que deve ser checado
	mv t5,a0	#caracter digitado fica em t5
	li t2,3	
	li a0,0 # a0 = pos_x
	li a1,0 # a1 = pos_y
checkLinesLoop:
	li t3,0	# t3 = quantidade de caracteres de certo tipo na linha
	beq a1,t2, endLinesLoop
checkLinesInnerLoop:

	addi sp,sp,-8	#prepara pilha para chamado do checkPosition
	sw a0,(sp)
	sw ra,4(sp)
	
	jal checkPosition	
	mv t4,a0 	#t4 = caracter na posição da matriz
	
	lw a0,(sp)
	lw ra,4(sp)	#restaura a pilha
	addi sp,sp,8
	
	bne t5,t4,nextLinesIteration	#se não for igual, passa para próxima iteração
	addi t3,t3,1	#se der match, aumenta a quantidade do contador
	bne t3,t2,nextLinesIteration #se t2!=3, vai para próxima iteração
	li a0,1
	ret			#se t2=3, retorna true
nextLinesIteration:
	addi a0,a0,1
	bne a0,t2,checkLinesInnerLoop
	li a0,0
	addi a1,a1,1
	j checkLinesLoop
endLinesLoop:
	li a0,0
	ret
	

checkColumns:	# recebe em a0 o caracter que deve ser checado
	mv t5,a0	#caracter digitado fica em t5
	li t2,3	
	li a0,0 # a0 = pos_x
	li a1,0 # a1 = pos_y
checkColumnsLoop:
	li t3,0	# t3 = quantidade de caracteres de certo tipo na linha
	beq a0,t2, endColumnsLoop
checkColumnsInnerLoop:

	addi sp,sp,-8	#prepara pilha para chamado do checkPosition
	sw a0,(sp)
	sw ra,4(sp)
	
	jal checkPosition	
	mv t4,a0 	#t4 = caracter na posição da matriz
	
	lw a0,(sp)
	lw ra,4(sp)	#restaura a pilha
	addi sp,sp,8
	
	bne t5,t4,nextColumnsIteration	#se não for igual, passa para próxima iteração
	addi t3,t3,1	#se der match, aumenta a quantidade do contador
	bne t3,t2,nextColumnsIteration #se t2!=3, vai para próxima iteração
	li a0,1
	ret			#se t2=3, retorna true
nextColumnsIteration:
	addi a1,a1,1
	bne a1,t2,checkColumnsInnerLoop
	li a1,0
	addi a0,a0,1
	j checkColumnsLoop
endColumnsLoop:
	li a0,0
	ret
	
	
checkMainDiagonal:	# recebe em a0 o caracter a ser analisado
	mv t5,a0	#t5 armazena caracter a ser analisado
	li t2,3
	li a0 0
checkMainDiagonalLoop:
	addi sp,sp,-8	#prepara pilha para chamado do checkPosition
	sw a0,(sp)
	sw ra,4(sp)
	
	add a1,a0,zero
	jal checkPosition	
	mv t4,a0 	#t4 = caracter na posição da matriz
	
	lw a0,(sp)
	lw ra,4(sp)	#restaura a pilha
	addi sp,sp,8
	
	beq t4,t5,nextMainDiagonalIteration
	li a0,0
	ret		#se houver um diferente, return false
nextMainDiagonalIteration:
	addi a0,a0,1
	beq a0,t2,mainDiagonalLoopEnd
	j checkMainDiagonalLoop
mainDiagonalLoopEnd:
	li a0,1
	ret

checkSecondaryDiagonal:	# recebe em a0 o caracter a ser analisado
	mv t5,a0	#t5 armazena caracter a ser analisado
	li t2,3
	li a0 0
checkSecondaryDiagonalLoop:
	addi sp,sp,-8	#prepara pilha para chamado do checkPosition
	sw a0,(sp)
	sw ra,4(sp)
	
	li a1,2
	sub a1,a1,a0
	jal checkPosition	
	mv t4,a0 	#t4 = caracter na posição da matriz
	
	lw a0,(sp)
	lw ra,4(sp)	#restaura a pilha
	addi sp,sp,8
	
	beq t4,t5,nextSecondaryDiagonalIteration
	li a0,0
	ret		#se houver um diferente, return false
nextSecondaryDiagonalIteration:
	addi a0,a0,1
	beq a0,t2,SecondaryDiagonalLoopEnd
	j checkSecondaryDiagonalLoop
SecondaryDiagonalLoopEnd:
	li a0,1
	ret
	
resetMatrix:	#:void, zera a matriz
	la t0,matriz
	sb zero,(t0)
	sb zero,1(t0)
	sb zero,2(t0)
	sb zero,3(t0)
	sb zero,4(t0)
	sb zero,5(t0)
	sb zero,6(t0)
	sb zero,7(t0)
	sb zero,8(t0)
	ret
	
printPlacar: # usa s1 como pontuação do jogador, s2 como pontuação da máquina, s7 o nº da partida
	addi sp,sp,-8
	sw a0,(sp)
	sw ra,4(sp)	#prepara pilha para chamada dos Draw Images
	
	li t0,10	
	div a0,s1,t0	# a0 = primeiro dígito do usuário
	
	jal getNumberImage
	lw a3, frame_zero
	li a1, 40
	li a2,30	
	jal drawImage		#printa primeiro dígito do usuário

	li t0,10	
	rem a0,s1,t0	#a0 = segundo dígito do usuário
	
	jal getNumberImage
	lw a3, frame_zero
	li a1, 55
	li a2,30	
	jal drawImage		#printa segunto dígito do usuário

	li t0,10	
	div a0,s2,t0	# a0 = primeiro dígito da máquina
	
	jal getNumberImage
	lw a3, frame_zero
	li a1, 250
	li a2,30	
	jal drawImage		#printa primeiro dígito da máquina

	li t0,10	
	rem a0,s2,t0	#a0 = segundo dígito da máquina
	
	jal getNumberImage
	lw a3, frame_zero
	li a1, 265
	li a2,30	
	jal drawImage		#printa segunto dígito da máquina
	
	lw a3, frame_zero
	la a0, Round
	li a1, 245
	li a2,170
	jal drawImage		#printa a palavra round

	div a0,s7,t0	# a0 = primeiro dígito da da quantidade de rounds
	
	jal getNumberImage
	lw a3, frame_zero
	li a1, 260
	li a2,192	
	jal drawImage		#printa primeiro dígito da da quantidade der ounds

	li t0,10	
	rem a0,s7,t0	#a0 = segundo dígito da máquina
	
	jal getNumberImage
	lw a3, frame_zero
	li a1, 275
	li a2, 192	
	jal drawImage		#printa segunto dígito da máquina	

	
	lw a0,(sp)
	lw ra 4(sp)
	addi sp,sp,8
	ret			#restaura pilha
	
getNumberImage:		#recebe em a0 o int do numero, retorna o endereco da imagem
	li t0,0
	beq a0,t0,ZERO
	
	addi t0,t0,1
	beq a0,t0,Um
	
	addi t0,t0,1
	beq a0,t0,Dois
	
	addi t0,t0,1
	beq a0,t0,Tres
	
	addi t0,t0,1
	beq a0,t0,Quatro
	
	addi t0,t0,1
	beq a0,t0,Cinco
	
	addi t0,t0,1
	beq a0,t0,Seis
	
	addi t0,t0,1
	beq a0,t0,Sete
	
	addi t0,t0,1
	beq a0,t0,Oito
	
	la a0, nove
	ret
ZERO:
	la a0,Zero
	ret
Um:
	la a0,um
	ret
Dois:
	la a0,dois
	ret
Tres:
	la a0,tres
	ret
	
Quatro:
	la a0,quatro
	ret
Cinco:
	la a0,cinco
	ret
Seis:
	la a0,seis
	ret
Sete:
	la a0,sete
	ret
Oito:
	la a0,oito
	ret
