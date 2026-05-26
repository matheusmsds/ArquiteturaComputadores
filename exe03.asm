.data

n: .word 5
vetor1: .word 1 2 3 4 5
vetor2: .word 1 2 3 4 5
vetor3: .word 0 0 0 0 0
espaco: .asciiz " "

.text
		#  i -> $a0
		#  n -> $a1
		#  $t1 -> vetor1
		#  $t2 -> vetor2
		#  $t3 -> vetor3
main:
	#iniciando registradores
	move $a0, $zero
	lw $a1, n
	la $t1, vetor1
	la $t2, vetor2
	la $t3, vetor3
loop:
	# Se i == n, vai para o "preparar_print" para resetar as variáveis antes de imprimir
	beq $a0, $a1, preparar_print
	
	#pegando os valores dos vetores usando ponteiros
	lw $s0, ($t1)
	lw $s1, ($t2)
	
	# somando os valores dos vetores
	add $s3, $s0, $s1 # vetor3[i] = vetor1[i] + vetor2[i]
	
	#guardando a soma dos dois vetores no terceiro vetor
	sw $s3, ($t3)
	
	# CORRIGIDO: alterado de 'add' para 'addi' para somar constantes
	addi $t1, $t1, 4		#vetor1[i]
	addi $t2, $t2, 4		#vetor2[i]
	addi $t3, $t3, 4		#vetor[i]
	
	# fazendo o incremento
	addi $a0, $a0, 1
	#fazendo o while basicamente
	b loop
	
preparar_print:             
	move $t0, $zero         # usar $t0 como o novo 'i' para não quebrar o syscall
	la $t3, vetor3 

printar_vetor:            
	beq $t0, $a1, end       
	
	# Imprime o número
	lw $a0, ($t3)           
	li $v0, 1
	syscall
	
	# Imprime o espaço
	la $a0, espaco
	li $v0, 4
	syscall
	
	# avançando o ponteiro do vetor em 1 em 1
	addi $t3, $t3, 4
	#incrementando o valor de de $t0 = $t0 + 1        
	addi $t0, $t0, 1      
	
	b printar_vetor         


end:
	li $v0, 10
	syscall