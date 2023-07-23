module id_ex_pipe_reg(
	input [31:0] pc_if_id, 
	input [31:0]read_data_1, 
	input [31:0]read_data_2, 
	input [31:0]X,
	input [4:0]rt,
	input [4:0]rd,
	input RegDst, 
	input aluSrc, 
	input branch ,  
	input memRead , 
	input memWrite ,
	input regwrite, 
	input MemtoReg,
	input [1:0] aluOp,
	input reset,clk,
	input [4:0]if_id_rs,
	input [4:0]if_id_rt,
	input [4:0]if_id_rd,
	input stall,
	input flush,
	output reg [31:0]pc_id_ex, 
	output reg [31:0]A_id_ex, 
	output reg [31:0]B_id_ex,
	output reg [31:0]X_id_ex, 
	output reg [4:0]rt_id_ex,
	output reg [4:0]rd_id_ex,
	output reg RegDst_id_ex, 
	output reg aluSrc_id_ex, 
	output reg branch_id_ex, 
	output reg memRead_id_ex, 
	output reg memWrite_id_ex, 
	output reg regwrite_id_ex, 
	output reg MemtoReg_id_ex,
	output reg [1:0]aluOp_id_ex,
	output reg [4:0]id_ex_rs, 
	output reg [4:0]id_ex_rt, 
	output reg [4:0]id_ex_rd
    );

always@(posedge clk or negedge reset)
begin
	if(reset == 1'b0 || stall == 1'b1 || flush == 1'b1)
		begin
		pc_id_ex = 0;
		A_id_ex = 0;
		B_id_ex = 0;
		X_id_ex = 0;
		rt_id_ex = 0;
		rd_id_ex = 0;
		RegDst_id_ex = 0; 
		aluSrc_id_ex = 0;
		branch_id_ex = 0;
		memRead_id_ex = 0;
		memWrite_id_ex = 0;
		regwrite_id_ex = 0;
		MemtoReg_id_ex = 0;
		id_ex_rs = 0;
		id_ex_rt = 0;
		id_ex_rd = 0;
		end
	else
		begin
		pc_id_ex = pc_if_id;
		A_id_ex = read_data_1;
		B_id_ex = read_data_2;
		X_id_ex = X;
		rt_id_ex = rt;
		rd_id_ex = rd;
		RegDst_id_ex = RegDst;
		aluSrc_id_ex = aluSrc; 
		aluOp_id_ex = aluOp;
		branch_id_ex = branch;
		memRead_id_ex = memRead;
		memWrite_id_ex = memWrite;
		regwrite_id_ex = regwrite;
		MemtoReg_id_ex = MemtoReg;
		id_ex_rs = if_id_rs;
		id_ex_rt = if_id_rt;
		id_ex_rd = if_id_rd;
	end
end

endmodule
