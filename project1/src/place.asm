.text
	.globl place
	
# 	$a0 board address
# 	$a1 board length
#	$a2 field number to place into
#	$a3 number to place
#
#	$v0 == 0 iff place succesfull 
#          else 1
#

place:
      
      sll $t3 $a2 1 
      add $t3 $t3 $a0  # $t3 = adresese von dem Feld , in das der Wert gesetzt werden soll 
      
      lhu $t0 0($t3)
      bnez $t0 ja 
      sh $a3 0($t3) 
      li $v0 0 
      b  finish
ja : 
      li $v0 1 
finish :
      jr $ra   

       

