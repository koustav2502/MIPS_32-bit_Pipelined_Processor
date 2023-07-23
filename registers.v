module registers(
	input [4:0]read_reg1,
	input [4:0]read_reg2,
	input [4:0]write_reg,
	input [31:0]write_data,
	output [31:0]read_data1,
	output [31:0]read_data2,
	input regwrite,
	input reset,
	input clk
    );

reg [31:0]mem[31:0];

always@(posedge clk)
begin
	if (regwrite==1'b1)
	begin
		mem[write_reg] = write_data;;
	end
end

assign read_data1 = mem[read_reg1];
assign read_data2 = mem[read_reg2];

always@(negedge reset)
	begin
		if(reset == 0)
			begin
			mem[0] = 32'h00000004;
			mem[1] = 32'h00000006;
			mem[2] = 32'h00000000;
			mem[3] = 0;
			mem[4] = 0;
			end
	end

endmodule
