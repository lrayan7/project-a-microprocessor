
	
module TOP_LEVEL_NMT (
	input logic [8:0] used_address_by_controller,
	input logic [8:0] released_address_by_controller, 
	input logic read_or_write
		);						
`include "port_list.sv"	
logic freed_t;			
logic [31:0] none;								
assign none = 32'b0;
reg clk = 0;
always
begin
	#5 clk=1;
	#5 clk=0;
end
reg [31:0] ex_thread_address_long;
assign ex_thread_address_long[7:0] = ex_thread_address; 
assign ex_thread_address_long[31:8] = none[31:8]; 
assign freed_from_memcnt = freed_t;
MemoryController memory_controller(
	.clk(clk),
	.used_address(used_address_by_controller),
	// .freed(freed_from_memcnt),
	.freed_address(released_address_by_controller),
	.read_or_write(read_or_write)
	);
IF_nmt1   fetch (								
	.clk(clk),
	.context_switch(collision_detected),
	.current_thread_pc(MPR_IFID_out[1]),

	.instruction(instr_if),
	.pc_o(pc_if)
	);
MPR mpr_ifid (
	.clk(clk),
	.freed(freed_from_memcnt),
	.address(ex_thread_address_long),
	.freed_address(released_address_by_controller),
	.context_switch_in(collision_detected),
	.in('{none,ex_thread_wr_host_rd,none,none,none,none,none,none,
		 none,none,none,none,none,pc_if,instr_if}),
	.out('{MPR_IFID_out[14],MPR_IFID_out[13],MPR_IFID_out[12],
		MPR_IFID_out[11],MPR_IFID_out[10],MPR_IFID_out[9],MPR_IFID_out[8],
		MPR_IFID_out[7],MPR_IFID_out[6],MPR_IFID_out[5],MPR_IFID_out[4],
		MPR_IFID_out[3],MPR_IFID_out[2],MPR_IFID_out[1],
		MPR_IFID_out[0]}),
	.select(ifid_select)
	);
IFID ifid (								
	.IR(instr_if),
	.pc_i(pc_if),
	.clk(clk),
	
	.IR_o(instr_ifid),
	.pc_o(pc_ifid)
	);
mux mux_ifid(
	.select(ifid_select),
	.in('{none,none,none,none,none,
	none,none,none,none,none,none,none,none,
	MPR_IFID_out[1], // pc_if
	MPR_IFID_out[0] // instr_if
	}),
	
	._in('{none,none,none,none,none,none,none,none,none,
		none,none,none,none,
		pc_ifid,instr_ifid}),
	.out('{MUX_IFID_out[14],MUX_IFID_out[13],MUX_IFID_out[12],MUX_IFID_out[11],MUX_IFID_out[10],
		MUX_IFID_out[9],MUX_IFID_out[8],MUX_IFID_out[7],MUX_IFID_out[6],MUX_IFID_out[5],MUX_IFID_out[4],
		MUX_IFID_out[3],MUX_IFID_out[2],MUX_IFID_out[1], // pc
		MUX_IFID_out[0] // instr
	})
	);
ID1 decode (	
	.clk(clk),								
	.instr(MUX_IFID_out[0]),
	.pc_i(MUX_IFID_out[1]),
	.ALU_output(MUX_MEMWB_out[0]),
	.reg_dst_in(MUX_MEMWB_out[1]),
	.LMD_output(MUX_MEMWB_out[2]),
	.mem_write(MUX_MEMWB_out[3]),
	.alu_write(MUX_MEMWB_out[4]),
	
	.opcode(opcode_id),
	.cmd_type(cmd_type_id),
	.pc_o(pc_id),
	.imm(imm_id),
	.reg1_out(reg1_id),
	.reg2_out(reg2_id),
	.instr_o(instr_id),
	.reg_dst(reg_dst_id),
	.imm_alu(imm_alu_id)
	);
MPR mpr_idex (
	.clk(clk),
	.freed(freed_from_memcnt),
	.address(ex_thread_address_long),
	.freed_address(released_address_by_controller),
	.context_switch_in(collision_detected),
	.in('{imm_alu_id,opcode_id,pc_id,imm_id,reg1_id,reg2_id,cmd_type_id,
		instr_id,reg_dst_id,none,none,none,none,ex_thread_wr_host_rd,none}),
	.out('{MPR_IDEX_out[14],MPR_IDEX_out[13],
	MPR_IDEX_out[12],MPR_IDEX_out[11],MPR_IDEX_out[10],MPR_IDEX_out[9],
	MPR_IDEX_out[8], // reg_dst_id
	MPR_IDEX_out[7], // instr_id
	MPR_IDEX_out[6], // cmd_type
	MPR_IDEX_out[5], // reg2_id
	MPR_IDEX_out[4], // reg1_id
	MPR_IDEX_out[3], // imm_id
	MPR_IDEX_out[2], // pc_id
	MPR_IDEX_out[1], // opcode_id
	MPR_IDEX_out[0] // imm_alu_id
	}),
	.select(idex_select)
	);
IDEX idex (								
	.opcode(opcode_id),
	.cmd_type(cmd_type_id),
	.pc_i(pc_id),
	.imm(imm_id),
	.reg1(reg1_id),
	.reg2(reg2_id),
	.instr(instr_id),
	.reg_dst(reg_dst_id),
	.imm_alu(imm_alu_id),
	.clk(clk),
	
	.imm_alu_o(imm_alu_idex),
	.pc_o(pc_idex),
	.imm_o(imm_idex),
	.reg1_o(reg1_idex),
	.reg2_o(reg2_idex),
	.cmd_type_o(cmd_type_idex),
	.opcode_o(opcode_idex),
	.instr_o(instr_idex),
	.reg_dst_o(reg_dst_idex)
	);
mux mux_idex(
	.select(idex_select),
	.in('{none,none,none,none,MPR_IDEX_out[10],
	MPR_IDEX_out[9], // 
	MPR_IDEX_out[8], // regdst
	MPR_IDEX_out[7], // isntr
	MPR_IDEX_out[6], // cmd
	MPR_IDEX_out[5], // reg2
	MPR_IDEX_out[4], // reg1
	MPR_IDEX_out[3], // imm
	MPR_IDEX_out[2], // pc
	MPR_IDEX_out[1], // opcode
	MPR_IDEX_out[0] // imm_alu
	}),
	._in('{none,none,none,none,none,
		none,reg_dst_idex,instr_idex,cmd_type_idex,
		reg2_idex,reg1_idex,imm_idex,pc_idex,opcode_idex,imm_alu_idex}),
	.out('{MUX_IDEX_out[14],MUX_IDEX_out[13],MUX_IDEX_out[12],MUX_IDEX_out[11],MUX_IDEX_out[10],MUX_IDEX_out[9],
	MUX_IDEX_out[8], // reg_dst
	MUX_IDEX_out[7], // instr
	MUX_IDEX_out[6], // cmd
	MUX_IDEX_out[5], // reg2
	MUX_IDEX_out[4], // reg1
	MUX_IDEX_out[3], // imm
	MUX_IDEX_out[2], // pc
	MUX_IDEX_out[1], // opcode
MUX_IDEX_out[0] // imm_alu
	})
	);
EX execute (
	.clk(clk),
	.control_cmd(read_or_write),
	.address(used_address_by_controller),							
	.imm_alu(MUX_IDEX_out[0]),
	.opcode(MUX_IDEX_out[1]),
	.pc_i(MUX_IDEX_out[2]),
	.imm(MUX_IDEX_out[3]),
	.reg1(MUX_IDEX_out[4]),
	.reg2(MUX_IDEX_out[5]),
	.cmd_type(MUX_IDEX_out[6]),
	.instr(MUX_IDEX_out[7]),
	.freed_address(released_address_by_controller),

	.ALU_output(ALU_ex),
	.opcode_o(opcode_ex),
	.cond(cond_ex),
	.instr_o(instr_ex),
	.reg2_o(reg2_ex),
	.mem_write(mem_write_ex),
	.alu_write(alu_write_ex),
	.cmd_type_o(cmd_type_ex),
	// .context_switch(collision_detected), // temporarily inactive
	.thread_address(ex_thread_address_long)
	);
MPR mpr_exmem (
	.clk(clk),
	.freed(freed_from_memcnt),
	.address(ex_thread_address_long),
	.freed_address(released_address_by_controller),
	.context_switch_in(collision_detected),
	.in('{none,ex_thread_wr_host_rd,none,none,
		none,none,none,none,
		MUX_IDEX_out[8]/* reg dest */,
		alu_write_ex,mem_write_ex,cmd_type_ex,reg2_ex,instr_ex,ALU_ex}),
	.out('{MPR_EXMEM_out[14],MPR_EXMEM_out[13],MPR_EXMEM_out[12],MPR_EXMEM_out[11],
		MPR_EXMEM_out[10],MPR_EXMEM_out[9],MPR_EXMEM_out[8],MPR_EXMEM_out[7],
		MPR_EXMEM_out[6], /* regdst */
		MPR_EXMEM_out[5], /* alu */ 
		 MPR_EXMEM_out[4], /* mem */
		MPR_EXMEM_out[3], /* cmd */
		 MPR_EXMEM_out[2], /* reg2 */
		MPR_EXMEM_out[1], /* instr */
MPR_EXMEM_out[0] /* alu */ 
		}),
	.select(exmem_select)
	);
EXMEM exmem (
	.ALU(ALU_ex),
	.opcode(opcode_ex),
	.cond(cond_ex),
	.instr(instr_ex),
	.reg_dst(MUX_IDEX_out[8]), // reg dest 
	.clk(clk),
	.reg2(reg2_ex),
	.mem_write(mem_write_ex),
	.alu_write(alu_write_ex),
	.cmd_type(cmd_type_ex),

	.ALU_output(ALU_exmem),
	.instr_o(instr_exmem),
	.opcode_o(opcode_exmem),
	.cond_o(cond_exmem),
	.reg_dst_o(reg_dst_exmem),
	.reg2_o(reg2_exmem),
	.mem_write_o(mem_write_exmem),
	.alu_write_o(alu_write_exmem),
	.cmd_type_o(cmd_type_exmem)
	);
mux mux_exmem(
	.select(exmem_select),
	.in('{none,none,none,none,none,none,none,none,
		MPR_EXMEM_out[6], /* regdst*/ 
		MPR_EXMEM_out[5], /* alu write */
		MPR_EXMEM_out[4], /* mem*/ 
		MPR_EXMEM_out[3], /* cmd*/
		MPR_EXMEM_out[2], /* reg2*/ 
		 MPR_EXMEM_out[1], /* isntr*/
MPR_EXMEM_out[0] /* alu*/
		}),
	._in('{none,none,none,none,none,none,none,
		reg2_ex,reg_dst_exmem,alu_write_exmem,mem_write_exmem,
		cmd_type_exmem,reg2_exmem,instr_exmem,ALU_exmem}),
	.out('{MUX_EXMEM_out[14],MUX_EXMEM_out[13],MUX_EXMEM_out[12],MUX_EXMEM_out[11],
		MUX_EXMEM_out[10],MUX_EXMEM_out[9],MUX_EXMEM_out[8],MUX_EXMEM_out[7],
		MUX_EXMEM_out[6], /* regdst*/ 
		MUX_EXMEM_out[5], /* alu write*/ 
		 MUX_EXMEM_out[4], /* mem write*/
		MUX_EXMEM_out[3], /* cmd*/
		MUX_EXMEM_out[2], /* reg2*/ 
		MUX_EXMEM_out[1], /* instr*/ 
		MUX_EXMEM_out[0] /* alu*/
		})
	);
MEM memory (
	.clk(clk),									
 	.ALU(MUX_EXMEM_out[0]),
 	.instr(MUX_EXMEM_out[1]),
 	.reg2(MUX_EXMEM_out[2]),
 	.cmd_type(MUX_EXMEM_out[3]),

	.ALU_o(ALU_mem),
	.IR(instr_mem),
	.LMD(LMD_mem)
	);
MPR mpr_memwb (
	.clk(clk),
	.freed(freed_from_memcnt),
	.address(ex_thread_address_long),
	.freed_address(released_address_by_controller),
	.context_switch_in(collision_detected),
	.in('{none,
		ex_thread_wr_host_rd,none,none,none,none,none,none,none,none,
		MUX_EXMEM_out[5], /* alu write */
		LMD_mem,MUX_EXMEM_out[4], /* mem write */
		ALU_mem,MUX_EXMEM_out[6] /* reg dest */
		}),
	.out('{MPR_MEMWB_out[14],MPR_MEMWB_out[13],MPR_MEMWB_out[12],MPR_MEMWB_out[11],
		MPR_MEMWB_out[10],MPR_MEMWB_out[9],MPR_MEMWB_out[8],MPR_MEMWB_out[7],
		MPR_MEMWB_out[6],MPR_MEMWB_out[5],
		MPR_MEMWB_out[4], /* alu write */
		MPR_MEMWB_out[3], /* mem write*/ 
		MPR_MEMWB_out[2], /* lmd*/
		MPR_MEMWB_out[1], /* regdst*/
		MPR_MEMWB_out[0] /* alu*/
		}),
	.select(memwb_select)
	);
MEMWB memwb (								
	.ALU(ALU_mem),
	.IR(instr_mem),
	.reg_dst(MUX_EXMEM_out[6]),
	.clk(clk),
	.LMD(LMD_mem),
	.mem_write(MUX_EXMEM_out[4]),
	.alu_write(MUX_EXMEM_out[5]),

	.ALU_output(ALU_memwb),
	.reg_dst_o(reg_dst_memwb),
	.LMD_o(LMD_memwb),
	.mem_write_o(mem_write_memwb),
	.alu_write_o(alu_write_memwb)
	);
mux mux_memwb(
	.select(memwb_select),
	.in('{none,none,none,none,
	none,none,none,none,none,none,
	MPR_MEMWB_out[4], /* alu write */
	MPR_MEMWB_out[3], /* mem write*/
	MPR_MEMWB_out[2], /* lmd */ 
	MPR_MEMWB_out[1], /* regdst*/
	MPR_MEMWB_out[0] /* alu*/
	  }),
	._in('{none,none,none,none,none,none,none,none,none,none,
		alu_write_memwb,mem_write_memwb,LMD_memwb,
		reg_dst_memwb,ALU_memwb}),
	.out('{MUX_MEMWB_out[14],MUX_MEMWB_out[13],MUX_MEMWB_out[12],
	MUX_MEMWB_out[11],MUX_MEMWB_out[10],MUX_MEMWB_out[9],MUX_MEMWB_out[8],
	MUX_MEMWB_out[7],MUX_MEMWB_out[6],MUX_MEMWB_out[5],MUX_MEMWB_out[4],
	MUX_MEMWB_out[3],MUX_MEMWB_out[2],MUX_MEMWB_out[1],
	MUX_MEMWB_out[0]})
	);
next_rank_predictor nrp (
	.clk(clk),
	.current_host_request(read_or_write),
	.current_NMT_op(MUX_IDEX_out[6]),

	.context_switch(context_switch_pred)
	);

test_context_switch tcs (
	.clk(clk),
	.context_switch(context_test),
	.test_freed(freed_t)
	);

assign collision_detected = collision_detected | context_switch_pred; // context_test 	
endmodule




