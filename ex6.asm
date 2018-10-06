		.data
vetor: .space 12
print:	.asciiz "Valores armazenados:\n"
printEnter: .asciiz "\n"
		.text

main:
		la $t0, vetor #pega o endereço inicial do vetor na memoria e atribui para $t0
		
		#grava valor 10 na primeira posicão do vetor
		li $t1, 10
		sw $t1, 0($t0)

		#grava valor 5 na segunda posicão do vetor
		li $t1, 5
		sw $t1, 4($t0)

		#grava valor 15 na terceira posicão do vetor
		li $t1, 15
		sw $t1, 8($t0)
	    
	    # acessa o valor de cada posicao do vetor a partir do endereço inicial $t0
		lw $s0, 0($t0)
		lw $s1, 4($t0)
		lw $s2, 8($t0)
	    
	    #sequencia para imprimir uma string na tela
	    li $v0,4 
        la $a0, print
        syscall
        #passado valor 1 identificando uma impressao na tela de interio
        li  $v0, 1 
		move $a0, $s0
		syscall

		#sequencia para imprimir um \n
	    li $v0,4 
        la $a0, printEnter
        syscall

        #passado valor 1 identificando uma impressao na tela de interio
        li  $v0, 1 
		move $a0, $s1
		syscall

		#sequencia para imprimir um \n
	    li $v0,4 
        la $a0, printEnter
        syscall

        #passado valor 1 identificando uma impressao na tela de interio
        li  $v0, 1 
		move $a0, $s2
		syscall

		li  $v0, 10 # faz $v0 = 10 (chamada de sistema exit)
		syscall