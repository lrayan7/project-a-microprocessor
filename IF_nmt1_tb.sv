
module IF_nmt1_tb;

reg clk_t = 0;
always 
begin

	#5 clk_t = 1;
	#5 clk_t = 0;

end


int i;
reg context_switch_t = 0;
initial 
begin
	for (i=0;i<1000;i=i+1) begin
		#8 context_switch_t = 1;
		#8 context_switch_t = 0;
	end
end

reg [31:0] current_thread_pc_t; /*  pc from first MPR*/
assign current_thread_pc_t = 0;

wire [31:0] instruction_t;
wire [31:0] pc_o_t;

IF_nmt1 ifnmt(
.clk(clk_t),
.context_switch(context_switch_t),
.current_thread_pc(current_thread_pc_t),
.instruction(instruction_t),
.pc_o(pc_o_t)

);



endmodule

