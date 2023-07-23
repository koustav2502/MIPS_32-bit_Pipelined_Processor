module Top_tb;
	reg clk;
	reg reset;
	wire [31:0] ALU_output;
	wire [31:0] PC;
    
	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.ALU_output(ALU_output), 
		.PC(PC), 
		.clk(clk), 
		.reset(reset)
	);
	
	initial begin
	clk=0;
	repeat(21)
	#50 clk=~clk;
	end

	initial begin
		// Initialize Inputs
		reset = 0;
		#20;
		// Add stimulus here
		reset = 1;
		#10;
		reset = 0;
		#5;
		reset = 1;
	end
      
endmodule
