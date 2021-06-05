.data
	.globl print_board_test
	.globl random
	.globl random_init

rand:
	.word 0
	
.text
	


# -- print_board_test --
# a0 : Anzahl der Zeichen
# a1 : ein Reihung mit Halbwörten
# Funktion:
# Schreibe erst die Größe des Borads.
# Schreibt anschliessend einen Zeilenumbruch.
# Schreibe eine gegebene Anzahl an Zeichen aus der Rehung auf die Konsole, getrennt durch ein Leerzeichen.
# Schreibt anschliessend einen Zeilenumbruch.

print_board_test: 
	move	$t0 $a0
	li	$v0 1
	
	# print length
	move $a0 $a1
	syscall		
	li	$v0 11	
	li	$a0 10 # '\n'
	syscall
	
pr_loop: 
	beqz	$a1 pr_exit
	lhu	$a0 0($t0)
	# print value
	li	$v0 1
	syscall
	# print space
	li	$v0 11	
	li	$a0 32 # ' '
	syscall
	addiu	$t0 $t0 2
	subiu 	$a1 $a1 1
	b	pr_loop
	
pr_exit:
	li	$a0 10 # '\n'
	syscall
	jr	$ra


############################
#$v0 new random number
# next = ((next * 110351524 +12345) / (2^16)) % (2^15) 
random:								#mathe-magie
	lw $v0 rand
	mul $v0 $v0 1103515245
	addiu $v0 $v0 12345
	sll $v0 $v0 1
	srl $v0 $v0 17
	sw $v0 rand
	jr	$ra



# $a0 seed
random_init:
	sw $a0 rand
	jr $ra
	
	
