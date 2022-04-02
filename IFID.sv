
module IFID (
	input logic [31:0] IR,
	input logic [31:0] pc_i,
	input logic clk,
	
	output logic [31:0] IR_o,
	output logic [31:0] pc_o
	);	
reg [31:0] pc_tmp;
reg [31:0] IR_tmp;
always_comb
begin 
	pc_tmp = pc_i ;
	IR_tmp = IR ;
end
always_ff @(posedge clk)
begin 
	pc_o <= pc_tmp;
	IR_o <= IR_tmp;
end
endmodule
