; Entropy Basic ADDition
addi $a $a 1  ; stores 0000_0001 in Reg A
addi $d $d 10 ; stores 10 in Reg D
; Loops increments b until 10 then exits
.loop:
addi  $b $b 1 ;
beq  $b $d endloop ; ends loop
beq  $b $b loop   ; do the loop de loop
.endloop:
addi $h $h 20
halt
