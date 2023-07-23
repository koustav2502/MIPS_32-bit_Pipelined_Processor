module data_memory(
	output reg [31:0]read_data,
	input [31:0]write_data,
	input [31:0]mem_addr,
	input memWrite,memRead,reset
    );

reg [7:0] mem [23:0];

always@(negedge reset)
begin
	if(reset==0) 
		begin 
			mem[3] = 0; mem[2] = 0; mem[1] = 0; mem[0] = 35;
			mem[7] = 0; mem[6] = 0; mem[5] = 0; mem[4] = 14;
			mem[11] = 1; mem[10] = 1; mem[9] = 1; mem[8] = 1;
			mem[15] = 1; mem[14] = 1; mem[13] = 1; mem[12] = 1;
			mem[19] = 1; mem[18] = 1; mem[17] = 1; mem[16] = 1;
		end
end

always@(mem_addr,memRead,memWrite)
begin
	if (memRead == 1 && mem_addr[1:0]==2'b00) 
		read_data = {mem[mem_addr+3],mem[mem_addr+2],mem[mem_addr+1],mem[mem_addr]};
	else if (memWrite == 1 && mem_addr[1:0]==2'b00) 
		{mem[mem_addr+3],mem[mem_addr+2],mem[mem_addr+1],mem[mem_addr]} = write_data;
end

endmodule
