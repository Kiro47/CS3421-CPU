; Entropy Basic inversion
addi $d $d 36 ; stores 0010_0100 in Reg D
inv  $e $d    ; Inverts 0010_0100 to 1101_1011 equal to 219
halt
