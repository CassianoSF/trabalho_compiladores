		.data
print:  	.asciiz "Valor da Soma: "
		.text

main:
		li $s1,-2 #atribui uma constate a $s1
	    li $s2,8 #atribui uma constate a $s2
	    
	    add $s0, $s1, $s2 # soma $s0 = $s1 + $s2

	    #sequencia para imprimir uma string na tela
	    li $v0,4 
        la $a0, print
        syscall

        #passado valor 1 identificando uma impressao na tela de interio
        li  $v0, 1 
		move $a0, $s0 
		syscall

		li  $v0, 10 # faz $v0 = 10 (chamada de sistema exit)
		syscall