module playField (Clock, Reset, L, R, lights, winner);
	input logic Clock, Reset, L, R;
	output logic [9:1] lights;
	output logic [6:0] winner;
	
	normalLight one(.Clock, .Reset, .L, .R, .NL(lights[2]), .NR(1'b0), .lightOn(lights[1]));
	normalLight two(.Clock, .Reset, .L, .R, .NL(lights[3]), .NR(lights[1]), .lightOn(lights[2]));
	normalLight three(.Clock, .Reset, .L, .R, .NL(lights[4]), .NR(lights[2]), .lightOn(lights[3]));  
	normalLight four(.Clock, .Reset, .L, .R, .NL(lights[5]), .NR(lights[3]), .lightOn(lights[4]));  
	
	centerLight center(.Clock, .Reset, .L, .R, .NL(lights[6]), .NR(lights[4]), .lightOn(lights[5]));  
	
	normalLight six(.Clock, .Reset, .L, .R, .NL(lights[7]), .NR(lights[5]), .lightOn(lights[6]));
	normalLight seven(.Clock, .Reset, .L, .R, .NL(lights[8]), .NR(lights[6]), .lightOn(lights[7]));
	normalLight eight(.Clock, .Reset, .L, .R, .NL(lights[9]), .NR(lights[7]), .lightOn(lights[8]));
	normalLight nine(.Clock, .Reset, .L, .R, .NL(1'b0), .NR(lights[8]), .lightOn(lights[9]));
	  
	victory win(.Clock, .Reset, .L, .R, .leftLight(lights[9]), .rightLight(lights[1]), .winner);
	  
endmodule

module playField_testbench();
	logic Clock, Reset, L, R;
	logic [9:1] lights;
	logic [6:0] winner;

	playField dut (Clock, Reset, L, R, lights, winner);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																	 @(posedge Clock);
	 Reset <= 1;			   							    @(posedge Clock);
	 Reset <= 0; L <= 0; R <= 0; 						    @(posedge Clock);
					 L <= 1; 									 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
					 L <= 0; 									 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
	 Reset <= 1;			   							    @(posedge Clock);
	 Reset <= 0; L <= 0; R <= 0; 						    @(posedge Clock);
								R <= 1; 							 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);	
								R <= 0;							 @(posedge Clock);							
																	 @(posedge Clock);							
																	 @(posedge Clock);	
																	 @(posedge Clock);								
	 Reset <= 1;			   							    @(posedge Clock);
	 Reset <= 0; L <= 0; R <= 0; 						    @(posedge Clock);
								R <= 1; 							 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
																	 @(posedge Clock);
					 L <= 1; 									 @(posedge Clock);	
					 L <= 0;									    @(posedge Clock);							
																	 @(posedge Clock);							
																	 @(posedge Clock);	
																	 @(posedge Clock);																 
	$stop; // End the simulation.
	end
endmodule
