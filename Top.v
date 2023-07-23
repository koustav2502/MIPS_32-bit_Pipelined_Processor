module Top(output [31:0] ALU_output, output [31:0] PC , input clk , input reset
    );
wire[31:0] instr_code;
wire [31:0] X;
wire [4:0] Reg_dest_op;
wire [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;
wire [5:0] opcode;
wire [3:0] alu_control;
wire RegDst , branch , memRead , MemtoReg , memWrite , aluSrc , regwrite;
wire [1:0] aluOp;
wire [31:0] Y; // Y is the sign extended value used for load and store
wire [31:0] B; //second input to the ALU
wire [31:0] result ; //output of ALU
wire zero_flag;
wire [31:0] read_data;
wire jump;

wire [31:0] pc_if_id,instr_code_if_id;
wire [4:0] if_id_rs, if_id_rt, if_id_rd;
wire [31:0] pc_id_ex,A_id_ex,B_id_ex,X_id_ex;
wire [4:0] rt_id_ex,rd_id_ex;

wire RegDst_id_ex,aluSrc_id_ex;
wire branch_id_ex,memRead_id_ex,memWrite_id_ex;
wire regwrite_id_ex,MemtoReg_id_ex;
wire [1:0] aluOp_id_ex;
wire [4:0]id_ex_rs, id_ex_rt, id_ex_rd;

wire [31:0] pc_branch_target;

wire branch_ex_mem,memRead_ex_mem,memWrite_ex_mem;
wire regwrite_ex_mem,MemtoReg_ex_mem;
wire [31:0] pc_branch_target_ex_mem, result_ex_mem,B_ex_mem;
wire zero_flag_ex_mem;
wire [4:0] Reg_dest_op_ex_mem;

wire regwrite_mem_wb,MemtoReg_mem_wb;
wire [31:0]read_data_mem_wb,result_mem_wb;
wire [4:0]Reg_dest_op_mem_wb;

wire [31:0] outA, outB ; //related to forwarding unit
wire [1:0] forward_A,forward_B;

wire stall ; //related to stalling unit
wire if_id_write , pcwrite ;

wire flush ; //related to branch not taken scheme
wire [31:0] PC4;

assign opcode = instr_code[31:26];
assign if_id_rs = instr_code[25:21];
assign if_id_rt = instr_code[20:16];
assign if_id_rd = instr_code[15:11];

pc_value pcv1(PC ,branch , branch_ex_mem, zero_flag_ex_mem , pc_branch_target_ex_mem, zero_flag ,reset , clk, X, jump, instr_code,pcwrite);

pc_update pa2(PC,PC4);

instruction_memory im1(PC,reset,instr_code);

assign flush = branch_ex_mem &(zero_flag_ex_mem);

if_id_pipe_reg p1(clk,reset,if_id_write,PC4,instr_code,flush,pc_if_id,instr_code_if_id); // p1 means pipeline reg 1

main_control mc0(opcode, RegDst , branch , memRead , MemtoReg , aluOp , memWrite , aluSrc , regwrite ,jump);

registers r0(instr_code[25:21],instr_code[20:16],Reg_dest_op_mem_wb,write_data,read_data1,read_data2,regwrite_mem_wb,reset,clk); //need to edit regdst signal

immediate_generator im0(instr_code,X);

stalling_unit su1(instr_code[25:21],instr_code[20:16],id_ex_rt,memRead_id_ex,stall,if_id_write,pcwrite);

id_ex_pipe_reg p2(pc_if_id, read_data1,read_data2, X,instr_code[20:16],instr_code[15:11],
RegDst,aluSrc, branch , memRead , memWrite ,regwrite,MemtoReg,aluOp,reset,clk,
if_id_rs, if_id_rt, if_id_rd,stall,flush,
pc_id_ex,A_id_ex,B_id_ex,X_id_ex,rt_id_ex,rd_id_ex,
RegDst_id_ex,aluSrc_id_ex,branch_id_ex,memRead_id_ex,memWrite_id_ex,
regwrite_id_ex,MemtoReg_id_ex,aluOp_id_ex,
id_ex_rs, id_ex_rt, id_ex_rd
);

mux2by1_5bit regdstmux(id_ex_rt, id_ex_rd,RegDst_id_ex,Reg_dest_op);

alu_control ac0(aluOp_id_ex,X_id_ex[5:0],alu_control);

sign_extender se0(X_id_ex[15:0],Y);

forwarding_mux fm1(A_id_ex,result_ex_mem,write_data,forward_A,outA);

forwarding_mux fm2(B_id_ex,result_ex_mem,write_data,forward_B,outB);

mux2by1_32bit m1(outB,X_id_ex,aluSrc_id_ex,B);

alu al1(alu_control,outA,B,result,zero_flag);

assign ALU_output = result;

pc_adder pa1(pc_id_ex,Y,pc_branch_target);

ex_mem_pipe_reg p3(
pc_branch_target,
result,
B_id_ex, 
zero_flag, 
Reg_dest_op,
branch_id_ex,
memRead_id_ex,
memWrite_id_ex,
regwrite_id_ex,
MemtoReg_id_ex,
clk,
reset,
branch_ex_mem,
memRead_ex_mem,
memWrite_ex_mem,
regwrite_ex_mem,
MemtoReg_ex_mem,
pc_branch_target_ex_mem, 
result_ex_mem,
B_ex_mem,
zero_flag_ex_mem, 
Reg_dest_op_ex_mem
);

data_memory d0(result_ex_mem,B_id_ex,read_data,memWrite_ex_mem,memRead_ex_mem,reset);

mem_wb_pipe_reg p4(read_data,
result_ex_mem,
regwrite_ex_mem,MemtoReg_ex_mem,
Reg_dest_op_ex_mem,
reset, clk,
regwrite_mem_wb,MemtoReg_mem_wb,
read_data_mem_wb,
result_mem_wb,
Reg_dest_op_mem_wb
);

mux2by1_32bit m2(result_mem_wb , read_data_mem_wb , MemtoReg_mem_wb , write_data);

forwarding_unit fu(id_ex_rs, id_ex_rt , 
Reg_dest_op_ex_mem , Reg_dest_op_mem_wb ,
regwrite_ex_mem, regwrite_mem_wb,
forward_A , forward_B);

endmodule
