.text
	.globl merge

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  0 |  0 |  4 |
#	|----|----|----|----|		|----|----|----|----|

merge:

li $t9 0 
addiu $a3 $a1 -1 
sll $a3 $a3 2
add $a3 $a3 $a0 

loop : 
lw $t0 0($a0)
lhu $t1 0($t0)
beqz $t1 next_1 
beq $a0 $a3 finish
add $a2 $a0 4 
lw $t2 0($a2) 
lhu $t3 0($t2)
beqz $t3 next_2  
bne $t1 $t3 next_2 
add $t3 $t1 $t3 
sh $t3 0($t0)
sh $t9 0($t2)
beq $a2 $a3 finish 
add $a0 $a2 4 
b loop 

next_1 : 
beq $a0 $a3 finish 
add $a0 $a0 4 
b loop 

next_2 : 
beq $a2 $a3 finish 
add $a0 $a2 4 
b loop 

finish :

jr $ra 
