/*
DATAPATH UNIT:
El siguiente módulo implementa una unidad que se encarga de las operaciones aritmeticas
y lógicas de la CPU. Dentro del siguiente módulo se encuentra la interconexión de
multiplexores, una ALU y un banco de registros.

Detalle de la entrada "ControlSignals":
	ALUCntr 	= ControlSignals[17:15]
	ALUorM 	= ControlSignals[14]
	RDst3 	= ControlSignals[13:12]
	WE 		= ControlSignals[11]
	RSrc1 	= ControlSignals[10:9]
	ALUSrc2 	= ControlSignals[8]
	Src2 		= ControlSignals[7:0]
*/
module DatapathUnit( input logic CLK,
							input logic RST,
							input logic [17:0] ControlSignals,
							input logic [7:0] ReadData,
							output logic [2:0] DatapathSignals, //ALUFlags
							output logic [7:0] DataAddr,
							output logic [7:0] WriteData
						 );

// Variables auxiliares:
logic [1:0] M1RA2;
logic [7:0] M2B, RD1A, M3WD3;
 
// Instanciación Multiplexores:
Mux #(.width(2)) M1 (ControlSignals[11],ControlSignals[7:6],ControlSignals[13:12],M1RA2);	//2 bits
Mux #(.width(8)) M2 (ControlSignals[8],WriteData, ControlSignals[7:0],M2B);		//8 bits
Mux #(.width(8)) M3 (ControlSignals[14],DataAddr,ReadData,M3WD3);						//8 bits

// Instanciación ALU:
ALU ALU1 (RD1A,M2B,ControlSignals[17:15],DataAddr,DatapathSignals);

// Instanciación RegisterFile:
RegisterFile Register_File (CLK,ControlSignals[11],ControlSignals[10:9],M1RA2,ControlSignals[13:12],M3WD3,RST,RD1A,WriteData);
	 
endmodule
