module if_id_pipe_reg(
	input clk,
	input reset,
	input if_id_write,
	input [31:0] PC4,
	input [31:0] instr_code,
	input flush,
	output reg [31:0] pc_if_id,
	output reg [31:0] instr_code_if_id
    );

always@(posedge clk or negedge reset)
begin
	if(reset == 1'b0 || flush == 1'b1)
	begin
		pc_if_id = 0;
		instr_code_if_id = 0;
	end
	else if(if_id_write == 1'b0)
	begin
		pc_if_id = pc_if_id;
		instr_code_if_id = instr_code_if_id; // Actions to be taken while stalling the pipeline
	end
else
	begin
		pc_if_id = PC4 + 4;
		instr_code_if_id = instr_code;
	end
end

endmodule
