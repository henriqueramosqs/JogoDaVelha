
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




<<<<<<< HEAD

=======
>>>>>>> 36c6e28 (preaparing to merge)
matriz: .byte 	
		0,0,0
		0,0,0,
		0,0,0,

		
frame_zero: .word 0xFF000000
frame_one:  .word 0xFF100000

.text	
Start:
	li a1, 0
	li a2,0
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
<<<<<<< HEAD
	addi s1,s1,1
=======
	addi s10,s10,1
>>>>>>> 36c6e28 (preaparing to merge)
drawMenuOptions:				#s10 armazena o nivel da dificuldade(0 - fácil, 1 - médio, 2 - difícil)
	rem s1,s1,t3
	li t0,0
	li t1,1
	beq s1,t0,firstMenuOption
	beq s1,t1,secondMenuOption
	
	la a0,UnselectedEasyLevel	# nível difícil selecionado
	li s10, 2 
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
	li s10, 0 
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
	li s10, 1
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
	
startGame:
	li s1,0	 	# s1 maraca pontuação do jogador
	li s2,0		# s2 marca a pontuação da máquina
	li s7,0 		# s7 marca quantidade total de partidas até então
	li s8,9		# s8 marca quantidade máxima de jogadas
startRound:
	li s3,0 		# s3 marca a posição do no eixo x do jogador
	li s4,0		# s4 marca a posição do no eixo y do jogador
	li s9,0		# s9 marca contador de jogadas por partida
	li s11,0		# s11 marca quem é o jogador atual (s11 impar = player, s11 par = IA)
	
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
	#li s6, 0 #teste, logo
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
doesntChange:	#s11 armazena o numero atual da jogada

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
	jal markPositionX
	
	mv a5, a0	#a5 guarda a posição anterior do X
	
	addi, s11, s11, 1
	
	li t3, 2
	rem t2, s11, t3 
	
	beq t2, zero, printOsymbol
	la a0,X
	li s6,0

	j paintPosition
	
	addi s9,s9,1
	beq s9,s8,velha
	
notPicking:
	la a0,MarkedSelection
	li s6,1	#s6 marca se o item anterior tinha sido destacado
paintPosition:
	addi sp, sp, -4
	sw a0, 0(sp)

	lw a3,frame_zero
	jal drawImage
	
	li a0, 'x' #checa se usuário é vencedor
	jal checkWin
	bne a0,zero,userWon #se for o caso
	
	lw a0, 0(sp)
	addi sp, sp, 4
	
	li t0, 111
	
	beq t0, a4, checkAIwin
	
	jal machineTurn		#descomentar a linha apos o debug
	
	li a0, 'o' #checa se máquina é vencedor
	jal checkWin
	bne a0,zero,machineWon
	addi s9,s9,1
	beq s9,s8,velha
	
	j gameLoop

paintPositionForO:
	lw a3,frame_zero
	jal drawImage
	
	checkAIwin:
	li a0, 'o' #checa se máquina é vencedor
	jal checkWin
	bne a0,zero,machineWon
	addi s9,s9,1
	beq s9,s8,velha
	
	j gameLoop

printOsymbol:
	la a0,O
	li s6,0
	j paintPositionForO
<<<<<<< HEAD



=======
>>>>>>> 36c6e28 (preaparing to merge)
	
	
#se der errado, cole aqui abaixo todo o codigo de preventPlayerWin
	
machineTurn:
	li t0, 2
	rem t0, s11, t0
	beq t0, zero, gameLoop
	
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)
	
	# lb t0, (t1)
	#bne t0, t2, nextIterationLabel	
	
	addi s11, s11, 1
	li t0, 1
	li t1, 2
	beq s11, t1, checkOpeningMovement	#checa qual tipo de abertura foi utilizada pelo player X
	
<<<<<<< HEAD
	jal checkCanAIWin		#checa se a IA pode vencer na próxima jogada
=======
	#jal checkCanIWin		#checa se a IA pode vencer na próxima jogada
