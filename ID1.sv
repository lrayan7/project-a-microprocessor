module ID1 (		
	input clk,
	input logic [31:0] instr,
	input logic [31:0] pc_i,
	input logic [31:0] ALU_output, // from MEMWB
	input logic [31:0] LMD_output, // from MEMWB
	input logic [4:0] reg_dst_in, // from MEMWB
	input logic mem_write,
	input logic alu_write,
	
	output logic [6:0] opcode,
	output logic [1:0] cmd_type,
	output logic [31:0] pc_o,
	output logic [31:0] imm,
	output logic [31:0] reg1_out,
	output logic [31:0] reg2_out,
	output logic [31:0] instr_o,
	output logic [4:0] reg_dst,
	output logic [31:0] imm_alu
	
	);
reg [11:0] tmp;
reg [31:0] RegFile [31:0];
always @(posedge clk)
begin 
	#1
   // sign extension	
	tmp[4:0] = instr [11:7];
	tmp[11:5] = instr [31:25];
	imm_alu[11:0] = instr [31:20];
	if(instr[31] == 1)
		imm_alu[31:12] = 20'b11111111111111111111;
	else
		imm_alu[31:12] = 20'b0;	
	// opcode
	opcode[6:0] = instr [6:0];
	// destination register 
	reg_dst = instr [11:7];
	// choosing registers 
	reg1_out = RegFile[instr[19:15]];
	reg2_out = RegFile[instr[24:20]];
	// from MEMWB
	if(alu_write) 
		RegFile[reg_dst_in[4:0]] = ALU_output;
	else if(mem_write)
		RegFile[reg_dst_in[4:0]] = LMD_output;
	if( tmp[11] == 1 )
		imm[31:12] = 20'b11111111111111111111;
	else
		imm[31:12] = 20'b0;
	imm[11:0] = tmp;
	// checks what kind of instruction this is 
	if(instr[6:0] == 7'b1100011) 
		cmd_type = 2'b10;
	else if(instr[6:0] == 7'b0110011 || instr[6:0] == 7'b0010011  ) // alu
		cmd_type = 2'b01;
	else if(instr[6:0] == 7'b0000011 || instr[6:0] == 7'b0100011 ) // memory
		begin
			cmd_type = 2'b00;
			if(instr[6:0] == 7'b0100011) 
				imm_alu[4:0] = instr [11:7];
		end
	else begin
		reg1_out = 1;
		reg2_out = 0;
		if( tmp[11] == 1 )
			imm[31:12] = 20'b11111111111111111111;
		else
			imm[31:12] = 0;
		imm[11:0] = tmp;
		cmd_type = 2'b11;
	end
end
//=========================REGISTER FILE======================
integer i;
initial
begin
	for (i=0; i<32; i=i+1) RegFile[i] = 32'b0;
	
	RegFile[0] = 1;
	RegFile[1] = 0;
	
	RegFile[2] = 2;
	RegFile[3] = 9;

	RegFile[4] = 3;
	RegFile[5] = 18;

	RegFile[6] = 4;
	RegFile[7] = 27;

	RegFile[8] = 5;
	RegFile[9] = 36;
		
end
assign pc_o = pc_i;
assign instr_o = instr;
assign out_test = RegFile[5];
assign regFile1 = RegFile[1];
assign regFile2 = RegFile[1];
endmodule
