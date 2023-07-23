module stalling_unit(
	input [4:0]if_id_rs, 
	input [4:0]if_id_rt, 
	input [4:0]id_ex_rt, 
	input memRead_id_ex,
	output reg stall, 
	output reg if_id_write,
	output reg pcwrite
    );

always@(*)
begin
	if(memRead_id_ex == 1'b1)
		begin
		if(if_id_rs == id_ex_rt || if_id_rt == id_ex_rt )
			begin
			stall = 1'b1;
			pcwrite = 1'b0;
			if_id_write = 1'b0;
			end
		end
	else
		begin
		stall = 1'b0;
		pcwrite = 1'b1;
		if_id_write = 1'b1;
		end
end 

endmodule
