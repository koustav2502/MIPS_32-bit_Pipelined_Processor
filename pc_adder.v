module pc_adder(
	input [31:0] pc_id_ex, 
	input [31:0] Y,
	output reg [31:0] pc_branch_target
    );

always@(*)
begin
	pc_branch_target = pc_id_ex + Y;
end

endmodule