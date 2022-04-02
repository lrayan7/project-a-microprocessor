
module _4mux1 (

	input logic [1:0]  select,
	input logic [31:0] in_1 [14:0],
	input logic [31:0] in_2 [14:0],
	input logic [31:0] in_3 [14:0],
	input logic [31:0] in_4 [14:0],
	 
	output reg [31:0] out [14:0]
);
always_comb 
begin 
	case (select)
		2'b00: out = in_1;
 		2'b01: out = in_2;
		2'b10: out = in_3;
		2'b11: out = in_4;
	endcase 
end
endmodule
