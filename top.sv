
interface zoi #(
parameter N = 8, WIDTH = 32, ADDR_WIDTH = 5) ();
	logic [N-1:0] pc;
	logic [WIDTH-1:0] instr;
	logic [N-1:0] srcA;
	logic [N-1:0] srcB;
	logic [N-1:0] ALUResult;
	logic [N-1:0] readData;
	logic [N-1:0] WD3;
	logic [4:0] A3;
	logic [N-1:0] S;
endinterface

module inst(
	input logic [7:0] addr,
	input logic clk,
	output logic [0:31] data 
);
logic [0:31] mem [256];

always_ff @(posedge clk) begin
	data <= mem[addr];
end
endmodule

module memo(
	input logic [7:0] address, 
	input logic clock,
	input logic [7:0] data,  
	input logic wren,
	output logic [7:0] q
);

logic [7:0] memr [256];

always_ff @(posedge clock) begin
	if (wren) begin
		memr[address] <= data;	
	end
	q <= memr[address];
end

endmodule

module top;
	logic [7:0] S;
	logic reset;
	logic clock;
	logic [7:0] E;

	zoi z();

	always_comb begin	
		
	end

	cpu(reset, clock, E, S, z);

initial begin
	clock <= 0;
	forever begin
		#10 clock <= ~clock;	
	end
end

initial begin
	#1000 $finish;
end

initial begin
	reset <= 1;
	#20 reset <= ~reset;	
end

//instrucoes
initial begin
	cpu.processador.controller.inst.mem[0]= 32'hdeadbeef; //jal para 7a
	cpu.processador.controller.inst.mem[32'h7a]= {12'd252, 5'd00, 3'b010, 5'd24, 7'b0000011 }; //lw de 252 para x24
	cpu.processador.controller.inst.mem[32'h7b]= {12'h0aa, 5'd24, 3'b111, 5'd29, 7'b0010011 }; //andi de aa com x24 e escreve em x29
	E <= 8'b11010010;
end
endmodule
