.text
  .globl magic

#
# convert character using dark magic
#
# a0 source
# a1 target
#

magic:
  lbu $a0 0($a0)
  addiu $a0 $a0 0xf
  sb $a0 0($a1)
  jr $ra
