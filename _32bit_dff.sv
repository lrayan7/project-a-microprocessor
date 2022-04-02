
module _32bit_dff (
	input logic clk,
	input logic save,
	input logic [31:0] data,

	output reg [31:0] restored
);

reg [31:0] FF_out;
reg [31:0] FF_in;
wire tmp;
genvar i;
generate
  for (i=0; i<32; i=i+1) begin : _32_dffs
  	DFLIPFLOP ff (
  		.Q(FF_out[i]),
		.D(FF_in[i]),
		.clk(clk),
		.Qbar(tmp)
		);
  end
endgenerate

always @(posedge save)
begin
  	restored = FF_out;
  	FF_in = data;
end
endmodule



