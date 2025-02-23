 #Calculate GCD using Euclidian algorithm
 
        .data

        .text
        .globl _start

_start:
        li a0, 175          # Load first number into a0
        li a1, 1250         # Load second number into a1
        jal ra, gcd         # Call gcd function

        # Print resultxx
        li a7, 1            # syscall for print integer
        ecall               # Print GCD in a0

        li a7, 10           # Exit syscall
        ecall

# Euclidean Algorithm
gcd:
        beq a1, zero, done  # If b == 0, return a0 as GCD

loop:
        rem a2, a0, a1      # a2 = a0 % a1
        mv a0, a1           # a0 = a1
        mv a1, a2           # a1 = a2
        bne a1, zero, loop  # Repeat if remainder != 0

done:
        ret                 # Return with GCD in a0
