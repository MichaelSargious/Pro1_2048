.text 
	.globl move_one
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|----|		|----|----|----|----|----|	
#	|  2 |  0 |  2 |  0 |  4 |	=> 	|  2 |  2 |  0 |  4 |  0 |
#	|----|----|----|----|----|		|----|----|----|----|----|
#
#	$v0 1 iff something changed else 0 
move_one:

move $t7 $a0
li $v0 0 
addiu $a3 $a1 -1
sll $a3 $a3 2 
add $a3 $a3 $a0   # $a3 = addresse von letzte elment  

  loop :  
    lw $t0 0($t7)
    lhu $t1 0($t0)
    bnez $t1 next 
    beq $t7 $a3 finish
    add $t6 $t7 4 
    lw $t2 0($t6)
    lhu $t3 0($t2)
    beqz $t3 next 
   
  exchange :
    sh $t3 0($t0)  
    sh $t1 0($t2) 
    li $v0 1 
    beq $t6 $a3 finish 
    add $t7 $t7 4 
    b loop 
    
  next : 
    beq $t7 $a3 finish 
    add $t7 $t7 4 
    b loop 
   
  finish :
    
     jr $ra
