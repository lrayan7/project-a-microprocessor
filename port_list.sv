// system_NMT
logic ALU_nmt_1;
logic instr_nmt_1;
logic reg2_nmt_1;
logic cmd_type_nmt_1;
logic ALU_o_1;
logic IR_1;
logic LMD_1;
logic ALU_nmt_2;
logic instr_nmt_2;
logic reg2_nmt_2;
logic cmd_type_nmt_2;
logic ALU_o_2;
logic IR_2;
logic LMD_2;
logic ALU_nmt_3;
logic instr_nmt_3;
logic reg2_nmt_3;
logic cmd_type_nmt_3;
logic ALU_o_3;
logic IR_3;
logic LMD_3;
logic ALU_nmt_4;
logic instr_nmt_4;
logic reg2_nmt_4;
logic cmd_type_nmt_4;
logic ALU_o_4;
logic IR_4;
logic LMD_4;
// NEXT RANK PREDICTOR
logic context_switch_pred;
// Memcnt
logic freed_from_memcnt;
logic [31:0] ALU_mem;
logic [31:0] instr_mem;
logic [31:0] LMD_mem;
// MPR BETWEEN EX AND MEMORY
logic [31:0] MPR_EXMEM_out [14:0];
// MUX BETWEEN EX AND MEMORY
logic [31:0] MUX_EXMEM_out [14:0];
// MPR BETWEEN IF AND ID
logic [31:0] MPR_IFID_out [14:0];
// MUX BETWEEN IF AND ID
logic [31:0] MUX_IFID_out [14:0];
// MPR BETWEEN ID AND EX
logic [31:0] MPR_IDEX_out [14:0];
// MUX BETWEEN ID AND EX
logic [31:0] MUX_IDEX_out [14:0];
// MPR BETWEEN EX AND MEM
logic [31:0] MPR_MEMWB_out [14:0];
// MUX BETWEEN EX AND MEM
logic [31:0] MUX_MEMWB_out [14:0];
logic ifid_select;
logic idex_select;
logic exmem_select;
logic memwb_select;
logic collision_detected;
// logic [8:0] released_address_by_controller;
logic [8:0] ex_thread_address;
logic control_cmd;
// logic [8:0] used_address_by_controller; // from memory controller 
logic cond_ex;
logic [31:0] ALU_output;
logic [6:0] opcode_exmem;
logic [31:0] instr_if;
logic [31:0] pc_if;
logic [31:0] instr_ifid;
logic [31:0] pc_ifid;
logic [6:0] opcode_id;
logic [1:0] cmd_type;
logic [1:0] cmd_type_id;
logic [31:0] pc_id;
logic [31:0] imm_id;
logic [31:0] reg1_id;
logic [31:0] reg2_id;
logic [31:0] instr_id;
logic [4:0] reg_dst_id;
logic [31:0] pc_idex;
logic [31:0] imm_idex;
logic [31:0] reg1_idex;
logic [31:0] reg2_idex;
logic [1:0] cmd_type_idex;
logic [6:0] opcode_idex;
logic [31:0] instr_idex;
logic [4:0] reg_dst_idex;
logic [31:0] ALU_ex;
logic [6:0] opcode_ex;
logic [31:0] instr_ex;
logic [31:0] ALU_exmem;
logic [31:0] instr_exmem;
logic cond_exmem;
logic [4:0] reg_dst_exmem;
logic [31:0] ALU_memwb;
logic [4:0] reg_dst_memwb;
logic [31:0] out_test;
logic [31:0] regFile1;
logic [31:0] regFile2;
logic [31:0] imm_alu_id;
logic [31:0] imm_alu_idex;
logic [31:0] LMD_output;
logic  [31:0] reg2_ex;
logic  [31:0] reg2_exmem;
logic [31:0] LMD_memwb;
logic mem_write_ex;
logic alu_write_ex;
logic mem_write_exmem;
logic alu_write_exmem;
logic mem_write_memwb;
logic alu_write_memwb;
logic [1:0] cmd_type_ex;
logic [1:0] cmd_type_exmem;