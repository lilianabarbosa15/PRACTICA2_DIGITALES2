module testbench_LA();
	
	logic clk, reset;
	logic WE;
	logic [7:0] InstrAddr;
	logic [15:0] ReadInstr;
	logic [7:0] DataAddr;
	logic [7:0] ReadData;
	logic [7:0] WriteData;
	
	// Instanciar objeto
	SimpleCPU_DM_IM_LA FCT(clk,reset,WE,InstrAddr,ReadInstr,DataAddr,ReadData,WriteData);
	
	localparam clock_cycle = 1ms; //Debe ser de 1khz
	
	initial begin
		clk = 1'b0;
		reset = 1'b1; #10;
		reset = 1'b0;
		
		#(clock_cycle*180);
		
		
		$stop;
	end
	
	always #(clock_cycle/2) clk = ~clk;
	
endmodule