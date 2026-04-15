.text
.globl _start
.ent _start

.set noat
.set noreorder

_start:

    addi $s0, $zero, 0       #A row index
    addi $s1, $zero, 0       #B column index
    addi $s2, $zero, 0       #inner loop counter
    addi $s3, $zero, 8       #matrix size (8x8)
    la $t6, A                #pointer to matrix A
    la $t7, B                #pointer to matrix B
    la $t5, Y                #pointer to result matrix Y

Loop:
    beq $s0, $s3, end        #if all rows are processed, exit
    
    outer:
        beq $s1, $s3, next_row   #if all columns are processed, go to the next row
        addi $t2, $zero, 0       #initialize accumulator for Y[i][j]

        inner:
            beq $s2, $s3, write_result  #if inner loop is complete, write result
            
            mul $t9, $s0, $s3       #row offset for A: $s0 * matrix size
            add $t0, $t9, $s2       #add inner loop counter to row offset
            sll $t0, $t0, 2         #word index to byte offset
            add $t0, $t0, $t6       #address of A[s0][s2]
            lw $t3, 0($t0)          #load A[s0][s2]
            
            mul $t9, $s2, $s3       #row offset for B: $s2 * matrix size
            add $t1, $t9, $s1       #add column index to row offset
            sll $t1, $t1, 2         #word index to byte offset
            add $t1, $t1, $t7       #address of B[s2][s1]
            lw $t4, 0($t1)          #Load B[s2][s1]

            #multiply
            mult $t3, $t4
            mflo $t8
	    mfhi $s4		    #check for overflow
            bne $s4,$zero,end
            add $t2, $t2, $t8       #add to $t2
            
            #increase inner loop counter
            addi $s2, $s2, 1
            j inner

        write_result:
            #write to Y[s0][s1]
            mul $t9, $s0, $s3       #row offset for Y: $s0 * matrix size
            add $t0, $t9, $s1       #add column index to row offset
            sll $t0, $t0, 2         #word index to byte offset
            add $t0, $t0, $t5       #address of Y[s0][s1]
            sw $t2, 0($t0)          #store result in Y[s0][s1]

            #reset inner loop counter
            addi $s2, $zero, 0

            #increment column index
            addi $s1, $s1, 1
            j outer

    next_row:
        #reset column index
        addi $s1, $zero, 0

        #increment row index
        addi $s0, $s0, 1
        j Loop

end:
    li $v0, 10
    syscall

.data
.org 100000

A: .word 9, 10, 11, 12, 13, 14, 15, 16
   .word 9, 10, 11, 12, 13, 14, 15, 16
   .word 17, 18, 19, 20, 21, 22, 23, 24
   .word 25, 26, 27, 28, 29, 30, 31, 32
   .word 33, 34, 35, 36, 37, 38, 39, 40
   .word 41, 42, 43, 44, 45, 46, 47, 48
   .word 49, 50, 51, 52, 53, 54, 55, 56
   .word 57, 58, 59, 60, 61, 62, 63, 64
B: .word 1, 2, 3, 4, 5, 6, 7, 8
   .word 9, 10, 11, 12, 13, 14, 15, 16
   .word 17, 18, 19, 20, 21, 22, 23, 24
   .word 25, 26, 27, 28, 29, 30, 31, 32
   .word 33, 34, 35, 36, 37, 38, 39, 40
   .word 41, 42, 43, 44, 45, 46, 47, 48
   .word 49, 50, 51, 52, 53, 54, 55, 56
   .word 57, 58, 59, 60, 61, 62, 63, 64
Y: .space 256          				#8x8