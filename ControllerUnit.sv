/*
CONTROLLER UNIT:
El siguiente módulo implementa una unidad de control que recibe 16 bits que corresponde a 
una instrucción que proviene de la memoria de instrucciones, con el fin de transformarla
en un dato de 18 bits (ControlSignals) para poder pasarselo al Datapath Unit.

Detalle de la entrada y la salida:
ReadInstr	 : OpCode,RDst,RSrc1,R/Imm,RSrc2,ImmediateValue
	OpCode			=	ReadInstr[15:13]
	RDst				=	ReadInstr[12:11]
	RSrc1				=	ReadInstr[10:9]
	R/Imm				=	ReadInstr[8]
	RSrc2				=	ReadInstr[7:6]
	ImmediateValue	=	ReadInstr[5:0]
ControlSignal: ALUCntr,ALUorM,RDst3,WE,RSrc1,ALUSrc2,Src2
	ALUCntr	=	ControlSignal[17:15]
	ALUorM	=	ControlSignal[14]
	RDst3		=	ControlSignal[13:12]
	WE			=	ControlSignal[11]
	RSrc1		=	ControlSignal[10:9]
	ALUSrc2	=	ControlSignal[8]
	Src2		=	ControlSignal[7:0]
*/

module ControllerUnit( input logic [15:0] ReadInstr,
							  output logic [17:0] ControlSignal
							);
	
// Variables auxiliares:
logic WE,ALUorM,ALUSrc2;
logic [1:0] RSrc1, RDst3;
logic [2:0] ALUCntr;
logic [7:0] Src2;


assign Src2 = ReadInstr[7:0];
assign ALUSrc2 = ReadInstr[8];
assign RSrc1 = ReadInstr[10:9];
assign RDst3 = ReadInstr[12:11];

always_comb begin
	if(ReadInstr[15:13] == 3'b111) begin
		WE = 1'b1;
		ALUorM = 1'b0;
		ALUCntr = 3'b011;
	end
	else if(ReadInstr[15:13] == 3'b110) begin
		WE = 1'b0;
		ALUorM = 1'b1;
		ALUCntr = 3'b011;
	end
	else begin
		WE = 1'b0;
		ALUorM = 1'b0;
		ALUCntr = ReadInstr[15:13];
	end
end

assign ControlSignal = {ALUCntr,ALUorM,RDst3,WE,RSrc1,ALUSrc2,Src2};

endmodule
