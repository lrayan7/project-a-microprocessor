`define READ 0
`define WRITE 1
`define NMT_WRITE 2'b00



module next_rank_predictor(
	input logic clk,
	input logic current_host_request,
	input logic [1:0] current_NMT_op,

	output logic context_switch
	);
reg host_last_request = `WRITE;

initial
begin 
	context_switch = 0;
end 
always_comb 
begin 
	host_last_request = current_host_request;
end 
always @(posedge clk)
begin
/*
AT POSEDGE CLOCK
SAMPLING HOST'S LAST REQUEST
*/
	#1
	if(current_NMT_op == `NMT_WRITE && host_last_request == `READ) 	 
	begin	
		context_switch = 1;
		#1
		context_switch = 0;
	end 
end



endmodule