`include "processador.sv"

module cpu #(
parameter DATA_WIDTH = 8, WIDTH = 32, RS_WIDTH = 5, ADDR_IO = 252, ALU_WIDTH = 4) (
	input logic reset,
	input logic clk, 
	input logic [DATA_WIDTH-1:0] E,
	output logic [DATA_WIDTH-1:0] S,
	interface z
);

logic [DATA_WIDTH-1:0] ALUResult;
logic [DATA_WIDTH-1:0] readData;
logic [DATA_WIDTH-1:0] writeData;
logic [DATA_WIDTH-1:0] RD;
logic [DATA_WIDTH-1:0] WD;
logic [DATA_WIDTH-1:0] A;
logic [DATA_WIDTH-1:0] D;

logic memWrite;
logic WE;
logic EN;

always_comb begin
	WD <= writeData;
	WE <= memWrite;
	A <= ALUResult;
end

always_comb
	if (A == ADDR_IO) readData <= E; else readData <= RD;

always_ff @(posedge clk) begin
	EN <= (A == ADDR_IO & WE); 
	if (EN) S <= WD;
end

memo(.address(ALUResult),.clock(clk), .data(writeData), .wren(memWrite), .q(RD));
processador (.*);

always_comb begin
	z.readData <= readData;
	z.S <= S;
end

endmodule

