module alu(
	input [3:0]alu_control,
	input [31:0]A,
	input [31:0]B,
	output reg [31:0]result,
	output reg zero_flag
);

always@(A,B,alu_control)
begin
	case(alu_control)
		4'b0000: result = A&B;
		4'b0001: result = A|B;
		4'b0010: result = A+B;
		4'b0110: result = A-B;
		4'b0111: begin
					if (A<B) 
						result = 1'b1;
					else 
						result = 1'b0;
					end
	endcase
end

always@(result)
begin
	if (result==0)
		zero_flag = 1'b1;
	else
		zero_flag = 1'b0;
end

endmodule