>>>>>>> 36c6e28 (preaparing to merge)
	
	jal blockPlayerWin
	
	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp, 8

	ret

retMachineTurn:
	ret
<<<<<<< HEAD

#################################################################################################################
#Procedimentos para checar se IA pode vencer na próxima rodada
#################################################################################################################

checkCanAIWin:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv t0, a6
	jal checkAIPreviousPosition
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

checkAIPreviousPosition:
	addi sp, sp, -16
	sw s1, 0(sp)
	sw s2, 4(sp)
	sw s3, 8(sp)
	sw ra, 12(sp)
	
	li s1, 0
	li s2, 1
	li s3, 2
	li t1, 3
	li t2, 4
	li t3, 5
	li t4, 6
	li t5, 7
	li t6, 8
	
	beq t0, s1, AIposition0
	beq t0, s2, AIposition1
	beq t0, s3, AIposition2
	beq t0, t1, AIposition3
	beq t0, t2, AIposition4
	beq t0, t3, AIposition5
	beq t0, t4, AIposition6
	beq t0, t5, AIposition7
	beq t0, t6, AIposition8
	
	lw s1, 0(sp)
	lw s2, 4(sp)
	lw s3, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	
	ret

AIposition0:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	
	checkWinLinePos0:
	lb t2, 0(t1)
	lb t3, 1(t1)
	lb t4, 2(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos0
	
	beq t3, zero, inLinePos0InsertPos1
	beq t4, zero, inLinePos0InsertPos2
	
	inLinePos0InsertPos1:
	li s3, 1
	li s4, 0
	jal setOinBoard
	inLinePos0InsertPos2:
	li s3, 2
	li s4, 0
	jal setOinBoard
	
	######################
	
	checkWinColummPos0:
	lb t2, 0(t1)
	lb t3, 3(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinDiagonalmPos0
	
	beq t3, zero, inColummPos0InsertPos3
	beq t4, zero, inColummPos0InsertPos6
	
	inColummPos0InsertPos3:
	li s3, 0
	li s4, 1
	jal setOinBoard
	inColummPos0InsertPos6:
	li s3, 0
	li s4, 2
	jal setOinBoard
	
	######################
	
	checkWinDiagonalmPos0:
	lb t2, 0(t1)
	lb t3, 4(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t3, zero, inDiagonalPos0InsertPos4
	beq t4, zero, inDiagonalPos0InsertPos8
	
	inDiagonalPos0InsertPos4:
	li s3, 1
	li s4, 1
	jal setOinBoard
	
	inDiagonalPos0InsertPos8:
	li s3, 2
	li s4, 2
	jal setOinBoard
	

AIposition4:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	checkWinLinePos4:
	lb t2, 3(t1)
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos4
	
	beq t2, zero, inLinePos4InsertPos3
	beq t4, zero, inLinePos4InsertPos5
	
	inLinePos4InsertPos3:
	li s3, 0
	li s4, 1
	jal setOinBoard
	inLinePos4InsertPos5:
	li s3, 2
	li s4, 1
	jal setOinBoard
	
	######################
	
	checkWinColummPos4:
	lb t2, 1(t1)
	lb t3, 4(t1)
	lb t4, 7(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinDiagonalmPrincipalPos4
	
	beq t2, zero, inColummPos4InsertPos1
	beq t4, zero, inColummPos4InsertPos7
	
	inColummPos4InsertPos1:
	li s3, 1
	li s4, 0
	jal setOinBoard
	inColummPos4InsertPos7:
	li s3, 1
	li s4, 2
	jal setOinBoard
	
	######################
	
	checkWinDiagonalmPrincipalPos4:
	lb t2, 0(t1)
	lb t3, 4(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinDiagonalmSecundarialPos4
	
	beq t2, zero, inDiagonalPrincipalPos4InsertPos0
	beq t4, zero, inDiagonalPrincipalPos4InsertPos8
	
	inDiagonalPrincipalPos4InsertPos0:
	li s3, 0
	li s4, 0
	jal setOinBoard
	
	inDiagonalPrincipalPos4InsertPos8:
	li s3, 2
	li s4, 2
	jal setOinBoard	
			
	######################
			
	checkWinDiagonalmSecundariaPos4:
	lb t2, 2(t1)
	lb t3, 4(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t2, zero, inDiagonalSecundariaPos4InsertPos2
	beq t4, zero, inDiagonalSecundariaPos4InsertPos6
	
	inDiagonalSecundariaPos4InsertPos2:
	li s3, 0
	li s4, 2
	jal setOinBoard
	
	inDiagonalSecundariaPos4InsertPos6:
	li s3, 2
	li s4, 2
	jal setOinBoard	
	
	
	
AIposition8:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	checkWinLinePos8:
	lb t2, 6(t1)
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos8
	
	beq t2, zero, inLinePos8InsertPos6
	beq t3, zero, inLinePos8InsertPos7
	
	inLinePos8InsertPos6:
	li s3, 0
	li s4, 2
	jal setOinBoard
	inLinePos8InsertPos7:
	li s3, 1
	li s4, 2
	jal setOinBoard
	
	######################
	
	checkWinColummPos8:
	lb t2, 2(t1)
	lb t3, 5(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinDiagonalmPos8
	
	beq t2, zero, inColummPos8InsertPos2
	beq t3, zero, inColummPos8InsertPos5
	
	inColummPos8InsertPos2:
	li s3, 2
	li s4, 0
	jal setOinBoard
	inColummPos8InsertPos5:
	li s3, 1
	li s4, 2
	jal setOinBoard
	
	######################
	
	checkWinDiagonalmPos8:
	lb t2, 0(t1)
	lb t3, 4(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t2, zero, inDiagonalPos8InsertPos0
	beq t3, zero, inDiagonalPos8InsertPos4
	
	inDiagonalPos8InsertPos0:
	li s3, 0
	li s4, 0
	jal setOinBoard
	
	inDiagonalPos8InsertPos4:
	li s3, 1
	li s4, 1
	jal setOinBoard


AIposition2:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	checkWinLinePos2:
	lb t2, 2(t1)
	lb t3, 4(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos2
	
	beq t3, zero, inLinePos2InsertPos4
	beq t4, zero, inLinePos2InsertPos6
	
	inLinePos2InsertPos4:
	li s3, 1
	li s4, 1
	jal setOinBoard
	inLinePos2InsertPos6:
	li s3, 0
	li s4, 2
	jal setOinBoard
	
	######################
	
	checkWinColummPos2:
	lb t2, 2(t1)
	lb t3, 5(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinDiagonalmPos2
	
	beq t3, zero, inColummPos2InsertPos5
	beq t4, zero, inColummPos2InsertPos8
	
	inColummPos2InsertPos5:
	li s3, 2
	li s4, 1
	jal setOinBoard
	inColummPos2InsertPos8:
	li s3, 2
	li s4, 2
	jal setOinBoard
	
	######################
	
	checkWinDiagonalmPos2:
	lb t2, 2(t1)
	lb t3, 4(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t3, zero, inDiagonalPos2InsertPos4
	beq t4, zero, inDiagonalPos2InsertPos6
	
	inDiagonalPos2InsertPos4:
	li s3, 1
	li s4, 1
	jal setOinBoard
	
	inDiagonalPos2InsertPos6:
	li s3, 0
	li s4, 2
	jal setOinBoard


AIposition6:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	checkWinLinePos6:
	lb t2, 6(t1)
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos6
	
	beq t3, zero, inLinePos6InsertPos7
	beq t4, zero, inLinePos6InsertPos8
	
	inLinePos6InsertPos7:
	li s3, 1
	li s4, 2
	jal setOinBoard
	inLinePos6InsertPos8:
	li s3, 2
	li s4, 2
	jal setOinBoard
	
	######################
	
	checkWinColummPos6:
	lb t2, 0(t1)
	lb t3, 3(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinDiagonalmPos6
	
	beq t2, zero, inColummPos6InsertPos0
	beq t3, zero, inColummPos6InsertPos3
	
	inColummPos6InsertPos0:
	li s3, 0
	li s4, 0
	jal setOinBoard
	inColummPos6InsertPos3:
	li s3, 0
	li s4, 1
	jal setOinBoard
	
	######################
	
	checkWinDiagonalmPos6:
	lb t2, 2(t1)
	lb t3, 4(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t2, zero, inDiagonalPos6InsertPos2
	beq t3, zero, inDiagonalPos6InsertPos4
	
	inDiagonalPos6InsertPos2:
	li s3, 2
	li s4, 0
	jal setOinBoard
	
	inDiagonalPos6InsertPos4:
	li s3, 1
	li s4, 1
	jal setOinBoard



AIposition1:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	checkWinLinePos1:
	lb t2, 0(t1)
	lb t3, 1(t1)
	lb t4, 2(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos1
	
	beq t2, zero, inLinePos1InsertPos0
	beq t4, zero, inLinePos1InsertPos2
	
	inLinePos1InsertPos0:
	li s3, 0
	li s4, 0
	jal setOinBoard
	inLinePos1InsertPos2:
	li s3, 2
	li s4, 0
	jal setOinBoard
	
	######################
	
	checkWinColummPos1:
	lb t2, 1(t1)
	lb t3, 4(t1)
	lb t4, 7(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t3, zero, inColummPos1InsertPos4
	beq t4, zero, inColummPos1InsertPos7
	
	inColummPos1InsertPos4:
	li s3, 0
	li s4, 1
	jal setOinBoard
	inColummPos1InsertPos7:
	li s3, 1
	li s4, 2
	jal setOinBoard


AIposition3:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	checkWinLinePos3:
	lb t2, 3(t1)
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos3
	
	beq t3, zero, inLinePos3InsertPos4
	beq t4, zero, inLinePos3InsertPos5
	
	inLinePos3InsertPos4:
	li s3, 1
	li s4, 1
	jal setOinBoard
	inLinePos3InsertPos5:
	li s3, 2
	li s4, 1
	jal setOinBoard
	
	######################
	
	checkWinColummPos3:
	lb t2, 0(t1)
	lb t3, 3(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t2, zero, inColummPos3InsertPos0
	beq t4, zero, inColummPos3InsertPos6
	
	inColummPos3InsertPos0:
	li s3, 0
	li s4, 0
	jal setOinBoard
	inColummPos3InsertPos6:
	li s3, 0
	li s4, 2
	jal setOinBoard
	
	

AIposition5:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	checkWinLinePos5:
	lb t2, 3(t1)
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos5
	
	beq t2, zero, inLinePos5InsertPos3
	beq t3, zero, inLinePos5InsertPos4
	
	inLinePos5InsertPos3:
	li s3, 0
	li s4, 1
	jal setOinBoard
	inLinePos5InsertPos4:
	li s3, 1
	li s4, 1
	jal setOinBoard
	
	######################
	
	checkWinColummPos5:
	lb t2, 2(t1)
	lb t3, 5(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t2, zero, inColummPos5InsertPos2
	beq t4, zero, inColummPos5InsertPos8
	
	inColummPos5InsertPos2:
	li s3, 2
	li s4, 0
	jal setOinBoard
	inColummPos5InsertPos8:
	li s3, 2
	li s4, 2
	jal setOinBoard
	
	

AIposition7:
	la t1, matriz
	jal restoreRegisterValues
	######################
	
	checkWinLinePos7:
	lb t2, 6(t1)
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, checkWinColummPos7
	
	beq t2, zero, inLinePos7InsertPos6
	beq t4, zero, inLinePos7InsertPos8
	
	inLinePos7InsertPos6:
	li s3, 0
	li s4, 2
	jal setOinBoard
	inLinePos7InsertPos8:
	li s3, 2
	li s4, 2
	jal setOinBoard
	
	######################
	
	checkWinColummPos7:
	lb t2, 1(t1)
	lb t3, 4(t1)
	lb t4, 7(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 222
	bne t6, t5, returnToMachineTurn
	
	beq t2, zero, inColummPos7InsertPos1
	beq t3, zero, inColummPos7InsertPos4
	
	inColummPos7InsertPos1:
	li s3, 1
	li s4, 0
	jal setOinBoard
	inColummPos7InsertPos4:
	li s3, 1
	li s4, 1
	jal setOinBoard
	
returnToMachineTurn:
	lw ra, 4(sp)
	addi sp, sp, 4
	ret
=======
	
>>>>>>> 36c6e28 (preaparing to merge)
#################################################################################################################
#Começo dos procedimentos para checar se o Player pode vencer na proxima jogada, a IA deverá realizar um bloqueio
#################################################################################################################

blockPlayerWin:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv t0, a5
	jal checkLinePlayer
	jal checkColummPlayer
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret
						#
						# Checagem da diagonal
						#

<<<<<<< HEAD
setOinBoard:
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

=======
>>>>>>> 36c6e28 (preaparing to merge)
diagonalPosition0:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 4(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

diagonalPlotOPos0:
	beq t3, zero, InDiagonalPos0insertPosition4
	beq t4, zero, InDiagonalPos0insertPosition8
	
	InDiagonalPos0insertPosition4:
	li s3, 1
	li s4, 1

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InDiagonalPos0insertPosition8:
	li s3, 2
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
diagonalPosition4:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 4(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

diagonalPlotOPos4:
	beq t2, zero, InDiagonalPos4insertPosition0
	beq t4, zero, InDiagonalPos4insertPosition8
	
	InDiagonalPos4insertPosition0:
	li s3, 0
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InDiagonalPos4insertPosition8:
	li s3, 2
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
diagonalPosition8:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 4(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

diagonalPlotOPos8:
	beq t2, zero, InDiagonalPos8insertPosition0
	beq t3, zero, InDiagonalPos8insertPosition4
	
	InDiagonalPos8insertPosition0:
	li s3, 0
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InDiagonalPos8insertPosition4:
	li s3, 1
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

diagonalPosition2:
	la t1, matriz
	lb t2, 2(t1) 
	lb t3, 4(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

diagonalPlotOPos2:
	beq t3, zero, InDiagonalPos2insertPosition4
	beq t4, zero, InDiagonalPos2insertPosition6
	
	InDiagonalPos2insertPosition4:
	li s3, 1
	li s4, 1

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InDiagonalPos2insertPosition6:
	li s3, 0
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	
diagonalPosition6:
	la t1, matriz
	lb t2, 2(t1) 
	lb t3, 4(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

diagonalPlotOPos6:
	beq t2, zero, InDiagonalPos6insertPosition2
	beq t3, zero, InDiagonalPos6insertPosition4
	
	InDiagonalPos6insertPosition2:
	li s3, 2
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InDiagonalPos6insertPosition4:
	li s3, 1
	li s4, 1
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
						#
						# Checagem das colunas
						#
checkColummPlayer:	
	addi sp, sp, -16
	sw s1, 0(sp)
	sw s2, 4(sp)
	sw s3, 8(sp)
	sw ra, 12(sp)
	
	li s1, 0
	li s2, 1
	li s3, 2
	li t1, 3
	li t2, 4
	li t3, 5
	li t4, 6
	li t5, 7
	li t6, 8
	
	beq t0, s1, colummPosition0
	beq t0, s2, colummPosition1
	beq t0, s3, colummPosition2
	beq t0, t1, colummPosition3
	beq t0, t2, colummPosition4
	beq t0, t3, colummPosition5
	beq t0, t4, colummPosition6
	beq t0, t5, colummPosition7
	beq t0, t6, colummPosition8
	
	lw s1, 0(sp)
	lw s2, 4(sp)
	lw s3, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	
	ret

colummPosition0:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 3(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, diagonalPosition0

colummPlotOPos0:
	beq t3, zero, InColummPos0insertPosition3
	beq t4, zero, InColummPos0insertPosition6
	
	InColummPos0insertPosition3:
	li s3, 0
	li s4, 1

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos0insertPosition6:
	li s3, 0
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
colummPosition3:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 3(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

colummPlotOPos3:
	beq t2, zero, InColummPos3insertPosition0
	beq t4, zero, InColummPos3insertPosition6
	
	InColummPos3insertPosition0:
	li s3, 0
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos3insertPosition6:
	li s3, 0
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

colummPosition6:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 3(t1)
	lb t4, 6(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, diagonalPosition6

colummPlotOPos6:
	beq t2, zero, InColummPos6insertPosition0
<<<<<<< HEAD
	beq t3, zero, InColummPos6insertPosition3
=======
	beq t4, zero, InColummPos6insertPosition3
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos6insertPosition0:
	li s3, 0
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos6insertPosition3:
	li s3, 0
	li s4, 1
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

colummPosition1:
	la t1, matriz
	lb t2, 1(t1) 
	lb t3, 4(t1)
	lb t4, 7(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

colummPlotOPos1:
	beq t2, zero, InColummPos1insertPosition4
	beq t4, zero, InColummPos1insertPosition7
	
	InColummPos1insertPosition4:
	li s3, 1
	li s4, 1

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos1insertPosition7:
	li s3, 1
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

colummPosition4:
	la t1, matriz
	lb t2, 1(t1) 
	lb t3, 4(t1)
	lb t4, 7(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, diagonalPosition4

colummPlotOPos4:
	beq t2, zero, InColummPos4insertPosition1
	beq t4, zero, InColummPos4insertPosition7
	
	InColummPos4insertPosition1:
	li s3, 1
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos4insertPosition7:
	li s3, 1
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

colummPosition7:
	la t1, matriz
	lb t2, 1(t1) 
	lb t3, 4(t1)
	lb t4, 7(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

colummPlotOPos7:
	beq t2, zero, InColummPos7insertPosition1
	beq t4, zero, InColummPos7insertPosition4
	
	InColummPos7insertPosition1:
	li s3, 1
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos7insertPosition4:
	li s3, 1
	li s4, 1
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
colummPosition2:
	la t1, matriz
	lb t2, 2(t1) 
	lb t3, 5(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, diagonalPosition2

colummPlotOPos2:
	beq t2, zero, InColummPos2insertPosition5
	beq t4, zero, InColummPos2insertPosition8
	
	InColummPos2insertPosition5:
	li s3, 2
	li s4, 1

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos2insertPosition8:
	li s3, 2
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

colummPosition5:
	la t1, matriz
	lb t2, 2(t1) 
	lb t3, 5(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, gameLoop

colummPlotOPos5:
	beq t2, zero, InColummPos5insertPosition2
	beq t4, zero, InColummPos5insertPosition8
	
	InColummPos5insertPosition2:
	li s3, 2
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos5insertPosition8:
	li s3, 2
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
colummPosition8:
	la t1, matriz
	lb t2, 2(t1) 
	lb t3, 5(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	#jal restoreRegisterValues
	bne t5, t6, diagonalPosition8

colummPlotOPos8:
	beq t2, zero, InColummPos8insertPosition2
<<<<<<< HEAD
	beq t3, zero, InColummPos8insertPosition5
=======
	beq t4, zero, InColummPos8insertPosition5
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos8insertPosition2:
	li s3, 2
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InColummPos8insertPosition5:
	li s3, 2
	li s4, 1
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
						#
						# Checagem das linhas
						#
checkLinePlayer:
	addi sp, sp, -16
	sw s1, 0(sp)
	sw s2, 4(sp)
	sw s3, 8(sp)
	sw ra, 12(sp)
	
	li s1, 0
	li s2, 1
	li s3, 2
	li t1, 3
	li t2, 4
	li t3, 5
	li t4, 6
	li t5, 7
	li t6, 8
	
	beq t0, s1, linePosition0
	beq t0, s2, linePosition1
	beq t0, s3, linePosition2
	beq t0, t1, linePosition3
	beq t0, t2, linePosition4
	beq t0, t3, linePosition5
	beq t0, t4, linePosition6
	beq t0, t5, linePosition7
	beq t0, t6, linePosition8
	
	lw s1, 0(sp)
	lw s2, 4(sp)
	lw s3, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	
	ret
	
	
linePosition0:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 1(t1)
	lb t4, 2(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition0

plotOPos0:
	beq t3, zero, InPos0insertPosition1
	beq t4, zero, InPos0insertPosition2
	
	InPos0insertPosition1:
	li s3, 1
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos0insertPosition2:
	li s3, 2
	li s4, 0
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

linePosition1:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 1(t1)
	lb t4, 2(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition1
	
plotOPos1:
	beq t2, zero, InPos1insertPosition0
	beq t4, zero, InPos1insertPosition2
	
	InPos1insertPosition0:
	li s3, 0
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos1insertPosition2:
	li s3, 2
	li s4, 0
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

linePosition2:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 1(t1)
	lb t4, 2(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition2
	
plotOPos2:
	beq t2, zero, InPos2insertPosition0
	beq t3, zero, InPos2insertPosition1
	
	InPos2insertPosition0:
	li s3, 0
	li s4, 0

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos2insertPosition1:
	li s3, 1
	li s4, 0
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

linePosition3:
	la t1, matriz
	lb t2, 3(t1) 
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition3
	
plotOPos3:
	beq t3, zero, InPos3insertPosition1
	beq t4, zero, InPos3insertPosition2
	
	InPos3insertPosition1:
	li s3, 1
	li s4, 1

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos3insertPosition2:
	li s3, 2
	li s4, 1
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

linePosition4:
	la t1, matriz
	lb t2, 3(t1) 
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition4
	
plotOPos4:
	beq t2, zero, InPos4insertPosition0
	beq t4, zero, InPos4insertPosition2
	
	InPos4insertPosition0:
	li s3, 0
	li s4, 1

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos4insertPosition2:
	li s3, 2
	li s4, 1
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

linePosition5:
	la t1, matriz
	lb t2, 3(t1) 
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition5
	
plotOPos5:
	beq t2, zero, InPos5insertPosition0
	beq t3, zero, InPos5insertPosition1
	
	InPos5insertPosition0:
	li s3, 0
	li s4, 1

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos5insertPosition1:
	li s3, 1
	li s4, 1
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

linePosition6:
	la t1, matriz
	lb t2, 6(t1) 
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition6
	
plotOPos6:
	beq t3, zero, InPos6insertPosition1
	beq t4, zero, InPos6insertPosition2
	
	InPos6insertPosition1:
	li s3, 1
	li s4, 2

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos6insertPosition2:
	li s3, 2
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

linePosition7:
	la t1, matriz
	lb t2, 6(t1) 
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition7
	
plotOPos7:
	beq t2, zero, InPos7insertPosition0
	beq t4, zero, InPos7insertPosition2
	
	InPos7insertPosition0:
	li s3, 0
	li s4, 2

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos7insertPosition2:
	li s3, 2
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
linePosition8:
	la t1, matriz
	lb t2, 6(t1) 
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, colummPosition8
	
plotOPos8:
	beq t2, zero, InPos8insertPosition0
	beq t3, zero, InPos8insertPosition1
	
	InPos8insertPosition0:
	li s3, 0
	li s4, 2

<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)
	
	InPos8insertPosition1:
	li s3, 1
	li s4, 2
	
<<<<<<< HEAD
	jal setOinBoard
=======
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
>>>>>>> 36c6e28 (preaparing to merge)

retToBlockPlayerWin:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

restoreRegisterValues:
	lw s1, 0(sp)
	lw s2, 4(sp)
	lw s3, 8(sp)
	addi sp, sp, 12
	ret

#################################################################################################################
#Fim do procedimento de checagem da possibilidade de vitória de X
#################################################################################################################
		

checkCanIWin:
	mv t0, a4
	jal checkLineAI

checkLineAI:
	la t1, matriz
	#addi t1, t1, t0
	

	
checkOpeningMovement:
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)
	
	
	
	la t1, matriz
	li t2, 120
	li t3, 0
	li t4, 0		#mantém controle da posição em que o primeiro X foi encontrado
	
	findFirstXPosition:	
	lb t3, 0(t1)
	addi t1, t1, 1
	addi t4, t4, 1
	bne t3, t2, findFirstXPosition 
	
	li t2, 1	
	sub t2, t4, t2	#t2 = posicao do X
	
	li t3, 4		#caso a primeira jogada seja no meio, a IA jogará no canto
	li a0, 0
	beq t2, t3, plotInTheCorner
	
	li a0, 4
	li t3, 2
	rem t3, t2, t3
	beq t3, zero, plotInTheCenter 
	
	j plotInTheCenter
	
	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp, 8
	
	ret

plotInTheCorner:
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)

	li s3, 0
	li s4, 0
	
	jal calculateXCoordinate
	mv a1, a0
	
	jal calculateYCoordinate
	mv a2, a0
	
	jal markPositionO
	mv a4, a0 	#registrador a4 guarda a posição antiga da IA (pra checar se ela pode vencer na proxima jogada)
	
	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp, 8
	
	j printOsymbol
	
plotInTheCenter:
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)
	
	li s3, 1
	li s4, 1
	
	jal calculateXCoordinate
	mv a1, a0
	
	jal calculateYCoordinate
	mv a2, a0
	
	jal markPositionO
	mv a4, a0 	#registrador a4 guarda a posição antiga da IA (pra checar se ela pode vencer na proxima jogada)
	
	
	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp, 8
	
	j printOsymbol




userWon:
	addi s1,s1,1 # incrementa pontuacao do jogador
	addi s7,s7,1 # incrementa a quantidade de partidas até então
	
	li t0,5				#condicionais de contagem
	beq s1,t0,userWonInTotal
	li t0,20
	beq s7,t0,velhaInTotal
	j startRound  			#começa outro jogo
machineWon:
	addi s2,s2,1	#incrementa pontuação da máquina
	addi s7,s7,1 # incrementa a quantidade de partidas até então
	
	li t0,5				#condicionais de contagem
	beq s2,t0,machineWonInTotal
	li t0,20
	beq s7,t0,velhaInTotal
	j startRound 
velha:
	addi s7,s7,1 # incrementa a quantidade de partidas até então
	li t0,20
	beq s7,t0,velhaInTotal
	j startRound
  

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
	
	#para fins de debug, a tecla 3 (ascii 51) sera usada pra encerrar o programa, apague depois 
	li t2, 51
	beq a0, t2, endProgram
	ret	

endProgram:
	li a7, 10
	ecall

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
	
markPositionX:	# s3= pos_x, s4=pos_y, marca item correspondente à posicao na matriz
	li t0,3
	mul t0,t0,s4
	add t0,t0,s3
	la t1,matriz
	add t1,t1,t0
	
	mv a0, t0
	
	li t0, 'x'
	sb t0,(t1)	
	ret

markPositionO:
	li t0,3
	mul t0,t0,s4
	add t0,t0,s3
	la t1,matriz
	add t1,t1,t0
	
	mv a0, t0	#guarda a posição antiga da bolinha em a0
	
<<<<<<< HEAD
	mv a6, t0	
=======
>>>>>>> 36c6e28 (preaparing to merge)
	li t0, 'o'
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
	li a1, 255
	li a2,30	
	jal drawImage		#printa primeiro dígito da máquina

	li t0,10	
	rem a0,s2,t0	#a0 = segundo dígito da máquina
	
	jal getNumberImage
	lw a3, frame_zero
	li a1, 270
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
