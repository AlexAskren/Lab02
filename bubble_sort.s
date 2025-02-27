    .data
arr:    .word 5, 3, 4, 1, 2   # Array to be sorted
n:      .word 5               # Number of elements in the array

    .text
    .globl main
main:
    # Load array base address
    la a0, arr        # Load address of arr into a0
    lw a1, n          # Load n (number of elements) into a1

    # Call bubble sort
    jal ra, bubble_sort

    # Exit program
    li a7, 10         # syscall for exit
    ecall

# Bubble Sort Algorithm
bubble_sort:
    addi t0, zero, 0   # i = 0
outer_loop:
    blt a1, t0, done   # if i >= n, exit loop
    addi t1, zero, 0   # j = 0
    li t3, 0           # swapped = 0 (False)

inner_loop:
    sub t2, a1, t0
    addi t2, t2, -1
    bge t1, t2, check_swapped  # if j >= n-i-1, check swapped

    # Load arr[j] and arr[j+1]
    slli t4, t1, 2     # t4 = j * 4 (word offset)
    add t5, a0, t4     # address of arr[j]
    lw t6, 0(t5)       # arr[j]
    lw t4, 4(t5)       # arr[j+1] 

    # Compare arr[j] > arr[j+1]
    ble t6, t4, no_swap

    # Swap arr[j] and arr[j+1]
    sw t4, 0(t5)       # Store arr[j+1] in arr[j]
    sw t6, 4(t5)       # Store arr[j] in arr[j+1]
    li t3, 1           # swapped = 1

no_swap:
    addi t1, t1, 1     # j++
    j inner_loop

check_swapped:
    beqz t3, done      # if swapped == 0, break
    addi t0, t0, 1     # i++
    j outer_loop

done:
    ret
