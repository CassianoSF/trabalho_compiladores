		.data
printLO:  	.asciiz "Inteiro: "
multipli:   .asciiz "Multiplicacao: \n"
divisao:   .asciiz "Divisao: \n"
newline: 	.asciiz "\n"
printHI:	.asciiz "Resto: "
buffer: .space 20
		.text

main:
		li $s0, 7
		li $s1, 5
labelMult: #INICIO MULTIPLICACAO

		mult $s1, $s0
		mflo $t0
		mfhi $t1

		li  $v0, 4 #passado valor 4 identificando uma impressao na tela de string
		la $a0, multipli #valor que sera impresso
		syscall

		li  $v0, 4 
		la $a0, printLO 
		syscall

		li  $v0, 1 #passado valor 1 identificando uma impressao na tela de interio
		move $a0, $t0 
		syscall
		
		li  $v0, 4 
		la $a0, newline 
		syscall

		

		li  $v0, 4 
		la $a0, printHI 
		syscall

		li  $v0, 1 
		move $a0, $t1 
		syscall



labelDiv:	#INICIO DIVISAO
		
		div $s0, $s1
		mflo $t0
		mfhi $t1

		
		li  $v0, 4 
		la $a0, newline 
		syscall

		li  $v0, 4 
		la $a0, newline 
		syscall

		li  $v0, 4 
		la $a0, divisao 
		syscall

		li  $v0, 4 
		la $a0, printLO 
		syscall

		li  $v0, 1 
		move $a0, $t0 
		syscall
		
		li  $v0, 4 
		la $a0, newline 
		syscall

		li  $v0, 4 
		la $a0, printHI 
		syscall

		li  $v0, 1 
		move $a0, $t1 
		syscall
		
labelExit:
		li  $v0, 10 # faz $v0 = 10 (chamada de sistema exit)
		syscall