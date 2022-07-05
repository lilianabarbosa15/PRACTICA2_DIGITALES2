/*
		Módulo principal de la CPU, el cual integra e interconecta todo.
*/

module SimpleCPU_DM_IM_LA( input logic CLK,
									input logic RST,
									output logic WE,
									output logic [7:0] InstrAddr,
									output logic [15:0] ReadInstr,
									output logic [7:0] DataAddr,
									output logic [7:0] ReadData,
									output logic [7:0] WriteData 
								 );

// Variables auxiliares:
logic [17:0] ControlSignals;
logic [2:0] DatapathSignals;
								 
// Instanciación Datapath_Unit:
DatapathUnit Datapath_Unit (CLK, RST, ControlSignals, ReadData, DatapathSignals, DataAddr, WriteData);

// Instanciación Data_Memory:
RAM Data_Memory (DataAddr, WriteData, ControlSignals[11], CLK, ReadData);	//Memoria de datos			 

// Instanciación Instruction_Memory:
InstructionMemory Instruction_Memory(InstrAddr,ReadInstr);	//Memoria de instrucciones

// Instanciación Controller_Unit_FSM:
ControllerUnit_FSM Controller_Unit_FSM(CLK,RST,ReadInstr,DatapathSignals,ControlSignals,InstrAddr);

assign WE = ControlSignals[11];

endmodule							 
				