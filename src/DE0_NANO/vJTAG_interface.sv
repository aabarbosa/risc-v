module vJTAG_interface (
	input logic [7:0] r [0:31]
);

logic tdo, tck, tdi;
logic ir_in;
logic sdr, udr;

vJTAG   (
        .tck(tck),
        .tdi(tdi),
        .tdo(tdo),

        .ir_in(ir_in),

        .virtual_state_sdr(sdr),
        .virtual_state_udr(udr));

logic [7:0] dr; 
logic DR0_bypass_reg; // Safeguard in case bad IR is sent through JTAG 
logic [7:0] DR1; // Date, time and revision DR.  We could make separate Data Registers for each one, but

logic select_DR1;
always_comb select_DR1 = ir_in; //Data Register 1 will collect the new LED Settings

always_ff @(posedge tck)
	begin
		DR0_bypass_reg <= tdi; //Update the Bypass Register Just in case the incoming data is not sent to DR1
		
		if ( sdr )  // VJI is in Shift DR state
			if (select_DR1) //ir_in has been set to choose DR1
					DR1 <= {tdi, DR1[7:1]}; // Shifting in (and out) the data	
	end

logic [2:0] idx;

always_ff @(posedge tck)
   begin
         if (udr) idx <= 0;
         else idx <= idx+1;
   end	
		
//Maintain the TDO Continuity
always_comb begin
   if (select_DR1) begin
      if (udr)
	      tdo <= DR1[0];
      else
		   tdo <= r[dr][idx];
   end else 
	   tdo <= DR0_bypass_reg;	
end		

//The udr signal will assert when the data has been transmitted and it's time to Update the DR
//  so copy it to the Output register. 
//  Note that connecting directly to the DR1 register will cause an unwanted behavior as data is shifted through it
always @(posedge udr)
	dr <= DR1;

endmodule

