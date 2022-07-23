
.data

.include "images_data/Menu.data"
.include "images_data/UnselectedHardLevel.data"
.include "images_data/UnselectedMediumLevel.data"
.include "images_data/UnselectedEasyLevel.data"
.include "images_data/SelectedHardLevel.data"
.include "images_data/SelectedMediumLevel.data"
.include "images_data/SelectedEasyLevel.data"

matriz: .byte 	0,0,0,
		0,0,0,
		0,0,0
		
frame_zero: .word 0xFF000000
frame_one:  .word 0xFF100000

screen_width: .word 320
screen_height: .word 240
.text
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
	
	li a7,10
	ecall

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
		
	addi a0,a0,8	# muda a0 para o endereço inicial das cores
	li t5,0 	# t5 é um marcador de passos à direita

drawLoop:
	beq t2,t3,finishDraw # se endereço atual = endereço final, finaliza pintura
	bne t5,t0, keepDraw
	
	addi t2,t2,320		#muda t2 para primeira posição da linha debaixo
	sub t2,t2,t0	
	add t5,zero,zero
keepDraw:
	lb t6,(a0) # t6 carrega coloração do pixel
	sb t6,0(t2)
	addi t2,t2,1  # muda para póximo endereço
	addi t5,t5,1  #passa o contador de passos para a direita
	addi a0,a0,1
	j drawLoop
finishDraw:
	ret

	
