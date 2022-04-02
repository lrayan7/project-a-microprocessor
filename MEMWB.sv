module MEMWB (
	input logic [31:0] ALU,
	input logic [31:0] IR,
	input logic [4:0] reg_dst,
	input logic clk,
	input logic [31:0] LMD, 
	input logic mem_write,
	input logic alu_write,
	
	output logic [31:0] ALU_output,
	output logic [4:0] reg_dst_o,
	output logic [31:0] LMD_o,
	output logic mem_write_o,
	output logic alu_write_o
	);		
reg [31:0] ALU_output_tmp;
reg [31:0] LMD_tmp;
reg [4:0] reg_dst_tmp;
reg mem_write_tmp;
reg alu_write_tmp;
always_comb
begin 
	ALU_output_tmp = ALU;
	LMD_tmp = LMD;
	reg_dst_tmp = reg_dst;
	mem_write_tmp = mem_write;
	alu_write_tmp = alu_write;
end
always_ff @(posedge clk)
begin 
	ALU_output <= ALU_output_tmp ;
	LMD_o <= LMD_tmp ;
	reg_dst_o <= reg_dst_tmp;
	mem_write_o <= mem_write_tmp;
	alu_write_o <= alu_write_tmp;
end
endmodule	