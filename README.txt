# project-a

this is a student project made in systemverilog,
goal of this project is to explore what is called "Near Memory Threading", we have made a base design in systemverilog.
Near Memory Threading, is a new concept using Special Registers called "MPR" we can switch context inside the processor so that flushing and CC are at very minimal.
more on this Special Register you can read the academic papers written for it.
this is a traditional pipline, more accurately as the top level shown in the book of "David A Patterson and John L. Hennessy" "Computer Architecture: A Quantitative Approach".
the machine code supported is RISC-V (32bit).


# short guide of how to use this design

this entire project was made using simulator Modelsim Free Edition so better use it at first.


# Threading 
threading in this design is not as the regular threading that is known, a thread starts running and then when a context switch happens it will be swapped entirely, meaning 
all the dataflow inside the pipeline will be switched as a whole.

example:

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

# types:

1. Testing Switch
   this is purly for testing the design in a simpler manner, initially.

2. Memory Controller Context Switch
   this is a more realistic approach to switching where we assume the main CPU will try to access the memory and the Memory Controller will issue context switch signals,
   along with relavant addresses where the collision happened.

# Locking in MPR:

this mechanism is putting locks in each slot of the MPR, when context switch happens from a specific collision, that address will be stored in the slot and the slot will be locked, so that potential context switches will not overwrite that pending operation.

this mode is inactive at default, you can release it and test it

# example:
lest assume this is the state of MPR (snapshot) : 
---------------------------------------------------------------------------------------------------------------------
          MPR : slot1: th2. data | state: LOCKED    | address: 1010  <--output_pointer
                slot2: ...       | state: UNLOCKED  | address: ...
                slot3: ...       | state: UNLOCKED  | address: ...
                slot4: ...       | state: UNLOCKED  | address: ...
on context switch this will happen:  
---------------------------------------------------------------------------------------------------------------------
          MPR : slot1: th1. data | state: LOCKED    | address: 1010
                slot2: ...       | state: UNLOCKED  | address: ... <--output_pointer
                slot3: ...       | state: UNLOCKED  | address: ... 
                slot4: ...       | state: UNLOCKED  | address: ...                                                 
freeing a slot : free signals must be done before context switch signal:
freed_address = 1010, free = 1, context switch = 1
---------------------------------------------------------------------------------------------------------------------
          MPR : slot1: th1. data | state: UNLOCKED  | address: 1010 <--output_pointer
                slot2: ...       | state: LOCKED    | address: ... 
                slot3: ...       | state: LOCKED    | address: ...
                slot4: ...       | state: LOCKED    | address: ...
---------------------------------------------------------------------------------------------------------------------
          MPR : slot1: ***       | state: UNLOCKED  | address: ... 
                slot2: ...       | state: LOCKED    | address: ... <--output_pointer
                slot3: ...       | state: LOCKED    | address: ...
                slot4: ...       | state: LOCKED    | address: ...
---------------------------------------------------------------------------------------------------------------------


# predictor used in the desing is called "Next Rank Predictor"

its a very simple predictor, just in the case of CPU-read issue a context switch, this prediction method is not at all invasive in the functionality of the NMT, it is used
as another external context switch module.

you can easily connect the prediction mechanism to the context switching net by adding a similar line to below line to the top level file,

assign context_switch = context_switch & context_switch_from_prediction_module;  

Written by:

me and another student, under "Technion, ASIC2 Lab" supervisiors.


