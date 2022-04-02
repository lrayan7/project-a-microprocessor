module BIGMEM (
	
	input clk_t,
	input logic  [31:0] ALU_t [3:0],
	input logic  [31:0] instr_t [3:0],
	input logic [31:0] reg2_t [3:0],
	input logic [1:0] cmd_type_t [3:0],
	
	output logic [31:0] ALU_o_t [3:0],
	output logic [31:0] IR_t [3:0],
	output logic [31:0] LMD_t [3:0]
	
	);

MEM slice1(

	.clk(clk_t),
	.ALU(ALU_t[0]),
	.instr(instr_t[0]),
	.reg2(reg2_t[0]),
	.cmd_type(cmd_type_t[0]),
	
	.ALU_o(ALU_o_t[0]),
	.IR(IR_t[0]),
	.LMD(LMD_t[0])
	);

MEM slice2(

	.clk(clk_t),
	.ALU(ALU_t[1]),
	.instr(instr_t[1]),
	.reg2(reg2_t[1]),
	.cmd_type(cmd_type_t[1]),
	
	.ALU_o(ALU_o_t[1]),
	.IR(IR_t[1]),
	.LMD(LMD_t[1])
	);

MEM slice3(

	.clk(clk_t),
	.ALU(ALU_t[2]),
	.instr(instr_t[2]),
	.reg2(reg2_t[2]),
	.cmd_type(cmd_type_t[2]),
	
	.ALU_o(ALU_o_t[2]),
	.IR(IR_t[2]),
	.LMD(LMD_t[2])
	);

MEM slice4(

	.clk(clk_t),
	.ALU(ALU_t[3]),
	.instr(instr_t[3]),
	.reg2(reg2_t[3]),
	.cmd_type(cmd_type_t[3]),
	
	.ALU_o(ALU_o_t[3]),
	.IR(IR_t[3]),
	.LMD(LMD_t[3])
	);



endmodule 


