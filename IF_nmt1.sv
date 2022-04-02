`define INSTR_MEM_SZ 3400
`define THREAD_INSTR_MEM_SZ 250

module IF_nmt1 (
	input logic         clk,	
	input reg context_switch,
	input reg [31:0] current_thread_pc, /*  pc from first MPR*/

	output logic [31:0] instruction,
	output logic [31:0] pc_o
);
reg [31:0] instruction_memory [`INSTR_MEM_SZ - 1:0];
integer i;
reg [31:0] pc_tmp;
reg [3:0] thread_cnt;

initial
begin
	thread_cnt = 4'b00;
	pc_tmp = 32'b0;

	for (i=0; i<`INSTR_MEM_SZ; i=i+1) instruction_memory[i] = 32'b0;	

instruction_memory[1] = 32'b00000000001010000000100011; // sw x0,0(x1)

							   // 0100001000000010010011

instruction_memory[2] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[6] = 32'b00000000001010000000100011; // sw x0,0(x1)
instruction_memory[7] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[11] = 32'b00000000001010000000100011; // sw x0,0(x1)
instruction_memory[12] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[16] = 32'b00000000001010000000100011; // sw x0,0(x1)
instruction_memory[17] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[21] = 32'b00000000001010000000100011; // sw x0,0(x1)
instruction_memory[22] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[26] = 32'b00000000001010000000100011; // sw x0,0(x1)
instruction_memory[27] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[31] = 32'b00000000001010000000100011; // sw x0,0(x1)
instruction_memory[32] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[36] = 32'b00000000001010000000100011; // sw x0,0(x1)
instruction_memory[37] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[41] = 32'b00000000001010000000100011; // sw x0,0(x1)
instruction_memory[42] = 32'b0100001000000010010011; // addi x1,x1,1
instruction_memory[46] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[50] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[54] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[58] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[62] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[66] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[70] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[74] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[78] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[82] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[86] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[90] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[94] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[98] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[102] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[106] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[110] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[114] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[118] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[122] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[126] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[130] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[134] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[138] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[142] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[146] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[150] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[154] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[158] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[162] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[166] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[170] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[174] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[178] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[182] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[186] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[190] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[194] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[198] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[202] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[206] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[210] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[214] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[218] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[222] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[226] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[230] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[234] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[238] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[242] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[246] = 32'b0000000000000000000010011; // addi x0,x0,0

instruction_memory[250] =  32'b00001000011010000000100011; // sw x2,0(x3) 
								   // 0100011000000110010011
instruction_memory[254] =  32'b0100011000000110010011; // addi x3,x3,1 
instruction_memory[258] =  32'b00001000011010000000100011; // sw x2,0(x3) 
instruction_memory[262] =  32'b0100011000000110010011; // addi x3,x3,1 
instruction_memory[266] =  32'b00001000011010000000100011; // sw x2,0(x3) 
instruction_memory[270] =  32'b0100011000000110010011; // addi x3,x3,1 
instruction_memory[274] =  32'b00001000011010000000100011; // sw x2,0(x3) 
instruction_memory[278] =  32'b0100011000000110010011; // addi x3,x3,1 
instruction_memory[282] =  32'b00001000011010000000100011; // sw x2,0(x3) 
instruction_memory[286] =  32'b0100011000000110010011; // addi x3,x3,1 
instruction_memory[290] =  32'b00001000011010000000100011; // sw x2,0(x3) 
instruction_memory[294] =  32'b0100011000000110010011; // addi x3,x3,1 
instruction_memory[298] =  32'b00001000011010000000100011; // sw x2,0(x3) 
instruction_memory[302] =  32'b0100011000000110010011; // addi x3,x3,1 
instruction_memory[306] =  32'b00001000011010000000100011; // sw x2,0(x3) 
instruction_memory[310] =  32'b0100011000000110010011; // addi x3,x3,1  
instruction_memory[314] =  32'b00001000011010000000100011; // sw x2,0(x3) 
instruction_memory[318] =  32'b0100011000000110010011; // addi x3,x3,1 
instruction_memory[322] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[326] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[330] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[334] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[338] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[342] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[346] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[350] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[354] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[358] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[362] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[366] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[370] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[374] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[378] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[382] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[386] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[390] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[394] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[398] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[402] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[406] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[410] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[414] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[418] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[422] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[426] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[430] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[434] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[438] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[442] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[446] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[450] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[454] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[458] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[462] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[466] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[470] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[474] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[478] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[482] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[486] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[490] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[494] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[498] = 32'b0000000000000000000010011; // addi x0,x0,0

instruction_memory[502]  = 32'b00010000101010000000100011; // sw x4,0(x5)
							      // 0100101000001010010011
