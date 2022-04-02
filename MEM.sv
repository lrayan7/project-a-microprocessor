module MEM (
	input clk,
	input logic  [31:0] ALU,
	input logic  [31:0] instr,
	input logic [31:0] reg2,
	input logic [1:0] cmd_type,
	
	output logic [31:0] ALU_o,
	output logic [31:0] IR,
	output logic [31:0] LMD

	
	
);

reg [31:0] memory [650:0]; // for matrix update
// reg [31:0] memory [309:0]; // for matrix mul vecotr
integer i;
reg [8:0] mem_idx;


always @(posedge clk)
begin
	#1
	mem_idx = ALU [8:0];
	ALU_o = ALU;
	IR = instr;
	if(cmd_type == 2'b00) begin
		if(instr [6:0] == 7'b0000011)
			LMD = memory[mem_idx];
		else if(instr [6:0] == 7'b0100011) begin
			memory[mem_idx] = reg2;
			LMD = 0 ;
		end
		else 
			LMD = 0;
	end
	
end

initial
begin

	for (i=0; i< 650; i=i+1) 
		memory[i] = 32'b0;
	// // shared
	// 								// X 
	// 	if( i >= 64 && i < 80) 
	// 		memory[i] = 32'b11;
	// 								// RESULT VECTOR
	// 	else if(i >=80 && i < 96 ) 
	// 		memory[i] = 32'b0;
	
									
	// 	else if (i>= 96 && 160 > i) // W(0) 
	// 		memory[i] = 32'b10;
	
	
	// 								// W(1)
	// 	else if (i >= 160 && 224 > i 	) 
	// 		memory[i] = 32'b10;
	
		
	// 								// w(2)
	// 	else if(i>=224 && i < 288 ) 
	// 		memory[i] = 32'b10;
	
	
	// 								// w(3) 
	// 	if (i >= 288 && i  < 352 )
	// 		memory[i] = 32'b10;

 // 	end
	// for (i=0; i< 650; i=i+1) begin
	// // nmt 1
	// 								// w(0) = [2222222 ...]
	// 	if (i >= 0 && i  < 64 )
	// 		memory[i] = 32'b10;

	// // shared
	// 								// X 
	// 	else if( i >= 64 && i < 80) 
	// 		memory[i] = 32'b11;
	// 								// RESULT VECTOR
	// 	else if(i >=80 && i < 96 ) 
	// 		memory[i] = 32'b0;
	// // nmt 2
									
	// 	else if (i>= 96 && 160 > i) // W(1) 
	// 		memory[i] = 32'b10;
	
	// // nmt 3
	// 								// W(2)
	// 	else if (i >= 160 && 224 > i 	) 
	// 		memory[i] = 32'b10;
	
	// // nmt 4	
	// 								// w(3)
	// 	else if(i>=224 && i < 288 ) 
	// 		memory[i] = 32'b10;
	// end
end


endmodule