module instruction_memory(
	input [31:0]pc,
	input reset,
	output [31:0]instr_code
    );

reg [7:0] Mem[127:0];

assign instr_code = {Mem[pc],Mem[pc+1],Mem[pc+2],Mem[pc+3]}; //Big Endian Memory Format

always@(reset)
begin
if(reset==0)
begin
Mem[0]= 8'h00; Mem[1]= 8'h01; Mem[2]= 8'h10; Mem[3]= 8'h20; // add s2 , s1 ,s0  //EX Hazard
Mem[4]= 8'h00; Mem[5]= 8'h02; Mem[6]= 8'h18; Mem[7]= 8'h20; // add s3 , s2 ,s0

//Mem[8]= 8'h10; Mem[9]= 8'h00; Mem[10]= 8'h00; Mem[11]= 8'h04; //beq s0,s0,0x03 //Control Hazard

Mem[8]= 8'h8c; Mem[9]= 8'h04; Mem[10]= 8'h00; Mem[11]= 8'h0c; //lw s4,12(s0)
Mem[12]= 8'h00; Mem[13]= 8'h80; Mem[14]= 8'h18; Mem[15]= 8'h20; // add s3,s4,s0

/*Mem[0]=8'h08;Mem[1]= 8'h00; Mem[2]= 8'h00; Mem[3]= 8'h02; //jump to 8
Mem[8]= 8'h00; Mem[9]= 8'h01; Mem[10]= 8'h10; Mem[11]= 8'h20; // add s2 , s1 ,s0 

Mem[12]= 8'h00; Mem[13]= 8'h01; Mem[14]= 8'h18; Mem[15]= 8'h24; // and s3,s0,s1
Mem[16]= 8'h00; Mem[17]= 8'h01; Mem[18]= 8'h30; Mem[19]= 8'h25; // or s6,s0,s1
Mem[20]= 8'h00; Mem[21]= 8'h20 ; Mem[22]=8'h28; Mem[23]= 8'h22; //sub s5,s1,s0
Mem[24]=8'h08;Mem[25]= 8'h00; Mem[26]= 8'h00; Mem[27]= 8'h0a; //jump to 40
Mem[40]= 8'hac; Mem[41]= 8'h02; Mem[42]= 8'h00; Mem[43]= 8'h0c; // sw s2,12(s0)
Mem[44]= 8'h8c; Mem[45]= 8'h04; Mem[46]= 8'h00; Mem[47]= 8'h0c; //lw s4,12(s0)
Mem[48]= 8'h10; Mem[49]= 8'h00; Mem[50]= 8'h00; Mem[51]= 8'h02; //beq s0,s0,0x02
Mem[60]=8'h08;Mem[61]= 8'h00; Mem[62]= 8'h00; Mem[63]= 8'h12; //jump to 72
Mem[72]= 8'h10; Mem[73]= 8'h00; Mem[74]= 8'h00; Mem[75]= 8'h02; //beq s0,s0,0x02*/

end
end
endmodule
