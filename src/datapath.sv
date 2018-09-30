`include "vJTAG_interface.sv"
module datapath #(
parameter DATA_WIDTH = 8, IMM_WIDTH = 8, REG_NUMBER = 32, WIDTH = 32, RS_WIDTH = 5, ALU_WIDTH = 4) (
	input logic reset,
	input logic clk, 
	interface z,
	input logic [RS_WIDTH-1:0] RS1,
	input logic [RS_WIDTH-1:0] RS2,
	input logic [RS_WIDTH-1:0] RD,
	input logic [RS_WIDTH-1:0] ra,
	input logic [IMM_WIDTH-1:0] IMM,
	input logic [DATA_WIDTH-1:0] readData,
	input logic [ALU_WIDTH-1:0] ALUControl,	
	output logic [DATA_WIDTH-1:0] ALUResult,
	output logic [DATA_WIDTH-1:0] writeData,
	output logic zero,	
	input logic regWrite,
	input logic ALUSrc, 
	input logic memToReg,
	input logic jalSrc
);

logic [DATA_WIDTH-1:0] RD1;
logic [DATA_WIDTH-1:0] RD2;
logic [DATA_WIDTH-1:0] WD3;
logic [DATA_WIDTH-1:0] srcA;
logic [DATA_WIDTH-1:0] srcB;

logic [DATA_WIDTH-1:0] result;
logic [DATA_WIDTH-1:0] register_file [0:REG_NUMBER-1];

logic [DATA_WIDTH-1:0] A1;
logic [DATA_WIDTH-1:0] A2;
logic [DATA_WIDTH-1:0] A3;
logic WE3;
always_comb begin 
	WD3 <= ALUResult;
	RD1 <= register_file[RS1];
	RD2 <= register_file[RS2];
	WE3 <= regWrite;
	srcA <= RD1;
	writeData <= RD2;

	if (memToReg) result <= readData; else result <= ALUResult;
	if (ALUSrc) srcB <= IMM; else srcB <= RD2;
	if (ALUResult == 0) zero <= 1; else zero <= 0;
end

always_comb begin
	case (ALUControl)
		4'b0000 : ALUResult <= srcA & srcB;
		4'b0001 : ALUResult <= srcA | srcB;
		4'b0010 : ALUResult <= srcA + srcB;
		4'b0011 : ALUResult <= srcA >>srcB;
		4'b0100 : ALUResult <= srcA ^ srcB;
		4'b0101 : ALUResult <= srcA |~srcB;
		4'b0110 : ALUResult <= srcA - srcB;
		4'b0111 : ALUResult <= srcA < srcB;
		default: ALUResult <= 0;
        endcase
end 

always_ff @(posedge clk) begin
	register_file[0] <= 0; 
	if (reset) begin
		for (int i = 0; i < WIDTH; i++) 
			register_file[i] <= 0;
	end else begin 
		if(RD != 0 && WE3) register_file[RD] <= result;
		else if (jalSrc) register_file[1] <= ra; 
	end
end

always_comb begin
	z.srcA <= srcA;
	z.srcB <= srcB;
	z.ALUResult <= ALUResult;
end

vJTAG_interface(register_file);
endmodule

