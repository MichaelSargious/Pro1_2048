.data
msg:
  .byte 0x41 99 0x60 'X' '#' 18 -6 0
.text
  .globl main

# make boring message shiny

main:
  la $s0 msg
loop:
  lbu $s1 0($s0)
  blez $s1 break
  move $a0 $s0
  move $a1 $s0
  jal magic
  addiu $s0 $s0 1
  j loop
break:
  la $a0 msg
  li $v0 4
  syscall
  li $v0 10
  syscall
