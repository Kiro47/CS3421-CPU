
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
