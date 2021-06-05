.text
	.globl move_check
#
#	$a0 buffer address
#	$a1 buffer length
#
#   $v0 == 1 iff left move possible and would change something
#            else 0
#

move_check:
addiu $sp $sp -8
sw $a0 0($sp)
sw $a1 4($sp)
addiu $a3 $a1 -1
sll $a3 $a3 2 
add $a3 $a3 $a0 
lw $t0 0($a0) 
lhu $t1 0($t0)     # $t1 = wert-nr 1 

loop : 
bnez $t1 check_merge 
add $a0 $a0 4 
lw $t2 0($a0)
lhu $t3 0($t2) 
beqz $t3 next 
b positiv 
    
check_merge : 
add $a0 $a0 4
 lw $t2 0($a0)
lhu $t3 0($t2)
beqz $t3 next 
beq $t1 $t3 positiv 
       
next : 
beq $a0 $a3 negativ 
move $t1 $t3 
b loop 
       
positiv : 
li $v0 1 
b finish 
       
negativ :
li $v0 0 
       
finish :
addiu $sp $sp 8
lw $a0 0($sp)
lw $a1 4($sp)
jr $ra 
         
       
       
       
       
    
       





