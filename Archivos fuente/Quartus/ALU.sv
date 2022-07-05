/*
ALU:
El siguiente módulo implementa una ALU con una señal de control de 3 bits,
señales de entradas de 8 bits, una salidas de 8 bits y otra de 3 bits que
representa una bandera.

Definición de las banderas:
ALUFlags[2]: Carry
ALUFlags[1]: Greater
ALUFlags[0]: Equal
ALUFlags=000: N/A
*/

module ALU (input logic [7:0] A, B,
				input logic [2:0] ALUCntr,
				output logic [7:0] R,
				output logic [2:0] ALUFlags); 

reg [2:0] FlagsAux=3'b000;
logic [8:0] Aaux, Baux, sum;

always_comb
	begin
		case(ALUCntr)
			3'b000: R=A&B;
			3'b001: R=~B;
			3'b010: R=A^B;
			3'b011: R=A+B;
			3'b100: R=A-B;
			3'b101: R=B;
			default: R=8'b0;
		endcase
	end

// Obteniendo ALUFlags:
assign Aaux={1'b0,A};
assign Baux={1'b0,B};
assign sum=Aaux+Baux;

always@(A,B) 
	begin
		//Tamaño
		if(A>B) 					//Greater
			FlagsAux[1]=1'b1; 
		else if(A==B)			//Equal
			FlagsAux[0]=1'b1;
		else 						//Smaller
			FlagsAux=3'b000;
		//
		if(sum[8]==1'b1)		//Carry
			FlagsAux[2]=1'b1;
		else
			FlagsAux[2]=1'b0;
	end

assign ALUFlags=FlagsAux;

endmodule
