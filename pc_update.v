module pc_update(
	input [31:0] PC,
	output reg [31:0] PC4
    );

always@(*)
begin
	PC4 = PC + 4;
end

endmodule
