    .data
printLO: .word 10
b: .word 20
s: .word 0
test: .asciiz "string"

    .text
main:
	lw $t0, a
	lw $t1, data
	add $t0, $t1, $t2
	sw $t2, s
	li $t3, asdds1