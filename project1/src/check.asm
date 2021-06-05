.text
	.globl check


#
#	$a0 board address
#	$a1 board length
#
#	$v0 == 1 iff 2048 found
#

check:
addiu $sp $sp -8
sw $a0 0($sp)
sw $a1 4($sp)
    addiu $a3 $a1 -1
    sll $a3 $a3 1   
    add $a3 $a3 $a0   # $a3 = endadresse
    li  $t1 2048 

loop : 
    lhu $t0 0($a0)
    beq $t0 $t1 positiv
    beq $a3 $a0 negativ 
    addiu $a0 $a0 2 
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
