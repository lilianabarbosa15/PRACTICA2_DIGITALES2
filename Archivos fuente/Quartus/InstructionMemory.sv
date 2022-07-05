/*
MEMORIA DE INSTRUCCIONES:
El siguiente módulo se encarga de tomar datos de un archivo .hex y organizarlos en una memoria de 256 datos
de 16 bits cada uno. Cada dato de 16 bits corresponde a una instrucción que posteriormente se le pasará a
una unidad de control para ponerla en marcha.
*/

module InstructionMemory ( input logic [7:0] InstrAddr,	//posición de memoria
									output logic [15:0] ReadInstr	//valor en memoria
								 );

logic [15:0] Memoria [0:255];//

initial $readmemh("D:/Users/LILY/Desktop/practica2/DataInstruction.hex",Memoria); //Susceptible a cambios.
		
assign ReadInstr=Memoria[InstrAddr];	//Actualización de la salida del módulo
	
endmodule
