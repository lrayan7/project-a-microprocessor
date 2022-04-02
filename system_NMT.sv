module system_NMT;
reg clk_t = 0;
always
begin
	#5 clk_t=1;
	#5 clk_t=0;
end
NMT_DEVICE nmt1(
	ALU_nmt_1,
	instr_nmt_1,
	reg2_nmt_1,
	cmd_type_nmt_1,
	
	ALU_o_1,
	IR_1,
	LMD_1);
NMT_DEVICE nmt2(
	ALU_nmt_2,
	instr_nmt_2,
	reg2_nmt_2,
	cmd_type_nmt_2,
	
	ALU_o_2,
	IR_2,
	LMD_2);
NMT_DEVICE nmt3(
	ALU_nmt_3,
	instr_nmt_3,
	reg2_nmt_3,
	cmd_type_nmt_3,
	
	ALU_o_3,
	IR_3,
	LMD_3);
NMT_DEVICE nmt4(
	ALU_nmt_4,
	instr_nmt_4,
	reg2_nmt_4,
	cmd_type_nmt_4,
	
	ALU_o_4,
	IR_4,
	LMD_4);

BIGMEM mem(
	clk_t,
	ALU_t('{ALU_nmt_4,ALU_nmt_3,ALU_nmt_2,
		ALU_nmt_1}),
	instr_t('{instr_nmt_4,instr_nmt_3,instr_nmt_2,
		instr_nmt_1}),
	reg2_t('{reg2_nmt_4,reg2_nmt_3,reg2_nmt_2,
		reg2_nmt_1}),
	cmd_type_t('{cmd_type_nmt_4,cmd_type_nmt_3,cmd_type_nmt_2,
		cmd_type_nmt_1}),
	ALU_o_t('{ALU_o_4,ALU_o_3,ALU_o_2,
		ALU_o_1}),
	IR_t('{IR_4,IR_3,IR_2,
		IR_1}),
	LMD_t('{LMD_4,LMD_3,LMD_2,
		LMD_1})
	);
endmodule




