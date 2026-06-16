.data
    vetor:  .word 29, 10, 14, 37, 13
    n:      .word 5
    espaço: .asciiz " "

.text
main:
    lw $t0, n               # $t0 = n
    li $t1, 0               # i = 0 (Loop Externo)

loop_externo:
    # se i >= n - 1, acabou a ordenação
    addi $t8, $t0, -1
    bge $t1, $t8, imprimir_vetor
    
    move $t2, $t1           # min_idx = i
    addi $t3, $t1, 1        # j = i + 1 (Loop Interno)

loop_interno:
    bge $t3, $t0, trocar_elementos
    
    # Calcula endereço de vetor[j] e vetor[min_idx]
    la $s0, vetor
    sll $t4, $t3, 2         # j * 4
    add $t4, $s0, $t4       # Endereço vetor[j]
    lw $s1, 0($t4)          # $s1 = vetor[j]
    
    sll $t5, $t2, 2         # min_idx * 4
    add $t5, $s0, $t5       # Endereço vetor[min_idx]
    lw $s2, 0($t5)          # $s2 = vetor[min_idx]
    
    # Se vetor[j] < vetor[min_idx], atualiza min_idx
    blt $s1, $s2, atualiza_min
    j prox_interno

atualiza_min:
    move $t2, $t3           # min_idx = j

prox_interno:
    addi $t3, $t3, 1
    j loop_interno

trocar_elementos:
    # Troca vetor[i] com vetor[min_idx]
    la $s0, vetor
    sll $t4, $t1, 2         # i * 4
    add $t4, $s0, $t4       # Endereço vetor[i]
    lw $s1, 0($t4)          # $s1 = vetor[i]
    
    sll $t5, $t2, 2         # min_idx * 4
    add $t5, $s0, $t5       # Endereço vetor[min_idx]
    lw $s2, 0($t5)          # $s2 = vetor[min_idx]
    
    # Permuta os valores nas respectivas memórias
    sw $s2, 0($t4)
    sw $s1, 0($t5)
    
    addi $t1, $t1, 1        # i++
    j loop_externo

imprimir_vetor:
    la $t1, vetor
    li $t2, 0
loop_print:
    beq $t2, $t0, fim
    lw $a0, 0($t1)
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, espaço
    syscall
    addi $t1, $t1, 4
    addi $t2, $t2, 1
    j loop_print

fim:
    li $v0, 10
    syscall
