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
     .pc('h12), .instruct('h3456789A), .d1(SWI),
     .d2a('hDE), .d2b('hF0), .d2c('hE2), .d2d('hD3), .d2e('hC4),
     .LCD_RS(LCD_RS), .LCD_E(LCD_E), .LCD_D(LCD_D));
