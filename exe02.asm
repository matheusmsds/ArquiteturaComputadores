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
	#if(i >= n) goto end
	bge $s0, $t0, end
	lw $t3, ($t2) 		# $t3 = *p
	add $t1, $t1, $t3	# r += *p
	
	add $t2, $t2, 4 	# para ir para o proximo elemento do vetor deve ser 4, pois o tipo word tem 4 bytes 
				# se colocar 1 não funciona, é apenas 4
			
	add $s0, $s0, 1 #i++
	b loop

end:
sw $t1, r

#print r
move $a0, $t1
li $v0 1
syscall

li $v0, 10
syscall