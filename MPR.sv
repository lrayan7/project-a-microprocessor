`define MPR_PATH 0 
`define NORMAL_PATH 1
`define UNLOCK 0
`define LOCK 1
`define UNINITIALIZED 0
`define UNFREE 0
`define FREE 1

module MPR (
	input logic clk,
	input logic context_switch_in,
	input logic [8:0] address,
	input logic freed,
	input logic [8:0] freed_address,
	input logic [31:0] in [14:0],

	output reg [31:0] out [14:0],
	output logic select

);
reg context_switch = 0;
reg [1:0] MUX_SELECT;
reg MPR_LOCK [3:0];
reg [8:0] conflicted_addresses [3:0] ;
int l=0;
reg MPR_CONTEXT_SWITCH [3:0];
initial
begin
	for(l=0;l<4;l=l+1) begin
		conflicted_addresses[l] = `UNINITIALIZED;
		MPR_CONTEXT_SWITCH[l] = 0;
	end
end
reg [31:0] MUX_OUT [14:0];
reg MPR_FREED [3:0];
reg [31:0] MPR_IN_1 [14:0];
reg [31:0] MPR_IN_2 [14:0];
reg [31:0] MPR_IN_3 [14:0];
reg [31:0] MPR_IN_4 [14:0];

reg [31:0] MPR_OUT_1 [14:0];
reg [31:0] MPR_OUT_2 [14:0];
reg [31:0] MPR_OUT_3 [14:0];
reg [31:0] MPR_OUT_4 [14:0];

reg MPR_SELECT_1 = `NORMAL_PATH ;
reg MPR_SELECT_2 = `NORMAL_PATH ;
reg MPR_SELECT_3 = `NORMAL_PATH ;
reg MPR_SELECT_4 = `NORMAL_PATH ;

  
MPR_SLOT mpr_1(
	.clk(clk),
	.context_switch(MPR_CONTEXT_SWITCH[0]),
	.freed(MPR_FREED[0]),
	.in('{MPR_IN_1[0],MPR_IN_1[1],MPR_IN_1[2],MPR_IN_1[3],MPR_IN_1[4],
		  MPR_IN_1[5],MPR_IN_1[6],MPR_IN_1[7],MPR_IN_1[8],MPR_IN_1[9],
		  MPR_IN_1[10],MPR_IN_1[11],MPR_IN_1[12],MPR_IN_1[13],MPR_IN_1[14]}),
	.out('{MPR_OUT_1[0],MPR_OUT_1[1],MPR_OUT_1[2],MPR_OUT_1[3],MPR_OUT_1[4],
		  MPR_OUT_1[5],MPR_OUT_1[6],MPR_OUT_1[7],MPR_OUT_1[8],MPR_OUT_1[9],
		  MPR_OUT_1[10],MPR_OUT_1[11],MPR_OUT_1[12],MPR_OUT_1[13],MPR_OUT_1[14]}),
	.lock_state(MPR_LOCK[0]),
	.select(MPR_SELECT_1)
);
MPR_SLOT mpr_2(
	.clk(clk),
	.context_switch(MPR_CONTEXT_SWITCH[1]),
	.freed(MPR_FREED[1]),
	.in('{MPR_IN_2[0],MPR_IN_2[1],MPR_IN_2[2],MPR_IN_2[3],MPR_IN_2[4],
		  MPR_IN_2[5],MPR_IN_2[6],MPR_IN_2[7],MPR_IN_2[8],MPR_IN_2[9],
		  MPR_IN_2[10],MPR_IN_2[11],MPR_IN_2[12],MPR_IN_2[13],MPR_IN_2[14]}),
	.out('{MPR_OUT_2[0],MPR_OUT_2[1],MPR_OUT_2[2],MPR_OUT_2[3],MPR_OUT_2[4],
		  MPR_OUT_2[5],MPR_OUT_2[6],MPR_OUT_2[7],MPR_OUT_2[8],MPR_OUT_2[9],
		  MPR_OUT_2[10],MPR_OUT_2[11],MPR_OUT_2[12],MPR_OUT_2[13],MPR_OUT_2[14]}),
	.lock_state(MPR_LOCK[1]),
	.select(MPR_SELECT_2)
);
MPR_SLOT mpr_3(
	.clk(clk),
	.context_switch(MPR_CONTEXT_SWITCH[2]),
	.freed(MPR_FREED[2]),
	.in('{MPR_IN_3[0],MPR_IN_3[1],MPR_IN_3[2],MPR_IN_3[3],MPR_IN_3[4],
		  MPR_IN_3[5],MPR_IN_3[6],MPR_IN_3[7],MPR_IN_3[8],MPR_IN_3[9],
		  MPR_IN_3[10],MPR_IN_3[11],MPR_IN_3[12],MPR_IN_3[13],MPR_IN_3[14]}),
	.out('{MPR_OUT_3[0],MPR_OUT_3[1],MPR_OUT_3[2],MPR_OUT_3[3],MPR_OUT_3[4],
		  MPR_OUT_3[5],MPR_OUT_3[6],MPR_OUT_3[7],MPR_OUT_3[8],MPR_OUT_3[9],
		  MPR_OUT_3[10],MPR_OUT_3[11],MPR_OUT_3[12],MPR_OUT_3[13],MPR_OUT_3[14]}),
	.lock_state(MPR_LOCK[2]),
	.select(MPR_SELECT_3)
);
MPR_SLOT mpr_4(
	.clk(clk),
	.context_switch(MPR_CONTEXT_SWITCH[3]),
	.freed(MPR_FREED[3]),
	.in('{MPR_IN_4[0],MPR_IN_4[1],MPR_IN_4[2],MPR_IN_4[3],MPR_IN_4[4],
		  MPR_IN_4[5],MPR_IN_4[6],MPR_IN_4[7],MPR_IN_4[8],MPR_IN_4[9],
		  MPR_IN_4[10],MPR_IN_4[11],MPR_IN_4[12],MPR_IN_4[13],MPR_IN_4[14]}),
	.out('{MPR_OUT_4[0],MPR_OUT_4[1],MPR_OUT_4[2],MPR_OUT_4[3],MPR_OUT_4[4],
		  MPR_OUT_4[5],MPR_OUT_4[6],MPR_OUT_4[7],MPR_OUT_4[8],MPR_OUT_4[9],
		  MPR_OUT_4[10],MPR_OUT_4[11],MPR_OUT_4[12],MPR_OUT_4[13],MPR_OUT_4[14]}),
	.lock_state(MPR_LOCK[3]),
	.select(MPR_SELECT_4)
);
/*
if there is an address that was freed, we know it by the signal "freed",
what we do is, signal to the MPR_SLOT that the current SLOT is free to 
be retreved then MPR_SLOT will unlock its lock,
that in the next context switch we can get the relevant data from 
the MPR.
*/
assign MPR_LOCK[0] = 0;
assign MPR_LOCK[1] = 0;
assign MPR_LOCK[2] = 0;
assign MPR_LOCK[3] = 0;
always @(posedge context_switch_in)
begin 
	if( context_switch_in == 1)
		context_switch = 1;
	#5 
	context_switch = 0;
