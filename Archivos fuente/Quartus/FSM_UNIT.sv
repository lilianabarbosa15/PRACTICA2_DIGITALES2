/*
MÁQUINA DE ESTADOS FINITOS - FSM UNIT:
El siguiente módulo implementa una máquina de estados finitos que permite informarle a la
memoria de instrucciones la dirección pertinente de la instrucción a ejecutar.

La serie de estados que tiene la máquina permiten realizar la siguiente función:
									F = 12X - 33Y + 22Z + 4
*/

module FSM_UNIT(CLK, Reset, ALUFlags, InstrAddr);

	input logic CLK, Reset;
	input logic [2:0] ALUFlags;	//ALUFlags[1]: Greater
	output logic [7:0] InstrAddr; //256 posiciones en memoria
	
	typedef enum logic [3:0] {S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15} State;	

	State currentState,nextState;

	always_ff @(posedge Reset, posedge CLK) 
			if (Reset)
				currentState <= S0;
			else 
				currentState <= nextState;
				
	always_comb begin
		case(currentState)
			S0: begin				//R3<-0x00 (R3=0)
				InstrAddr=8'h00;
				nextState=S1;
			end
			
			S1: begin				//R0<-DataMemory[R3+0x00] (F=4)
				InstrAddr=8'h01;
				nextState=S2;
			end
			
			S2: begin				//R1<-DataMemory[R3+0x04] (A1,12)
				InstrAddr=8'h02;
				nextState=S3;
			end
			
			S3: begin				//R2<-DataMemory[R3+0x01] (X)
				InstrAddr=8'h03;
				nextState=S4;
			end
			
			S4: begin				//R0<-R0+R2 (F=F+X)
				InstrAddr=8'h04;
				nextState=S5;
			end
			
			S5: begin				//R1<-R1-0x01 (A1=A1-1)
				InstrAddr=8'h05;
				nextState=ALUFlags[1] ? S4 : S6;
			end

//Fin primer for: F=4+12X
			
			S6: begin				//R1<-DataMemory[R3+0x05] (A2,33)
				InstrAddr=8'h06;
				nextState=S7;
			end
	
			S7: begin				//R2<-DataMemory[R3+0x02] (Y)
				InstrAddr=8'h07;
				nextState=S8;
			end
			
			S8: begin				//R0<-R0-R2 (F=F-Y)
				InstrAddr=8'h08;
				nextState=S9;
			end
			
			S9: begin				//R1<-R1-0x01 (A2=A2-1)
				InstrAddr=8'h09;
				nextState=ALUFlags[1] ? S8 : S10;
			end
					
//Fin de segundo for: F=4+12X-33Y
			
			S10: begin				//R1<-DataMemory[R3+0x06] (A3,22)
				InstrAddr=8'h0A;
				nextState=S11;
			end
			
			S11: begin				//R2<-DataMemory[R3+0x03] (Z)
				InstrAddr=8'h0B;
				nextState=S12;
			end
			
			S12: begin				//R0<-R0+R2 (F=F+Z)
				InstrAddr=8'h0C;
				nextState=S13;
			end
			
			S13: begin				//R1<-R1-0x01 (A3=A3-1)
				InstrAddr=8'h0D;
				nextState=ALUFlags[1] ? S12 : S14;
			end

//Fin tercer for: F=12X-33Y+22Z+4
			
			S14: begin				//R1<-0x01 (R1=1)
				InstrAddr=8'h0E;
				nextState=S15;
			end
			
			S15: begin				//DataMemory[result]<-R0
				InstrAddr=8'h0F;
				nextState=S15;
			end
			
			default: begin
				InstrAddr=8'h00;
				nextState=S0;
			end
		endcase
	end
			
endmodule
