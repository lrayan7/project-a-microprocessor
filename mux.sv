`define MPR_PATH 0 
`define NORMAL_PATH 1
module mux (
	input logic select,	
	input logic [31:0] in [14:0],
	input logic [31:0] _in [14:0],

	output reg [31:0] out [14:0]

);
reg select_t = `NORMAL_PATH; 

always @*
begin
	select_t = select;
end 	
	assign out = (select_t == `NORMAL_PATH) ? _in :in;
endmodule