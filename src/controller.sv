
module controller  #(
parameter DATA_WIDTH = 8, IMM_WIDTH = 8, REG_NUMBER = 32, WIDTH = 32, RS_WIDTH = 5, ALU_WIDTH = 4)(
	input logic reset, 
	input logic clk, 
	interface z,
	output logic [RS_WIDTH-1:0] RS1,  
	output logic [RS_WIDTH-1:0] RS2,
	output logic [RS_WIDTH-1:0] RD,
	output logic [IMM_WIDTH-1:0] IMM,
	output logic memToReg,
	output logic memWrite,
	output logic regWrite,
	output logic ALUSrc,
	output logic jalSrc,
	input logic zero,
	output logic [ALU_WIDTH-1:0] ALUControl,
	output logic [RS_WIDTH-1:0] ra
);

logic [DATA_WIDTH-1:0] pc, pc_;
logic [WIDTH-1:0] instr;
logic PCSrc, branch;
logic [2:0] func3;
logic [6:0] func7;
logic [4:0] opcode;
logic lw, espera;
always_comb begin
	RS1 <= instr[19:15];
	RS2 <= instr[24:20];
	RD  <= instr[11:7];

	func3 <= instr[14:12];
	func7 <= instr[31:25];
	opcode <= instr[6:2];
end

always_comb begin
	if (opcode == 5'b11011) ra <= pc + 1; else ra <= 0;

	if (opcode == 5'b00000) begin //LW
		memWrite <= 0;
		regWrite <= 1;
		IMM <= instr[27:20];
		ALUControl <= 4'b0010;
		ALUSrc <= 1;
		memToReg <= 1;
		lw <= 1'b1; 
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end 
	else if (opcode  == 5'b01000) begin //SW
		memWrite <= 1;
		regWrite <= 0;
		IMM <= {instr[31:25], instr[11:7]};
		ALUControl <= 4'b0010;
		ALUSrc <= 1;
		memToReg <= 0;
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end
	else if (opcode == 5'b11000 && func3 == 3'b000) begin //BEQ
		memWrite <= 0;
		regWrite <= 0;
		IMM <= {instr[29:25], instr[11:9]}; 
		ALUControl <= 4'b0110;
		ALUSrc <= 0;
		memToReg <= 0;
		lw <= 1'b0;
		branch <= 1;
		if (zero) PCSrc <= 1; else PCSrc <= 0; 
		jalSrc <= 0;
	end
	else if (opcode == 5'b11000 && func3 == 3'b001) begin //BNE
		memWrite <= 0;
		regWrite <= 0;
		IMM <= {instr[29:25], instr[11:9]}; 
		ALUControl <= 4'b0110;
		ALUSrc <= 0;
		memToReg <= 0;
		lw <= 1'b0;
		branch <= 1;
		if (~zero) PCSrc <= 1; else PCSrc <= 0;
		jalSrc <= 0;
	end

	else if (opcode == 5'b01100 && func3 == 3'b100) begin //XOR
		memWrite <= 0;
		regWrite <= 1;
		IMM <= 0; 
		ALUSrc <= 0;
		ALUControl <= 4'b0100;
		memToReg <= 0; // 
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end
	else if (opcode == 5'b00100 && func3 == 3'b100) begin //XORI
		memWrite <= 0; 
		regWrite <= 1; 
		IMM <= instr[27:20];
		ALUSrc <= 1; 
		ALUControl <= 4'b0100;
		memToReg <= 0; // 
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end
	else if (opcode == 5'b00100 && func3 == 3'b110) begin //ORI
		memWrite <= 0; 
		regWrite <= 1; 
		IMM <= instr[27:20];
		ALUSrc <= 1; 
		ALUControl <= 4'b0001;
		memToReg <= 0; 
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end
	else if (opcode == 5'b00100 && func3 == 3'b111) begin //ANDI
		memWrite <= 0; 
		regWrite <= 1; 
		IMM <= instr[27:20];
		ALUSrc <= 1; 
		ALUControl <= 4'b0000;
		memToReg <= 0; 
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end
	else if (opcode == 5'b01100 && func3 == 3'b101) begin //SRL
		memWrite <= 0;
		regWrite <= 1;
		IMM <= 0;
		ALUControl <= 4'b0011;
		ALUSrc <= 0;
		memToReg <= 0;
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end
	else if (opcode == 5'b01100 && func3 == 3'b000 && func7 == 0) begin //ADD
		memWrite <= 0;
		regWrite <= 1;
		IMM <= 0;
		ALUControl <= 4'b0010;
		ALUSrc <= 0;
		memToReg <= 0;
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end

	else if (opcode == 5'b01100 && func3 == 3'b000 && func7 == 7'b0100000) begin //SUB
		memWrite <= 0;
		regWrite <= 1;
		IMM <= 0100000;
		ALUControl <= 4'b0110;
		ALUSrc <= 0;
		memToReg <= 0;
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
	end
	else if (opcode == 5'b11011) begin //JAL
		memWrite <= 0; 
		regWrite <= 0;
		IMM <= {instr[29:22]}; 
		ALUControl <= 0;
		ALUSrc <= 0;
		memToReg <= 0;
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0; 
		jalSrc <=1;
	end
	else begin // ADDI
		memWrite <= 0;
		regWrite <= 1;
		ALUSrc <= 1;
		IMM <= instr[27:20];
		ALUControl <= 4'b0010;
		memToReg <= 0;
		lw <= 1'b0;
		branch <= 0;
		PCSrc <= 0;
		jalSrc <= 0;
        end
end


always_comb begin
	if (reset) pc_ <= 0;
	else if (!espera && lw) pc_ <= pc;
	else if (PCSrc) pc_ <= pc + IMM;
	else if (opcode == 'b11011) pc_ <= pc + IMM;
	else pc_ <= pc + 1;
end

always_ff @(posedge clk) begin
	if (reset) espera <= 1'b0;
	else begin
		if (lw) espera <= 1'b1;
		if (espera) espera <= 1'b0;
	end
end

always_ff @(posedge clk) pc <= pc_;

inst(pc_, clk, instr);  

always_comb begin
	z.pc <= pc;
	z.instr <= instr;
end


endmodule

