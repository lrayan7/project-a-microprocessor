`define READ 0 
`define WRITE 1
//------------------------------------------------------------------
module MemoryController (
	output logic [8:0] used_address,
	output logic freed,
	output logic [8:0] freed_address, 
	output logic read_or_write 
	);
//------------------------------------------------------------------
integer random_address;
integer index;
reg i;
initial
begin
	freed = 0;
	read_or_write = `WRITE;
	// for (i=0; i<100000; i=i+1)
	// begin
	//  //    	#1
	// 	// 	random_address = $urandom_range(63);
			// used_address = random_address[8:0];
	// 	// end
	// 	// #41 
	// 	freed = 1;
	// 	// freed_address = 32'b0;
	// 	#2
	// 	freed = 0 ;
	// 	#2;
	// end
end
assign used_address = 0;
assign freed_address = 0;
//------------------------------------------------------------------
endmodule
