module immediate_generator(
	input [31:0]instr_code,
	output reg[31:0]X
    );

always@(*)
begin
	X = {{16{instr_code[15]}},instr_code[15:0]};
	X = X<<2;
end

endmodule