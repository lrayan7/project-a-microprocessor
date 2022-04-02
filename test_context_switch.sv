
module test_context_switch(
	input logic clk,
	output logic context_switch,
	output logic test_freed
	);

initial
begin 
	context_switch = 0;
end

always @(posedge clk) 
begin 
	#56
	context_switch = 1;
	#5
	context_switch = 0;
	// end 
end

endmodule