.data

msg: .asciiz "ola mundo\n"
newline: .asciiz "\n"
idade: .word 17
resultado: .word 0

.text

main:

	#print msg
	la $a0, msg
	li $v0, 4
	syscall

	#print $t0 ou seja 50
	li $t0, 50
	move $a0, $t0

	li $v0, 1
	syscall 

	#printar nova linha
	la $a0, newline
	li $v0 4
	syscall


	#printar idade e somar mais um

	lw $a0, idade
	li $v0, 1
	syscall

	la $a0, newline
	li $v0 4
	syscall

	lw $a0, idade
	add $a0, $a0, 1
	sw $a0, resultado

	li $v0, 1
	syscall

	#fecha o programa
	li $v0 10
	syscall 