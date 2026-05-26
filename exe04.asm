.data

n: .word 5
r: .word 0
vetor: .word 1 2 3 4 5	#word tem 4 bytes

.text
	# n -> $t0 
	# i -> $s0
	# r -> $t1
	# p (ponteiro para o vetor) -> $t2 
main:
	lw $t0, n		#$t0 = n carregando da memoria
	move $s0, $zero 	# i = 0
	lw $t1, r 		# r = 0
	la $t2, vetor		# p = $vetor[0]
loop:
	bge $s0, $t0, end
	lw $a3, ($t2)
	
	add $s1, $s1, $a3
	add $t2, $t2, 4
	add  $s0, $s0, 1
	
	b loop
 end:	
 	sw $s1, r
	
	div $s1, $t0
	mflo $t1
	
 	move $a0, $t1
 	li $v0, 1
 	syscall
 	
 	li $v0, 10
 	syscall
