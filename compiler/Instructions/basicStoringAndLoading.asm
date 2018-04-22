; Entropy Basic ADdition
addi $a $a 3  ; stores 0000_0011 in Reg A
addi $b $b 8 ; Mem adddress loc
sw   $a $b    ; store 3 at 8
lw   $h $b    ; load 3 from 8 to RH
halt
