module mux2by1_5bit(
	input [4:0]i0,
	input [4:0]i1,
	input sel,
	output [4:0]o
    );

assign o = sel ? i1 : i0;

endmodule