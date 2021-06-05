	.data
	.globl main

board:
	.half 2048,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0
	.half 0,0,0,0
	
	.text

main:
	la $a0 board
	li $a1 16
	jal check	
	move $a0 $v0
	li $v0 1
	syscall
	li	$v0 10
	syscall
