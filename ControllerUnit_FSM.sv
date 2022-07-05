/*
CONTROLLER UNIT - FSM:
El siguiente módulo se encarga de interconectar la máquina de estados
finitos con la unidad de control.
*/

module ControllerUnit_FSM( input logic CLK,
									input logic RST,
									input logic [15:0] ReadInstr,
									input logic [2:0] DatapathSignals, //ALUFlags
									output logic [17:0] ControlSignals,
									output logic [7:0] InstrAddr
								 );
 
// Instanciación Máquina de estados finitos:
FSM_UNIT FSM_UNIT1(CLK, RST, DatapathSignals, InstrAddr);

// Instanciación Unidad de Control:
ControllerUnit ControllerUnit1(ReadInstr, ControlSignals);

endmodule
