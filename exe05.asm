.data
    n:      .word 4
    vetor:  .space 16       # Aloca espaço na memória para 4 inteiros (4*4=16 bytes)
    traco:  .asciiz "-"
    pula:   .asciiz "\n"

.text

main:
    lw $t0, n
    la $t1, vetor
    li $t2, 1               # i = 1 (começa de 1 até n)

loop_quadrados:
    bgt $t2, $t0, fim
    
    mul $t3, $t2, $t2       # $t3 = i * i (quadrado perfeito)
    sw $t3, 0($t1)          # Salva no vetor na memória
    
    # --- Saída formatada no Terminal ---
    li $v0, 1
    move $a0, $t2           # Imprime i
    syscall
    
    li $v0, 4
    la $a0, traco           # Imprime "-"
    syscall
    
    li $v0, 1
    move $a0, $t3           # Imprime i²
    syscall
    
    li $v0, 4
    la $a0, pula            # Quebra de linha
    syscall
    
    # Avança ponteiro e índice
    addi $t1, $t1, 4
    addi $t2, $t2, 1
    j loop_quadrados

fim:
    li $v0, 10
    syscall
