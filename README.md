
Design a CPU with JLS Part I

    Due Apr 1 by 11:59pm Points 15 Submitting a file upload File Types jls Available until Apr 1 at 11:59pm

You may work with one partner on this assignment, or alone. If you work with a partner, BOTH of you should submit the assignment.

Your assignment is to use JLS to design a CPU which correctly implements a fictional instruction set architecture (ISA). The ISA you will implement is called Entropy (Links to an external site.)Links to an external site.. The details of the Entropy ISA, along with a sample file that you can use for testing, can be found here (Links to an external site.)Links to an external site.. You will want to be intimately familiar with the details of this ISA since you are designing hardware to implement its functionality.

Here is a starter circuit you will want to use as the basis for your designPreview the document. The state elements in this circuit have already been placed for you: the Program Counter, instruction memory (IMEM), registers, and data memory (DMEM). Important: You can add as many subcircuits as you want, but your main circuit must have the filename Entropy.jls. In addition the state elements must adhere to the following requirements:

    The registers must be in a subcircuit called RegFile, and the registers must be called RA, RB, RC, RD, RE, RF, RG, RH.
    The instruction memory must be in a subcircuit called IMEM, and the memory itself must also be called IMEM. The instruction size is 20 bits and the number of addressing bits is 8 (for a 256x20 memory array).
    The data memory must be in a subcircuit called DMEM, and the memory itself must also be called DMEM. The word size is 8 bits and the number of addressing bits is 8 (for a 256x8 memory array).

I will deduct points at my discretion (up to an unspecified but large amount) if these requirements are not adhered to.

Note: In the starter circuit, these state elements already exist in subcircuits with the required names and parameters. These subcircuits already have inputs and outputs specified but otherwise contain no implementation (except IMEM, which is complete). If you come up with a design that uses inputs and outputs which differ from those provided, you will have to delete the existing subcircuit and implement a new one, because JLS does not allow changing the inputs and outputs on existing subcircuits. It's fine if you do this, but if you do, be extremely careful to ensure that the name of the subcircuit and its state elements are still correct.

 

Testing Your Circuit

You will want to test your processor extensively as you implement it. The ISA page (Links to an external site.)Links to an external site. includes a download to an assembler which compiles Entropy assembly code into machine instructions which are readable by JLS. You can use this to write assembly programs and test that your Entropy implementation can run them and produce the correct output in its registers and DMEM. Just name the file that contains the machine code "memfile" (no file extension) and run JLS with the following command:

java -jar JLS.jar -scpusettings.txt -b Entropy.jls (The starter circuit includes cpusettings.txt which instructs JLS to "watch" the values of the registers and DMEM, and to load the contents of the file "memfile" into IMEM.)

With this procedure, you can write assembly programs, compile them, load them into JLS, and confirm that the registers and DMEM have the correct values. One sample program that you can use to test all 8 instructions at once is included at the end of the ISA specification (Links to an external site.)Links to an external site., but as you develop your CPU, you'll probably want to write smaller tests to test just 1 or 2 instructions at a time, as well as a more robust testing suite that includes some more complex programs.

It is not the case that each instruction is worth 1/8 of the assignment grade. If an instruction is broken, you will probably lose more than 1/8 of the total points because the broken instruction will cause errors to cascade in my own test programs. If you want a good grade on the assignment, you will need to get ALL EIGHT instructions working.

 

Design Advice

Your CPU will need the following in order to work:

    A clock with a cycle period long enough to allow all instructions to complete. (An insufficiently long clock period is a common source of bugs.)
    An unbundler to divide each instruction into its component parts.
    A control unit which turns various control signals on and off based on the current instruction.
    An ALU to perform necessary arithmetic and logical operations.
    Logic for which state elements (registers, DMEM) to write to/read from.
    Logic to either increment the PC or jump to a new address on a triggered beq instruction.

This is a big assignment. Expect it to take a lot of work and plan your time accordingly. Also remember that I'm available to answer questions if you get stuck.

 

Deliverables

For Part I of the assignment, you only need to implement the halt and addi (add immediate) instructions. Implementing addi will require implementing a significant proportion of the processor's total hardware.

For Part II of the assignment, you will have to implement the remaining six instructions. Implementing halt and addi will have already given you a good start, but there will still be much left to do.

Of course, if you are ambitious, you can try to have all 8 instructions working for Part I, but the only instructions which will be graded for Part I are halt and addi.



Entropy's Instruction Set Architecture Specification

