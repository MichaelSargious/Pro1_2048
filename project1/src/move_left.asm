.text
	.globl move_left
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|	
#	|  0 |  2 |  0 |  4 |	=> 	|  2 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|	
#
	
move_left:
addiu $sp $sp -4 
sw $ra 0($sp)

addiu $a3 $a1 -1
sll $a3 $a3 2 
add $a3 $a3 $a0
  
  mv : 
    move $t9 $a0 
    
  loop :
    lw $t0 0($t9) 
    lhu $t1 0($t0)
    bnez $t1 next_1 
    add $a2 $t9 4
    lw $t2 0($a2)
    lhu $t3 0($t2)
    beqz $t3 next_2 
     
   call : 
    jal move_one
    bne $a2 $a3 mv 
  
  next_1 : 
    beq $t9 $a3 finish 
    add $t9 $t9 4 
    b loop 
     
  next_2 : 
    beq $a2 $a3 finish 
    add $t9 $t9 4 
    b loop 
    
  finish :
    lw $ra 0($sp)
    
    addiu $sp $sp 4
    jr $ra 
    
