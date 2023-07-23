module sign_extender(
	input [15:0]x,
	output [31:0]y
    );

assign y[31:0] = {{16{x[15]}},x[15:0]};

endmodule
