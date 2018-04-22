; Entropy Basic ADDition
addi $a $a 3  ; stores 0000_0011 in Reg A
addi $b $b 4  ; stores 0000_0100 in Reg B
mul  $c $a    ; multiplies 0000 x 0011 resulting in 0
; 
addi $d $d 36 ; stores 0010_0100 in Reg D
mul  $e $d    ; multiplies 0010 x 0100 Resulting in  2 x 4 = 8
;
addi $h $h 170 ; 
mul  $h $h 
halt
