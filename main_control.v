module main_control(
	input [5:0]opcode,
	output reg RegDst,
	output reg branch,
	output reg memRead,
	output reg MemtoReg,
	output reg [1:0]aluOp,
	output reg memWrite,
	output reg aluSrc,
	output reg regWrite,
	output reg jump
    );

always@(opcode)
begin
	case(opcode)
		6'b000000: begin
		RegDst = 1'b1; /*R-format*/
		branch = 1'b0;
		memRead = 1'b0;
		MemtoReg = 1'b0;
		aluOp = 2'b10;
		memWrite = 1'b0;
		aluSrc = 1'b0;
		regWrite = 1'b1;
		jump = 1'b0;
		end

		6'b100011: begin
		RegDst = 1'b0;/*Load Word*/
		branch = 1'b0;
		memRead = 1'b1;
		MemtoReg = 1'b1;
		aluOp = 2'b00;
		memWrite = 1'b0;
		aluSrc = 1'b1;
		regWrite = 1'b1;  
		jump = 1'b0;
		end

		6'b101011: begin
		RegDst = 1'bx; /*Store Word*/
		branch = 1'b0;
		memRead = 1'b0;
		MemtoReg = 1'bx;
		aluOp = 2'b00;
		memWrite = 1'b1;
		aluSrc = 1'b1;
		regWrite = 1'b0;
		jump = 1'b0;
		end

		6'b000100: begin
		RegDst = 1'bx; /*Branch Equal*/
		branch = 1'b1;
		memRead = 1'b0;
		MemtoReg = 1'bx;
		aluOp = 2'b01;
		memWrite = 1'b0;
		aluSrc = 1'b0;
		regWrite = 1'b0;
		jump = 1'b0;
		end

		6'b000010: begin
		RegDst = 1'bx; /*Jump*/
		branch = 1'b0;
		memRead = 1'b0;
		MemtoReg = 1'bx;
		aluOp = 2'b00;
		memWrite = 1'b0;
		aluSrc = 1'bx;
		regWrite = 1'b0;
		jump = 1'b1;
		end

		default: begin
		RegDst = 1'b0; /*default*/
		branch = 1'b0;
		memRead = 1'b0;
		MemtoReg = 1'b0;
		aluOp = 2'b00;
		memWrite = 1'b0;
		aluSrc = 1'b0;
		regWrite = 1'b0;
		jump = 1'b0;
		end
	endcase  
end

endmodule
