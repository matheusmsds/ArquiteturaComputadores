.data
n: .word 5
r: .word 0
a: .word 0
vetor: .word 1 2 3 4 5    # Cada word tem 4 bytes

.text
	# $t0 -> n
	# $s0 -> i (contador)
	# $s1 -> acumulador da soma
	# $t2 -> p (ponteiro para o vetor)
	# $a0 -> guardará a média calculada
main:
	lw $t0, n        
	move $s0, $zero  	# i = 0
	move $s1, $zero  	# Inicializa a soma com 0 (importante!)
	la $t2, vetor    	# p = &vetor[0]

loop:
	bge $s0, $t0, media
	lw $a3, ($t2)
	
	add $s1, $s1, $a3	# Soma os elementos
	add $t2, $t2, 4  	# Avança o ponteiro
	add $s0, $s0, 1  	# i++
	b loop

media:	
	sw $s1, r        	# Salva a soma na memória (opcional)
	
	div $s1, $t0     	# Soma / n
	mflo $a0         	# $a0 agora tem a MÉDIA (usamos $a0 direto para o syscall)
	
	li $v0, 1        	# Imprime a média
	syscall

# --- CORREÇÃO AQUI: Resetando para o segundo passo ---
prep_maior:
	move $s0, $zero  	# Reseta i = 0 para o novo loop
	la $t2, vetor    	# Reseta o ponteiro para o início do vetor
	move $t5, $zero  	# Inicializa o contador 'a' (elementos maiores que a média) com 0

maiormedia:	
	bge $s0, $t0, end	# SE i >= n, TERMINA o programa (aponta para 'end')
	lw $a3, ($t2)    	# Carrega o elemento atual
	
	# Se o elemento ($a3) for MAIOR que a média ($a0), vai para 'bah'
	bgt $a3, $a0, maior  
	
skip:
	# Se NÃO for maior, vem para cá, apenas pula a soma e continua o loop
	add $t2, $t2, 4  	# Avança o ponteiro
	add $s0, $s0, 1  	# i++
	b maiormedia     	# Volta para o topo do loop

maior:
	add $t5, $t5, 1  	# Incrementa a quantidade de elementos maiores
	b skip           	# Volta para o fluxo normal (avançar ponteiro e i)

end:	
	sw $t5, a        	# Salva o resultado final em 'a'
	
	move $a0, $t5    	# Copia para $a0 para imprimir
	li $v0, 1        	# Imprime a quantidade de elementos maiores
	syscall
	
	li $v0, 10       	# Finaliza o programa corretamente
	syscall
