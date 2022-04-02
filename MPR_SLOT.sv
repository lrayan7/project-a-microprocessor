`define MPR_PATH 0 
`define NORMAL_PATH 1
`define UNLOCK 0
`define LOCK 1

module MPR_SLOT (
	input logic clk,
	input logic context_switch,
	input logic freed,
	input logic [31:0] in [14:0] ,

	output reg [31:0] out [14:0] ,
	output logic lock_state,
	output logic select
);


reg lock = `UNLOCK;
reg high = 0;
reg select_t = `NORMAL_PATH;
assign select = select_t;
reg [31:0] in_slot [14:0]; 
reg [31:0] out_slot [14:0];
genvar i;
generate
  for (i=0; i<15; i=i+1) begin : _32_dffs  
  	_32bit_dff dffs(.restored(out_slot[i]),.data(in_slot[i]),.clk(clk),.save(high));
  end
endgenerate
int j;
initial
begin
	high = 1;
	for (j = 0 ;j < 15 ; j = j+1)
		in_slot[j] = 32'b0;
	high = 0;
end


assign out = out_slot;
 
/*
on context switch,
we pull dataflow in pipepline into MPR's,
and open MPR PATH in the MUXes.
also we lock current slot from freeing. 

on clk, we hold MUX state for 1/5 clk,
afterwards return it to NORMAL PATH.


on freed address signal,
we free current MPR's lock.
*/
always @( posedge context_switch, posedge freed)
begin

	if(context_switch == 1)
	begin
		if(lock == `UNLOCK) begin
			high = 1;
			select_t = `MPR_PATH;			
			in_slot = in;	
			// lock = `LOCK;	
		end
		#1
		high = 0;
		select_t = `NORMAL_PATH;
	end 
	else if( freed == 1 )
	begin
		lock  = `UNLOCK;
	end 
end
assign lock_state = lock;
endmodule
	