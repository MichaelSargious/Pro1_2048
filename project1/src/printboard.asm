.data
	.globl printboard

#
#a0 Address of the first field off the board
#
#	-----------------------------
#	|      |      |      |      |
#	| 2048 |  128 |    8 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	| 1024 |   64 |    4 |    8 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  512 |   32 |  512 |  128 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  256 |   16 | 2048 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#

line :.asciiz     "-----------------------------\n"
horz :  .asciiz "|      |      |      |      |\n"
one : .asciiz "|\n"
newline :.asciiz "\n" 
ip:.asciiz " "
p_1 : .asciiz "|    "
p_2 : .asciiz "|   "
p_3 : .asciiz "|  "
p_4 : .asciiz "| "
.text
printboard:
li $t8 15
sll $t8 $t8 1
add $t8 $t8 $a0     
move $t9 $a0
addiu $a3 $a0 6
li $t1 10
li $t2 100
li $t3 1000
loop:
la $a0 line 
li $v0 4
syscall 
la $a0 horz
li $v0 4
syscall 
read : 
lhu $t0 0($t9)
blt $t0 $t1 print_1
blt $t0 $t2 print_2
blt $t0 $t3 print_3
b print_4
print_1:
la $a0 p_1
li $v0 4
syscall 
move $a0 $t0 
li $v0 1 
syscall
la $a0 ip
li $v0 4
syscall 
b check
print_2:
la $a0 p_2
li $v0 4
syscall 
move $a0 $t0 
li $v0 1 
syscall
la $a0 ip
li $v0 4
syscall 
b check 
print_3:
la $a0 p_3
li $v0 4
syscall 
move $a0 $t0 
li $v0 1 
syscall
la $a0 ip
li $v0 4
syscall
b check
print_4:
la $a0 p_4
li $v0 4
syscall 
move $a0 $t0 
li $v0 1 
syscall
la $a0 ip
li $v0 4
syscall
check :
beq $t9 $a3 next_line
add $t9 $t9 2 
b read
next_line : 
la $a0 one
li $v0 4
syscall
la $a0 horz
li $v0 4
syscall
beq $t9 $t8 finish
add $t9 $t9 2 
add $a3 $a3 8
b loop 
finish :
la $a0 line 
li $v0 4
syscall
la $a0 newline
li $v0 4
syscall
jr $ra 

