module ex_mem_pipe_reg(
	input [31:0]pc_branch_target,
	input [31:0]result, 
	input [31:0]B_id_ex,
	input zero_flag,
	input [4:0]Reg_dest_op,
	input branch_id_ex, memRead_id_ex, memWrite_id_ex,
	input regwrite_id_ex, MemtoReg_id_ex,
	input clk, reset,
	output reg branch_ex_mem, memRead_ex_mem, memWrite_ex_mem,
	output reg regwrite_ex_mem, MemtoReg_ex_mem,
	output reg[31:0]pc_branch_target_ex_mem, 
	output reg[31:0]result_ex_mem, 
	output reg[31:0]B_ex_mem,
	output reg zero_flag_ex_mem,
	output reg [4:0]Reg_dest_op_ex_mem
    );

always@(posedge clk or negedge reset)
begin
if(reset == 1'b0)
	begin
		branch_ex_mem = 0;
		memRead_ex_mem = 0;
		memWrite_ex_mem = 0;
		regwrite_ex_mem = 0;
		MemtoReg_ex_mem = 0;
		pc_branch_target_ex_mem = 0;
		result_ex_mem = 0;
		B_ex_mem = 0;
		zero_flag_ex_mem = 0;
		Reg_dest_op_ex_mem = 0;
	end
else
	begin
		branch_ex_mem = branch_id_ex;
		memRead_ex_mem = memRead_id_ex;
		memWrite_ex_mem = memWrite_id_ex;
		regwrite_ex_mem = regwrite_id_ex;
		MemtoReg_ex_mem = MemtoReg_id_ex;
		pc_branch_target_ex_mem = pc_branch_target;
		result_ex_mem = result;
		B_ex_mem = B_id_ex;
		zero_flag_ex_mem = zero_flag;
		Reg_dest_op_ex_mem = Reg_dest_op;
	end
end

endmodule
