; Entropy sample program
addi $a $a 35 ; stores 0010_0011 in RA
mul $a $a ; 0010x0011=0110 (2x3=6), store in RA
.loop:
addi $b $b 1 ; increment b by 1
beq $a $b endloop ; when RA==RB (both 6) break out of loop
beq $h $h loop ; effective jump command
.endloop:
add $c $a $b ; 6+6=12, store 12 (0000_1100) in RC
inv $d $c ; invert RC to 1111_0011 (-13) and store that in RD
sw $d $c ; store value in RD (-13) at address specified by RC (12)
lw $e $c ; load address at RC (DMEM[12]=-13) into RE
halt 
