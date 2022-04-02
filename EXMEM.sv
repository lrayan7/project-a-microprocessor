module EXMEM (
	input logic [31:0] ALU,
	input logic [6:0] opcode,
	input logic cond,
	input logic [31:0] instr,
	input logic [4:0] reg_dst,
	input logic clk,
	input logic [31:0] reg2,
	input logic mem_write,
	input logic alu_write,
	input logic [1:0] cmd_type,
	
	output logic [31:0] ALU_output,
	output logic [31:0] instr_o,
	output logic [6:0] opcode_o,
	output logic cond_o,
	output logic [4:0] reg_dst_o,
	output logic [31:0] reg2_o,
	output logic mem_write_o,
	output logic alu_write_o,
	output logic [1:0] cmd_type_o
	);
reg [31:0] ALU_output_tmp;
reg [6:0] opcode_tmp;
reg cond_tmp;
reg [31:0] instr_tmp;
reg [4:0] reg_dst_tmp;
reg [31:0] reg2_tmp;
reg mem_write_tmp;
reg alu_write_tmp;
reg [1:0] cmd_type_tmp;
always_comb
begin 
	ALU_output_tmp = ALU;
	opcode_tmp = opcode;
	cond_tmp = cond;
	instr_tmp = instr;
	reg_dst_tmp = reg_dst;
	reg2_tmp = reg2;
	mem_write_tmp = mem_write;
	alu_write_tmp = alu_write;
	cmd_type_tmp = cmd_type ;
end
always_ff @(posedge clk)
begin 
	ALU_output <= ALU_output_tmp ;
	opcode_o <= opcode_tmp ;
	cond_o <= cond_tmp ;
	instr_o <= instr_tmp ;
	reg_dst_o <= reg_dst_tmp;
	reg2_o <= reg2_tmp ;
	mem_write_o <= mem_write_tmp;
	alu_write_o <= alu_write_tmp;
	cmd_type_o <= cmd_type_tmp;
end
endmodule 