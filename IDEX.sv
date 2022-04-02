module IDEX (
	input logic [6:0] opcode,
	input logic [1:0] cmd_type,
	input logic [31:0] pc_i,
	input logic [31:0] imm,
	input logic [31:0] reg1,
	input logic [31:0] reg2,
	
	input logic [31:0] instr,
	input logic [4:0] reg_dst,
	input logic [31:0] imm_alu,
	input logic clk,
	
	output logic [31:0] imm_alu_o,
	output logic [31:0] pc_o,
	output logic [31:0] imm_o,
	output logic [31:0] reg1_o,
	output logic [31:0] reg2_o,
	output logic [1:0] cmd_type_o,
	output logic [6:0] opcode_o,
	output logic [31:0] instr_o,
	output logic [4:0] reg_dst_o
	);
reg [31:0] pc_tmp;
reg [31:0] imm_tmp;
reg [31:0] reg1_tmp;
reg [31:0] reg2_tmp;
reg [1:0] cmd_type_tmp;
reg [31:0] instr_tmp;
reg [6:0] opcode_tmp;
reg [4:0] reg_dst_tmp;
reg [31:0] imm_alu_tmp;
always_comb
begin 
	pc_tmp = pc_i;
	reg1_tmp = reg1;
	reg2_tmp = reg2;
	imm_tmp = imm;
	cmd_type_tmp = cmd_type;
	opcode_tmp = opcode;
	instr_tmp = instr;
	reg_dst_tmp = reg_dst;
	imm_alu_tmp = imm_alu ;
end
always_ff @(posedge clk)
begin 
	pc_o <= pc_tmp;
	imm_o <=  imm_tmp;
	reg1_o <= reg1_tmp;
	reg2_o <= reg2_tmp;
	cmd_type_o <= cmd_type_tmp;
	opcode_o <= opcode_tmp;
	instr_o <= instr_tmp;	
	reg_dst_o <= reg_dst_tmp ;	
	imm_alu_o <= imm_alu_tmp;
end
endmodule


