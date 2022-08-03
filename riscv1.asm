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
	
	#jal checkCanIWin		#checa se a IA pode vencer na próxima jogada
	
	jal blockPlayerWin
	
	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp, 8

	ret

retMachineTurn:
	ret
#################################################################################################################
#Começo dos procedimentos para checar se o Player pode vencer na proxima jogada, a IA deverá realizar um bloqueio
#################################################################################################################

blockPlayerWin:
	mv t0, a5

checkLinePlayer:
	addi, sp, sp, -16
	sw s1, 0(sp)
	sw s2, 4(sp)
	sw s3, 8(sp)

	li s1, 0
	li s2, 1
	li s3, 2
	li t1, 3
	li t2, 4
	li t3, 5
	li t4, 6
	li t5, 7
	li t6, 8
	
	beq t0, s1, position0
	beq t0, s2, position1
	beq t0, s3, position2
	beq t0, t1, position3
	beq t0, t2, position4
	beq t0, t3, position5
	beq t0, t4, position6
	beq t0, t5, position7
	beq t0, t6, position8
	
position0:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 1(t1)
	lb t4, 2(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop

plotOPos0:
	beq t3, zero, InPos0insertPosition1
	beq t4, zero, InPos0insertPosition2
	
	InPos0insertPosition1:
	li s3, 1
	li s4, 0

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos0insertPosition2:
	li s3, 2
	li s4, 0
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

position1:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 1(t1)
	lb t4, 2(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop
	
plotOPos1:
	beq t2, zero, InPos1insertPosition0
	beq t4, zero, InPos1insertPosition2
	
	InPos1insertPosition0:
	li s3, 0
	li s4, 0

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos1insertPosition2:
	li s3, 2
	li s4, 0
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

position2:
	la t1, matriz
	lb t2, 0(t1) 
	lb t3, 1(t1)
	lb t4, 2(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop
	
plotOPos2:
	beq t2, zero, InPos2insertPosition0
	beq t3, zero, InPos2insertPosition1
	
	InPos2insertPosition0:
	li s3, 0
	li s4, 0

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos2insertPosition1:
	li s3, 1
	li s4, 0
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

position3:
	la t1, matriz
	lb t2, 3(t1) 
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop
	
plotOPos3:
	beq t3, zero, InPos3insertPosition1
	beq t4, zero, InPos3insertPosition2
	
	InPos3insertPosition1:
	li s3, 1
	li s4, 1

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos3insertPosition2:
	li s3, 2
	li s4, 1
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

position4:
	la t1, matriz
	lb t2, 3(t1) 
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop
	
plotOPos4:
	beq t2, zero, InPos4insertPosition0
	beq t4, zero, InPos4insertPosition2
	
	InPos4insertPosition0:
	li s3, 0
	li s4, 1

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos4insertPosition2:
	li s3, 2
	li s4, 1
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

position5:
	la t1, matriz
	lb t2, 3(t1) 
	lb t3, 4(t1)
	lb t4, 5(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop
	
plotOPos5:
	beq t2, zero, InPos5insertPosition0
	beq t3, zero, InPos5insertPosition1
	
	InPos5insertPosition0:
	li s3, 0
	li s4, 1

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos5insertPosition1:
	li s3, 1
	li s4, 1
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

position6:
	la t1, matriz
	lb t2, 6(t1) 
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop
	
plotOPos6:
	beq t3, zero, InPos6insertPosition1
	beq t4, zero, InPos6insertPosition2
	
	InPos6insertPosition1:
	li s3, 1
	li s4, 2

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos6insertPosition2:
	li s3, 2
	li s4, 2
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

position7:
	la t1, matriz
	lb t2, 6(t1) 
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop
	
plotOPos7:
	beq t2, zero, InPos7insertPosition0
	beq t4, zero, InPos7insertPosition2
	
	InPos7insertPosition0:
	li s3, 0
	li s4, 2

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos7insertPosition2:
	li s3, 2
	li s4, 2
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
position8:
	la t1, matriz
	lb t2, 6(t1) 
	lb t3, 7(t1)
	lb t4, 8(t1)
	
	add t5, t2, t3
	add t5, t5, t4
	
	li t6, 240
	jal restoreRegisterValues
	bne t5, t6, gameLoop
	
plotOPos8:
	beq t2, zero, InPos8insertPosition0
	beq t3, zero, InPos8insertPosition1
	
	InPos8insertPosition0:
	li s3, 0
	li s4, 2

	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop
	
	InPos8insertPosition1:
	li s3, 1
	li s4, 2
	
	jal calculateXCoordinate
	mv a1, a0
	jal calculateYCoordinate
	mv a2, a0
	jal markPositionO
	mv a4, a0
	#jal restoreRegisterValues
	
	jal printOsymbol
	j gameLoop

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
