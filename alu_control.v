module alu_control(
	input [1:0]ALUOp,
	input [5:0]funct,
	output reg [3:0]ALUcontIN
    );

always@(ALUOp,funct)
begin
	casex({ALUOp,funct})
		8'b00xxxxxx: ALUcontIN = 4'b0010; /*lw-sw*/
		8'b01xxxxxx: ALUcontIN = 4'b0110; /*beq*/
		8'b10100000: ALUcontIN = 4'b0010; /*R-type add*/
		8'b10100010: ALUcontIN = 4'b0110; /*R-type sub*/
		8'b10100100: ALUcontIN = 4'b0000; /*R-type and*/
		8'b10100101: ALUcontIN = 4'b0001; /*R-type or*/
		8'b10101010: ALUcontIN = 4'b0111; /*R-type slt*/
	endcase
end

endmodule
