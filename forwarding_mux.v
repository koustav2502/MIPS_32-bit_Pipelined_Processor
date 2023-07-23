module forwarding_mux(
	input [31:0]a,
	input [31:0]b,
	input [31:0]c,
	input [1:0] sel,
	output reg [31:0] out
    );

always@(*)
	begin
		case(sel)
			1'b00 : out = a;
			1'b01 : out = b;
			1'b10 : out = c;
			default : out = a;
		endcase
	end
	
endmodule