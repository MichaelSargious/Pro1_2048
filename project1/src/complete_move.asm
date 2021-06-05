.text
	.globl complete_move
	

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|


complete_move:
addiu $sp $sp -16 
sw $ra 0($sp)
sw $a0 4($sp)
sw $a1 8($sp)

jal move_left

toMerge : 
lw $a0 4($sp)
lw $a1 8($sp)
jal merge

toLeft_2 : 
lw $a0 4($sp)
lw $a1 8($sp)
jal move_left 

lw $ra 0($sp)
lw $a0 4($sp)
lw $a1 8($sp)
addiu $sp $sp 16
jr $ra 
