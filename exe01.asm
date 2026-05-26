.data

n: .word 6
r: .word 0

.text
	# n -> $t0
	# i -> $t1
	# r -> $t2
main:
	li $t1, 0 	# i = 0
	lw $t0, n	# $t0 = n carregando da memoria
	lw $t2, r	# $t2 = r carregando da memoria
loop:
	# if (i <= n) executa o loop
	#else vai para o end
	
	#if( i > n) vai para o end
	#else executa o loop
	
	bgt $t1, $t0, end #if(i > n) goto end
	add $t2, $t2, $t1
	#i++
	
	add $t1, $t1, 1
	b loop #goto loop
end:

	sw $t2, r

	#print r
	move $a0, $t2
	li $v0, 1
	syscall

	li $v0, 10
	syscall 


