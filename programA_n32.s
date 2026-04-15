.text
.globl _start
.ent _start
_start:      


   la $t0, k	     #$t0 holds address to scalar
   li $t2, 32	     #$t2 is a counter for the loop
   lw $t3, 0($t0)    #$t3 scalar
   
loop:
   lw $t4, 4($t0)    #$t4 array A current loops value

   addi $t2, $t2, -1   #decrease counter

   mult $t4, $t3   #multiplication of array A and the scalar
   mfhi $s0
   mflo $s1
   bne $zero, $s0, end     #end program if overflow occures

   sw $s1, 132($t0)  #$s0 result array B (current i)     #due to continuous allocation

   addi $t0, $t0, 4


   bne $t2, $zero, loop

end:
   li $v0,10
   syscall

.end _start
   		  		
.data
.org 1000000

 k: .word 3
 A: .word 1, 2, 3, 5, 4, 6, 8, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32	#n = 32

 B: .space 128    #array B will hold results