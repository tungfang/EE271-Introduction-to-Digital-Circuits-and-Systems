
module userInput(Clock, Reset, L, R, outL, outR);
	input logic Clock, Reset, L, R;
	output logic outL, outR;
	
	logic tempL, tempR;
	
	metastability mL (.Clock, .Reset, .in(L), .out(tempL));
	metastability mR (.Clock, .Reset, .in(R), .out(tempR));
	keyPress2 left (.Clock, .Reset, .key(tempL), .out(outL));
	keyPress2 right (.Clock, .Reset, .key(tempR), .out(outR));
	
endmodule

module userInput_testbench();
	logic Clock, Reset, L, R;
	logic ClockL, ClockR;

	userInput dut (Clock, Reset, L, R, ClockL, ClockR);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

		 // Set up the inputs to the design. Each line is a clock cycle.
	initial begin
											@(posedge Clock);
	Reset <= 1;			   			@(posedge Clock);
	Reset <= 0; L <= 0;  R <= 0;	@(posedge Clock);
	 			   L <= 1;   			@(posedge Clock);
											@(posedge Clock);
								R <= 1;	@(posedge Clock);
											@(posedge Clock);
					L <= 0; 				@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
	$stop;
	end
endmodule