instruction_memory[506]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[510]  = 32'b00010000101010000000100011; // sw x4,0(x5)
instruction_memory[514]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[518]  = 32'b00010000101010000000100011; // sw x4,0(x5)
instruction_memory[522]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[526]  = 32'b00010000101010000000100011; // sw x4,0(x5)
instruction_memory[530]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[534]  = 32'b00010000101010000000100011; // sw x4,0(x5)
instruction_memory[538]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[542]  = 32'b00010000101010000000100011; // sw x4,0(x5)
instruction_memory[546]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[550]  = 32'b00010000101010000000100011; // sw x4,0(x5)
instruction_memory[554]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[558]  = 32'b00010000101010000000100011; // sw x4,0(x5)
instruction_memory[562]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[566]  = 32'b00010000101010000000100011; // sw x4,0(x5)
instruction_memory[570]  = 32'b0100101000001010010011; // addi x5,x5,1
instruction_memory[574] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[578] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[582] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[586] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[590] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[594] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[598] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[602] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[606] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[610] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[614] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[618] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[622] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[626] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[630] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[634] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[638] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[642] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[646] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[650] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[654] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[658] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[662] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[666] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[670] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[674] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[678] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[682] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[686] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[690] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[694] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[698] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[702] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[706] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[710] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[714] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[718] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[722] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[726] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[730] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[734] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[738] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[742] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[746] = 32'b0000000000000000000010011; // addi x0,x0,0

instruction_memory[750]  = 32'b00011000111010000000100011; // sw x6,0(x7)
								   // 0100111000001110010011
instruction_memory[754]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[758]  = 32'b00011000111010000000100011; // sw x6,0(x7)
instruction_memory[762]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[766]  = 32'b00011000111010000000100011; // sw x6,0(x7)
instruction_memory[770]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[774]  = 32'b00011000111010000000100011; // sw x6,0(x7)
instruction_memory[778]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[782]  = 32'b00011000111010000000100011; // sw x6,0(x7)
instruction_memory[786]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[790]  = 32'b00011000111010000000100011; // sw x6,0(x7)
instruction_memory[794]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[798]  = 32'b00011000111010000000100011; // sw x6,0(x7)
instruction_memory[802]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[806]  = 32'b00011000111010000000100011; // sw x6,0(x7)
instruction_memory[810]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[814]  = 32'b00011000111010000000100011; // sw x6,0(x7)
instruction_memory[818]  = 32'b0100111000001110010011; // addi x7,x7,1
instruction_memory[822] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[826] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[830] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[834] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[838] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[842] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[846] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[850] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[854] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[858] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[862] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[866] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[870] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[874] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[878] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[882] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[886] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[890] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[894] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[898] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[902] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[906] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[910] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[914] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[918] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[922] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[926] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[930] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[934] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[938] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[942] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[946] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[950] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[954] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[958] = 32'b0000000000000000000010011; // addi x0,x0,0

instruction_memory[1011]  = 32'b00100001001010000000100011; // sw x8,0(x9)
									// 0101001000010010010011
instruction_memory[1015]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1019]  = 32'b00100001001010000000100011; // sw x8,0(x9)
instruction_memory[1023]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1027]  = 32'b00100001001010000000100011; // sw x8,0(x9)
instruction_memory[1031]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1035]  = 32'b00100001001010000000100011; // sw x8,0(x9)
instruction_memory[1039]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1043]  = 32'b00100001001010000000100011; // sw x8,0(x9)
instruction_memory[1047]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1051]  = 32'b00100001001010000000100011; // sw x8,0(x9)
instruction_memory[1055]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1059]  = 32'b00100001001010000000100011; // sw x8,0(x9)
instruction_memory[1063]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1067]  = 32'b00100001001010000000100011; // sw x8,0(x9)
instruction_memory[1071]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1075]  = 32'b00100001001010000000100011; // sw x8,0(x9)
instruction_memory[1079]  = 32'b0101001000010010010011; // addi x9,x9,1
instruction_memory[1083] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1087] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1091] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1095] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1099] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1103] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1107] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1111] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1115] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1119] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1123] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1127] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1131] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1135] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1139] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1143] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1147] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1151] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1155] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1159] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1163] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1167] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1171] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1175] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1179] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1183] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1187] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1191] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1195] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1199] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1203] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1207] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1211] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1215] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1219] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1223] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1227] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1231] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1235] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1239] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1243] = 32'b0000000000000000000010011; // addi x0,x0,0
instruction_memory[1247] = 32'b0000000000000000000010011; // addi x0,x0,0