Entropy's favorite number is eight. It has:

    8-bit words
	    8 registers (each register is 8 bits)
		    8 bits for addressing its data memory (for a total of 256 words in memory)
			    8 bits for addressing its instruction memory
				    8 instructions

					As suggested by the above, Entropy stores its instruction and data memory separately, and they are addressed separately. Entropy's registers are called RA through RH.

					Entropy supports only one data type: 8-bit two's complement integers. There is no support for floating point numbers.

					The exception to the pattern of 8 is instruction size. Entropy's instructions are 20 bits each, and are divided up as follows:

					NNN DDD SSS TTT IIIIIIII

					where:

					    NNN is the instruction encoding
						    DDD specifies a register ("destination")
							    SSS specifies a register ("source")
								    TTT specifies a register ("target")
									    IIIIIIII specifies an immediate value

										Entropy supports the following instructions (- indicates an unused/ignored bit):

										add
										Adds two registers and stores the result in a register
										Operation: $d = $s + $t; PC++
										Assembly syntax: add $d $s $t
										Binary encoding: 000 ddd sss ttt --------

										addi
										Adds a register and an immediate value and stores the result in a register
										Operation: $d = $s + imm; PC++
										Assembly syntax: addi $d $s imm
										Binary encoding: 001 ddd sss --- iiiiiiii

										mul
										Takes the upper 4 bits and lower 4 bits of the source register, multiplies those values together, and stores the result in the destination register. Interprets its inputs as UNSIGNED. I.e., 1001 is interpreted as decimal 9, not decimal -7. The fact that the multiplier is NOT a two's complement multiplier can yield mathematically incorrect results. For example, 1111 * 1111, or 15x15, would yield a result of 11100001, which the CPU will interpret as -31. This is fine; it is the intended behavior.
										Operation: $d = $s[0:3] * $s[4:7]; PC++
										Assembly syntax: mul $d $s
										Binary encoding: 010 ddd sss --- --------

										inv
										Inverts all the bits in the source register and stores the result in the destination register
										Operation: $d = !($s); PC++
										Assembly syntax: inv $d $s
										Binary encoding: 011 ddd sss --- --------

										beq
										Branches to an immediate-specified memory address if two registers are equal
										Operation: if $s == $t PC=imm else PC++
										Assembly syntax: beq $s $t label
										Binary encoding: 100 --- sss ttt iiiiiiii

										lw
										Loads a word into register $d, from data memory at the address specified in register $t
										Operation: $d=DMEM[$t]; PC++
										Assembly syntax: lw $d $t
										Binary encoding: 101 ddd --- ttt --------

										sw
										Stores the value in register $s into data memory at the address specified in register $t
										Operation: DMEM[$t]=$s; PC++
										Assembly syntax: sw $s $t
										Binary encoding: 110 --- sss ttt --------

										halt
										Halts execution of the processor
										Operation: halt
										Assembly syntax: halt
										Binary encoding: 111 --- --- --- --------

										An assembler that compiles Entropy assembly into binary machine code is available. The assembler is written as a Java .class file. To run it, pass in the name of the assembly file as a command-line argument. The assembler prints the resulting machine code to stdout (so it can be redirected to a file).

										Example of running the assembler:

										java EntropyCompiler assembly_file.s > memfile

										The assembler is quite minimalistic. It can detect and report some errors, but some errors might cause it to fail with little or no explanation. Carefully check your syntax to make sure it is correct.

										Other details about Entropy assembly:

										    Registers are specified by a dollar sign $ followed by the letter a through h in lowercase ($a $b $c $d $e $f $g and $h).
											    A branch label should be prepended by a period . and followed by a colon :, e.g., .label:
												    When the corresponding label appears in a beq instruction, it should not include the leading period or following colon.
													    Text which appears on a line after a semicolon ; is considered a comment and is ignored by the compiler.

														Following is a toy example Entropy assembly program which demonstrates the functionality of all the different instructions. The code is commented to explain what it is doing at each line.

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

														Compiling the above should produce the following machine code:

														00 20023
														01 40000
														02 24801
														03 80105
														04 83f02
														05 08100
														06 6d000
														07 c1a00
														08 b0200
														09 e0000

														After running these instructions through an Entropy implementation in JLS, you should get the following output (the order might not necessarily be the same, but the values should be):

														Register RegFile.RC: 0xC (12 unsigned, 12 signed)
														Register RegFile.RF: 0x0 (0 unsigned, 0 signed)
														Register RegFile.RD: 0xF3 (243 unsigned, -13 signed)
														Register RegFile.RE: 0xF3 (243 unsigned, -13 signed)
														Register RegFile.RG: 0x0 (0 unsigned, 0 signed)
														Register RegFile.RA: 0x6 (6 unsigned, 6 signed)
														Register RegFile.RB: 0x6 (6 unsigned, 6 signed)
														Register RegFile.RH: 0x0 (0 unsigned, 0 signed)
														Changed locations in memory DMEM.DMEM
														  0xc: 0x0 (0 unsigned, 0 signed) -> 0xF3 (243 unsigned, -13 signed)

														  Important: If your CPU passes the above test, that is an excellent start. However, it does not guarantee that your CPU is 100% correct. Be sure to write your own tests, hitting all of your registers, every address in DMEM, and various combinations of commands and loop structures. Try hard to break your CPU. Do not rely exclusively on the example program to test your processor.

