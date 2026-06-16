.data
    vetor:  .word 15, 42, 8, 91, 23
    n:      .word 5
    str:    .asciiz "Maior valor do vetor: "

.text
.globl main
main:
    lw $t0, n
    la $t1, vetor
    
    lw $t2, 0($t1)          # Inicializa r com o primeiro elemento vetor[0]
    li $t3, 1               # Começa o índice i em 1
    addi $t1, $t1, 4        # Avança o ponteiro para o segundo elemento

loop_maior:
    beq $t3, $t0, fim_busca
    
    lw $t4, 0($t1)          # Carrega vetor[i]
    
    # Se vetor[i] > maior atual ($t2), atualiza
    bgt $t4, $t2, atualiza_maior
    j proximo

atualiza_maior:
    move $t2, $t4           # maior = vetor[i]

proximo:
    addi $t1, $t1, 4
    addi $t3, $t3, 1
    j loop_maior

fim_busca:
    # Imprime resultado
    li $v0, 4
    la $a0, str
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 10
    syscall
