/*
MEMORIA RAM:
El siguiente módulo se encarga de tomar datos de un archivo .hex y organizarlos en una memoria de 256 datos
de 8 bits cada uno. Vale mencionar que los elementos de la memoria se pueden modificar mediante una señal
enable y una señal Addr que indica la posición de memoria que se quiere cambiar.
*/

module RAM ( input logic [7:0] Addr,
				 input logic [7:0]  WD,
				 input logic WE, 
				 input logic clk,
				 output logic [7:0] RD
				);

logic [7:0] Memoria [0:255];//

initial $readmemh("D:/Users/LILY/Desktop/practica2/DataRAM.hex",Memoria); //Susceptible a cambios.
				
always_ff@(posedge clk)
begin
	if(WE) 
		Memoria[Addr]<=WD;	//Escritura en la memoria
end

assign RD=Memoria[Addr];	//Actualización de la salida del módulo
	
endmodule
