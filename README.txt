# project-a

this is a student project made in systemverilog,
goal of this project is to explore what is called "Near Memory Threading", we have made a base design in systemverilog.
Near Memory Threading, is a new concept using Special Register called "MPR" we can switch context inside the processor so that flushing and CC are at very minimal.
more on this Special Register you can read the academic papers written for it.
this is a traditional pipline, more accurately as the top level shown in the book of "David A Patterson and John L. Hennessy" "Computer Architecture: A Quantitative Approach".
the machine code supported is RISC-V (32bit).


# short guide of how to use this design

this entire project was made using simulator Modelsim Free Edition so better use it at first.


# Threading 
threading in this design is not as the regular threading that is known, a thread starts running and then when a context switch happens it will be swapped entirely, meaning 
all the dataflow inside the pipeline will be switched as a whole.

visual example:

---------------------------------------------------------------------------------------------------------------------
lest assume this is the state of the dataflow (snapshot) : 

op.5 th.1 | op.4 th.1 | op.3 th.1 | op.2 th.1 | op.1 th.1             MPR : slot1: th2. data <--output_pointer 
IF        |    ID     |     EX    |    MEM    |  WB                         slot2: ...
                                                                            slot3: ...
                                                                            slot4: ...
on context switch this will happen:  
---------------------------------------------------------------------------------------------------------------------
op.5 th.2 | op.4 th.2 | op.3 th.2 | op.2 th.2 | op.1 th.2             MPR : slot1: th1. data 
IF        |    ID     |     EX    |    MEM    |  WB                         slot2: th3. data <--output_pointer 
                                                                            slot3: th4. data
                                                                            slot4: ... 
                                                                            
---------------------------------------------------------------------------------------------------------------------

# Context Switch
context switch happens when the main CPU (this the MemoryController module) and the NMT device will try to access the same location in the main memory (assumed in the design as the same byte - can be made broader in future like a "bank" or a "row").
in this case we give the CPU the priority and put the commands on the fly of the current thread inside the MPR.
and output the next in line commands from it and continue it (or start a new one).


# predictor used in the desing is called "Next Rank Predictor"

its a very simple predictor, just in the case of CPU-read issue a context switch.

Written by:

me and another student, under "Technion, ASIC2 Lab" supervisiors.
more info at: https://github.com/nmtproject/Near-Memory-Threading


