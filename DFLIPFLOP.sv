
module DFLIPFLOP ( 
	output  reg  Q,
	output   Qbar, 
	
	input  logic  D, 
	input logic clk
 
);

assign Qbar = ~Q; 
always @(posedge clk) 
begin 
	Q = D;
end 
endmodule
