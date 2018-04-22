addi $a $a 100 ; number of door
addi $b $b 0   ; memory start
addi $b $b 0   ; door counter
addi $c $c 0   ; position counter
addi $h $h 0   ; 0 reg
.initializer:
sw $b $h     ; set to 0
addi $b $b 1 ; incremen memory
addi $c $c 1; increment counter
beq $c $a start ; begin
beq $a $a initializer ; loop
.start:

