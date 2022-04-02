`define READ 0 
`define WRITE 1

module EX (
	input clk,
	input logic control_cmd, // read or write
 	input reg [8:0] address, // memory bank which is used 
	input logic [8:0] freed_address,
	input logic  [31:0] pc_i,
	input logic  [31:0] imm,
	input logic  [31:0] reg1,
	input logic  [31:0] reg2,
	input logic  [1:0]  cmd_type,
	input logic  [6:0]  opcode,
	input logic  [31:0] instr,
	input logic  [31:0] imm_alu,
	
	output logic [31:0] ALU_output,
	output logic [6:0]  opcode_o,
	output logic        cond,
	output logic [31:0] instr_o,
	output logic [31:0] reg2_o,
	output logic        mem_write,
	output logic        alu_write,
	output logic [1:0]  cmd_type_o,
	output logic context_switch,
	output logic [8:0] thread_address
);
reg [8:0] thread_address_t = 8'b0;
initial
begin
	ALU_output=0;

	context_switch = 0;
	#10
	context_switch = 0;
end

always @(posedge clk)
begin
	#1
	context_switch = 0 ;	
	if (cmd_type == 2'b01) // ALU
	begin
		alu_write=1;
		mem_write=0; 	
		// these parts need to be vector wise 
		if(opcode == 7'b0110011) begin // ADD/MUL/DIV
			if(instr[31:25] == 7'b0100000) // SUB
				ALU_output = reg1 - reg2;
			else if(instr[14:12] == 3'b100) // DIV
				ALU_output = reg1 / reg2;
			else if(instr[25] != 1) // ADD
				ALU_output = reg1 + reg2 ;
			else // MUL
				ALU_output = reg1 * reg2 ;
		end
		else if(opcode == 7'b0010011)
			ALU_output = reg1 + imm_alu;
		opcode_o = opcode;
		cond = 0;
	end
	else if ( cmd_type == 2'b10 ) // branch - now End Of Thread Range
	begin
		context_switch = 1; 
	end
/* 
load word - LW, or save word - SW 
*/
	else if ( cmd_type == 2'b00 )
	begin
		alu_write=0;
		ALU_output = reg1 + imm_alu; // access memory in the index "ALU_output" .
		if(opcode == 2'b0000011) // nmt read - LW
		begin
			if( address !=  ALU_output[8:0] || ( address ==  ALU_output[8:0] && control_cmd == `READ ) ) // both read 
				mem_write=1;
			else if( address ==  ALU_output[8:0] && control_cmd == `WRITE) // nmt read host write
			begin
				context_switch = 1; 
				thread_address_t = ALU_output[8:0];
			end
		end
		else // nmt write - SW
			if( address !=  ALU_output[8:0] ) 
				mem_write=0;
			else  // nmt write host write or nmt write host write  
			begin  
				context_switch = 1; 
				thread_address_t = ALU_output[8:0];
			end
			opcode_o = opcode;
			cond = 0;
		end
	else begin
		alu_write=0;
		mem_write=0;
		ALU_output = 0;
		opcode_o = 0;
		cond = 0;
	end
end


assign thread_address = thread_address_t;
assign instr_o = instr;
assign reg2_o = reg2;
assign cmd_type_o = cmd_type;
endmodule