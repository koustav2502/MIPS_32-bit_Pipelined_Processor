module mux2by1_32bit(
	input [31:0]i0,
	input [31:0]i1,
	input sel,
	output [31:0]o
    );

assign o = sel ? i1 : i0;

endmodule