// 	instruction_memory[1] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[2] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[6] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[7] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[11] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[12] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[16] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[17] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[21] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[22] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[26] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[27] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[31] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[32] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[36] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[37] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[41] = 32'b00000000001010000000100011; // sw x0,0(x1)
// instruction_memory[42] = 32'b0000000001000000010010011; // addi x1,x1,1
// instruction_memory[46] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[50] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[54] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[58] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[62] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[66] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[70] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[74] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[78] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[82] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[86] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[90] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[94] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[98] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[102] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[106] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[110] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[114] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[118] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[122] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[126] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[130] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[134] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[138] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[142] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[146] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[150] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[154] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[158] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[162] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[166] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[170] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[174] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[178] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[182] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[186] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[190] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[194] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[198] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[202] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[206] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[210] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[214] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[218] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[222] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[226] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[230] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[234] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[238] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[242] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[246] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[250] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[254] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[258] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[262] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[266] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[270] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[274] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[278] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[282] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[286] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[290] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[294] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[298] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[302] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[306] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[310] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[314] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[318] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[322] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[326] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[330] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[334] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[338] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[342] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[346] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[350] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[354] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[358] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[362] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[366] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[370] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[374] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[378] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[382] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[386] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[390] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[394] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[398] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[402] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[406] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[410] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[414] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[418] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[422] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[426] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[430] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[434] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[438] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[442] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[446] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[450] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[454] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[458] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[462] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[466] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[470] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[474] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[478] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[482] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[486] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[490] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[494] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[498] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[502] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[506] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[510] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[514] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[518] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[522] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[526] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[530] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[534] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[538] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[542] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[546] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[550] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[554] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[558] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[562] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[566] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[570] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[574] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[578] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[582] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[586] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[590] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[594] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[598] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[602] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[606] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[610] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[614] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[618] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[622] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[626] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[630] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[634] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[638] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[642] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[646] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[650] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[654] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[658] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[662] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[666] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[670] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[674] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[678] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[682] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[686] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[690] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[694] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[698] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[702] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[706] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[710] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[714] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[718] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[722] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[726] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[730] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[734] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[738] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[742] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[746] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[750] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[754] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[758] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[762] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[766] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[770] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[774] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[778] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[782] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[786] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[790] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[794] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[798] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[802] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[806] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[810] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[814] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[818] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[822] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[826] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[830] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[834] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[838] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[842] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[846] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[850] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[854] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[858] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[862] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[866] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[870] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[874] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[878] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[882] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[886] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[890] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[894] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[898] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[902] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[906] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[910] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[914] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[918] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[922] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[926] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[930] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[934] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[938] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[942] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[946] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[950] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[954] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[958] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[962] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[966] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[970] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[974] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[978] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[982] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[986] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[990] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[994] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[998] = 32'b0000000000000000000010011; // addi x0,x0,0
// instruction_memory[1002] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1006] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1010] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1014] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1018] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1022] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1026] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1030] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1034] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1038] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1042] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1046] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1050] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1054] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1058] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1062] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1066] = 32'b00001000011010000000100011; // sw x2,0(x3)
// instruction_memory[1070] = 32'b0000000011000000110010011; // addi x3,x3,1  
// instruction_memory[1074] = 32'b0000000000000000000010011; // addi x0,x0,0  
// instruction_memory[1078] = 32'b0000000000000000000010011; // addi x0,x0,0  
// instruction_memory[1082] = 32'b0000000000000000000010011; // addi x0,x0,0  
// instruction_memory[1086] = 32'b0000000000000000000010011; // addi x0,x0,0   
// instruction_memory[1090] = 32'b0000000000000000000010011; // addi x0,x0,0   
// instruction_memory[1094] = 32'b0000000000000000000010011; // addi x0,x0,0  
// instruction_memory[1098] = 32'b0000000000000000000010011; // addi x0,x0,0  
// instruction_memory[1102] = 32'b0000000000000000000010011; // addi x0,x0,0  



end
reg context_switch_t = 0;
always @(posedge context_switch)
begin 
	if(context_switch == 1)
		context_switch_t = 1;
	#5
	context_switch_t = 0;
end 
always @(posedge clk)
begin
/*
on context switch we store it in a register, and on posedge clk, we deal with the context switch.
priority it to posedge clk.

we check input signal current_thread_pc == 0, means we can issue new thread if thread_cnt <= 4
otherwise if current_thread_pc != 0, means that there are no more new threads to issue and we will
continue existing thread.
*/
	if(clk == 1) 
	begin
		if(context_switch_t == 1 || context_switch == 1)
		begin
			if( thread_cnt < 4 )
			begin
				thread_cnt = thread_cnt + 1;
				pc_tmp = `THREAD_INSTR_MEM_SZ*thread_cnt*4;
				pc_tmp[31:28] = thread_cnt;
				pc_tmp = pc_tmp - 4;
			end
			else
			begin 
				#1
				pc_tmp = current_thread_pc;
			end 
		end
		else if(pc_tmp == `INSTR_MEM_SZ*4) begin 
			pc_tmp = 0;
			instruction = instruction_memory[pc_tmp[27:0]>>2];
		end else begin
			pc_tmp = pc_tmp + 4;
			instruction = instruction_memory[pc_tmp[27:0]>>2];
		end
	end
end
assign pc_o = pc_tmp;
endmodule

