`define READ 0 
`define WRITE 1
//------------------------------------------------------------------
module MemoryController (
	input logic clk,
	output logic [8:0] used_address,
	output logic freed,
	output logic [8:0] freed_address, 
	output logic read_or_write 
	);
//------------------------------------------------------------------
integer random_address;
integer index;
integer MEM_ACCESS_TIME = 56;
reg i;
initial
begin
	freed = 0;
	read_or_write = `WRITE;
	#56;
end


always @(posedge clk) 
begin 
	
	// random_address = $urandom_range(63);
	// used_address = random_address[8:0];		
	#50;
	MEM_ACCESS_TIME+=50;
	/* 
	activating predictor
	*/
	if(MEM_ACCESS_TIME == 256)
		read_or_write = `READ;
	else if(MEM_ACCESS_TIME == 306)
		read_or_write = `WRITE;
end
// assign used_address = 0;
// assign freed_address = 0;
//------------------------------------------------------------------
endmodule
