/*
	MULTIPLEXOR 2 a 1 GENERICO:
	El siguiente módulo tiene como parámetro una variable que por defecto
	es 2 y define la cantidad de bits que se recibe en las entradas in0 e
	in1, ello permite que el módulo pueda ser reutilizado en diferentes
	partes del circuito a desarrollar.
	Vale resaltar que siempre se recibe una señal de 1 bit que le permite
	al MUX seleccionar ya sea in0 o in1 como señal de salida.
*/

module Mux #(parameter width = 2)	//Debe ser mayor a 0
				(input logic select,						//Entrada a tomar (in0 o in1)
				 input logic [width-1:0] in0, in1,	//Posibles valores a seleccionar
				 output logic [width-1:0] out );
 
 always_comb begin
  if( select == 0 )
   out = in0;
  else
   out = in1;
 end

endmodule
