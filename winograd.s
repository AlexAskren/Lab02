#winograd     
    .data
d:  .word 0, 0, 1, 2  # Array d
g:  .word 10, 20, 30  # Array g

    .text
    .globl main

main:
    la s0, d      # Load address of d array
    la s1, g      # Load address of g array

    # Load d[0] and d[2]
    lw t0, 0(s0)  # t0 = d[0]
    lw t1, 8(s0)  # t1 = d[2]

    # Load g[0]
    lw t2, 0(s1)  # t2 = g[0]

    # Compute m1 = (d[0] - d[2]) * g[0]
    sub t3, t0, t1  # t3 = d[0] - d[2]
    mul s2, t3, t2  # s2 = m1

    # Load d[1] and d[2]
    lw t0, 4(s0)  # t0 = d[1]
    lw t1, 8(s0)  # t1 = d[2]

    # Compute m2 = (d[1] + d[2]) * (g[0] + g[1] + g[2]) // 2
    add t3, t0, t1  # t3 = d[1] + d[2]
    lw t4, 4(s1)    # t4 = g[1]
    lw t5, 8(s1)    # t5 = g[2]
    add t4, t2, t4  # t4 = g[0] + g[1]
    add t4, t4, t5  # t4 = g[0] + g[1] + g[2]
    mul t4, t3, t4  # t4 = (d[1] + d[2]) * (g[0] + g[1] + g[2])
    srli s3, t4, 1  # s3 = m2 (divide by 2)

    # Compute m3 = (d[2] - d[1]) * (g[0] - g[1] + g[2]) // 2
    sub t3, t1, t0  # t3 = d[2] - d[1]
    sub t4, t2, t4  # t4 = g[0] - g[1]
    add t4, t4, t5  # t4 = g[0] - g[1] + g[2]
    mul t4, t3, t4  # t4 = (d[2] - d[1]) * (g[0] - g[1] + g[2])
    srli s4, t4, 1  # s4 = m3 (divide by 2)

    # Load d[3]
    lw t1, 12(s0)  # t1 = d[3]

    # Compute m4 = (d[1] - d[3]) * g[2]
    sub t3, t0, t1  # t3 = d[1] - d[3]
    mul s5, t3, t5  # s5 = m4

    # End program
    addi a0, zero, 10  # Exit syscall
    ecall