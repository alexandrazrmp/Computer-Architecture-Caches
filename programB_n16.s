.text
.globl _start
.ent _start
_start:      


   la $t0, k         #$t0 holds address to scalar
   li $t2, 256         #$t2 is a counter for the loop
   lw $t3, 0($t0)    #$t3 scalar
   
loop:
   lw $t4, 4($t0)    #$t4 array A current loops value

   addi $t2, $t2, -1   #decrease counter

   mult $t4, $t3   #multiplication of array A and the scalar
   mfhi $s0
   mflo $s1
   bne $zero, $s0, end     #end program if overflow occures

   sw $s1, 1028($t0)  #$s0 result array B (current i)     #due to continuous allocation

   addi $t0, $t0, 4


   bne $t2, $zero, loop

end:
   li $v0,10
   syscall

.end _start
                     
.data
.org 1000000

 k: .word 3

 A: .word 1, 2, 3, 5, 4, 6, 8, 7, 9, 10, 11, 12, 13, 14, 15, 16            #n = 16x16
    .word 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 
    .word 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48 
    .word 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64
    .word 1, 2, 3, 5, 4, 6, 8, 7, 9, 10, 11, 12, 13, 14, 15, 16            #2
    .word 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 
    .word 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48 
    .word 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64
    .word 1, 2, 3, 5, 4, 6, 8, 7, 9, 10, 11, 12, 13, 14, 15, 16            #3
    .word 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 
    .word 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48 
    .word 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64
    .word 1, 2, 3, 5, 4, 6, 8, 7, 9, 10, 11, 12, 13, 14, 15, 16            #4
    .word 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 
    .word 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48 
    .word 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64


 B: .space 1024    #array B will hold results