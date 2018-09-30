/*`default_nettype none*/

interface zoi #(parameter DATA_WIDTH = 8) ();
	logic [DATA_WIDTH-1:0] pc;
	logic [31:0] instr;
	logic [DATA_WIDTH-1:0] srcA;
	logic [DATA_WIDTH-1:0] srcB;
	logic [DATA_WIDTH-1:0] ALUResult;
	logic [DATA_WIDTH-1:0] readData;
	logic [DATA_WIDTH-1:0] WD3;
	logic [4:0] A3;
	logic [N-1:0] S;
endinterface

`include "cpu.sv"

module DE0_Nano(
//////////// CLOCK //////////
input logic                         CLOCK_50,
//////////// LED //////////
output logic             [7:0]      LED,
//////////// KEY //////////
input logic              [1:0]      KEY,
//////////// SW //////////
input logic              [3:0]      SW,
//////////// SDRAM //////////
output logic            [12:0]      DRAM_ADDR,
output logic             [1:0]      DRAM_BA,
output logic                        DRAM_CAS_N,
output logic                        DRAM_CKE,
output logic                        DRAM_CLK,
output logic                        DRAM_CS_N,
inout                   [15:0]      DRAM_DQ,
output logic             [1:0]      DRAM_DQM,
output logic                        DRAM_RAS_N,
output logic                        DRAM_WE_N,
//////////// EPCS //////////
output logic                        EPCS_ASDO,
input  logic                        EPCS_DATA0,
output logic                        EPCS_DCLK,
output logic                        EPCS_NCSO,
//////////// Accelerometer and EEPROM //////////
output logic                        G_SENSOR_CS_N,
input  logic                        G_SENSOR_INT,
output logic                        I2C_SCLK,
inout  logic                        I2C_SDAT,
//////////// ADC //////////
output logic                        ADC_CS_N,
output logic                        ADC_SADDR,
output logic                        ADC_SCLK,
input logic                         ADC_SDAT,
//////////// 2x13 GPIO Header //////////
inout                   [12:0]      GPIO_2,
input logic              [2:0]      GPIO_2_IN,
//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
inout                   [33:0]      GPIO_0,
input logic              [1:0]      GPIO_0_IN,
//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
inout                   [33:0]      GPIO_1,
input logic              [1:0]      GPIO_1_IN
);

logic [7:0] SWI; // chaves pretas
always_comb SWI <= {GPIO_0[4],GPIO_0[6],GPIO_0[8],GPIO_0[5],GPIO_0[21],GPIO_0[23],GPIO_0[29],GPIO_0[18]};

logic [7:0] SEG; // display de 7 segmentos com ponto
always_comb {GPIO_0[27],GPIO_0[3],GPIO_0[1],GPIO_0[0],GPIO_0[2],GPIO_0[25],GPIO_0[31],GPIO_0[33]} <= SEG;


parameter WIDTH = 25;
logic [WIDTH-1:0] counter;
logic clock;
always_ff @(posedge CLOCK_50) begin
	if (!pause) begin
		counter <= counter + 1;
	end
end	
always_comb clock <= counter[WIDTH-1];

logic reset;
logic pause;
logic [3:0] E;

zoi z();

always_comb begin	
	LED[7] <= clock;
        LED[1] <= z.lw;
	LED[2] <= z.espera;
	reset <= SWI[0];
	pause <= SWI[1];
	E <= SWI[7:4];
end

cpu(reset, clock, E, S, z);

//Display LCD
logic LCD_RS, LCD_E;
logic [7:0] LCD_D;
always_comb begin
   GPIO_1[21] <= 0; // RW wired to GND on connector
   GPIO_1[19] <= LCD_RS;
   GPIO_1[15] <= LCD_E;
   GPIO_1[13] <= LCD_D[0];
   GPIO_1[11] <= LCD_D[1];
   GPIO_1[ 9] <= LCD_D[2];
   GPIO_1[31] <= LCD_D[3];
   GPIO_1[ 7] <= LCD_D[4];
   GPIO_1[ 5] <= LCD_D[5];
   GPIO_1[ 3] <= LCD_D[6];
   GPIO_1[ 1] <= LCD_D[7];
   GPIO_1[ 0] <= 1; // backlight anode
end


lcd (.clk(CLOCK_50), .reset(~KEY[0]),
     			.pc(z.pc), .instruct(z.instr), .d1(0),
     .d2a(z.srcA), .d2b(z.srcB), .d2c(z.ALUResult), .d2d(z.readData), .d2e(S), 
     .LCD_RS(LCD_RS), .LCD_E(LCD_E), .LCD_D(LCD_D));
//Display LCD

endmodule
