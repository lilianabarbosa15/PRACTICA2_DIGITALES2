/* 
	REGISTER FILE:
	4 x 8 RegisterFile con 2 lecturas, un puerto de escritura y 
	posibilidad de reset asincrono.
*/
 
 module RegisterFile ( input logic CLK,
							  input logic WE3,				  //Enable para escribir WD3 en RA3
							  input logic [1:0] RA1, RA2,   //Registros de los cuales se toman valores para RD1 y RD2
							  input logic [1:0] RA3,		  //Registro donde se escribirá valor de la ALU o de la memoria
							  input logic [7:0] WD3,	 	  //Valor que se escribirá en el registro de RA3 (en flanco de subida)
							  input logic RST,			 	  //Cuando es 1, todos los registros valen 0
							  output logic [7:0] RD1, RD2); //Valores de RA1 y RA2 (porque van a ser registros)

logic  [7:0] R[3:0];   	//4 registros de 8 bits
integer i;
initial 						//initialización de los registros
	for (i=0;i<4;i=i+1)
		R[i] = {8{1'b0}};

// Actualización:
assign RD1 = R[RA1];
assign RD2 = R[RA2];

always @(posedge CLK, posedge RST)
begin
	if (RST) begin				//Registros en 0
		for (i=0;i<4;i=i+1)
			R[i] = {8{1'b0}};
	end else if (WE3 == 0)	//Activo bajo				
		R[RA3] <= WD3; //Se escribe valor de WD3 en el registro señalado por RA3
end

endmodule
