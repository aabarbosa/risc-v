`include "controller.sv"
`include "datapath.sv"

module processador #(parameter RS_WIDTH = 5, DATA_WIDTH = 8, ALU_WIDTH = 4) (
	input logic reset, 
	input logic clk, 
	interface z, 
	output logic[DATA_WIDTH-1:0] ALUResult,
	input logic[DATA_WIDTH-1:0] readData,
	output logic[DATA_WIDTH-1:0] writeData,
	output logic memWrite
);

logic [RS_WIDTH-1:0] ra;
logic [RS_WIDTH-1:0] RS1;
logic [RS_WIDTH-1:0] RS2;
logic [DATA_WIDTH-1:0] IMM;
logic [RS_WIDTH-1:0] RD;
logic memToReg;
logic regWrite;
logic ALUSrc;
logic zero;
logic jalSrc;
logic[ALU_WIDTH-1:0] ALUControl;

controller(.*);
datapath(.*);

endmodule