end 
int k=0;
int counter = 3;
reg stop = 1;
always @(posedge clk, posedge freed/*,posedge context_switch_in*/)
begin
	

	if (freed == 1)
	begin
		for(k = 0; k< 4;k = k +1) begin
			if(conflicted_addresses[k] == freed_address && MPR_LOCK[k] == `LOCK) begin
				counter = k;
				MPR_FREED[k] = `FREE;
			end 
		end
	end

	if(clk == 1) begin
	// MOVE COUNTER
		
		if( context_switch == 1)
		begin
			if(counter < 3)
				counter = counter + 1;
			else 
				counter = 0;
			stop = 0;
	// STORE IN RELEVANT MPR
			for(k = 0; k < 4; k = k + 1) begin
				if(stop == 0 && context_switch == 1 && MPR_LOCK[(counter + k) % 4] == `UNLOCK)
				begin
					case((counter + k) % 4)
						0: MPR_IN_1 = in;
						1: MPR_IN_2 = in;
						2: MPR_IN_3 = in;
						3: MPR_IN_4 = in;
					endcase 
					MPR_CONTEXT_SWITCH[(counter + k) % 4] = context_switch;
					stop = 1;
				end			
			end			

// STORE ADDRESS
				conflicted_addresses[counter] = address;
			#1
			for (k=0;k<4;k=k+1)
				MPR_CONTEXT_SWITCH[k] = 0;
		end
	end
	
end



assign MUX_SELECT 
			  =	(MPR_SELECT_1 == `MPR_PATH ) ?
		2'b00 : (MPR_SELECT_2 == `MPR_PATH ) ? 
		2'b01 : (MPR_SELECT_3 == `MPR_PATH ) ?
		2'b10 : 2'b11;

_4mux1 MUX(
	.select(MUX_SELECT),
	.in_1(MPR_OUT_1),
	.in_2(MPR_OUT_2),
	.in_3(MPR_OUT_3),
	.in_4(MPR_OUT_4),
	.out(MUX_OUT)	
	);
// always @(MUX_OUT[0])
// begin 
	assign out = MUX_OUT;
// 	#2;
// end  
endmodule 

