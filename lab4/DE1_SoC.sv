
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	
	// Hook up FSM inputs and outputs.
	logic L, R;

	userInput keyEnter (.Clock(CLOCK_50), .Reset(SW[9]), .L(~KEY[3]), .R(~KEY[0]), .outL(L), .outR(R));
	playField tugOfWar (.Clock(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .lights(LEDR[9:1]), .winner(HEX0));	

endmodule

 
 
module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; // True when not pressed, False when pressed
	logic [9:0] SW;
	logic Clock;

	DE1_SoC dut (.CLOCK_50(Clock), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																 @(posedge Clock);
	SW[9] <= 1;			   							    @(posedge Clock);
	SW[9] <= 0; KEY[3] <= 1; KEY[0] <= 1;			 @(posedge Clock);
									 KEY[0] <= 0;			 @(posedge Clock); 
									 KEY[0] <= 1;			 @(posedge Clock); // right
									 KEY[0] <= 0;			 @(posedge Clock);
									 KEY[0] <= 1;			 @(posedge Clock); // right
									 KEY[0] <= 0;			 @(posedge Clock);
									 KEY[0] <= 1;			 @(posedge Clock); // right
									 KEY[0] <= 0;			 @(posedge Clock);
									 KEY[0] <= 1;			 @(posedge Clock); // right
									 KEY[0] <= 0;			 @(posedge Clock);
																 @(posedge Clock);							
																 @(posedge Clock);							
									 KEY[0] <= 1;			 @(posedge Clock); // right & player 1 wins							
																 @(posedge Clock);							
																 @(posedge Clock);	
	SW[9] <= 1;			   								 @(posedge Clock); // reset			
	SW[9] <= 0; KEY[3] <= 1; KEY[0] <= 1; 			 @(posedge Clock); // stay in middle
					KEY[3] <= 0;							 @(posedge Clock); 
					KEY[3] <= 1;							 @(posedge Clock); // left
					KEY[3] <= 0;							 @(posedge Clock);
					KEY[3] <= 1;							 @(posedge Clock); // left
					KEY[3] <= 0;							 @(posedge Clock); 
					KEY[3] <= 1;							 @(posedge Clock); // left 
					KEY[3] <= 0;							 @(posedge Clock);
					KEY[3] <= 1;							 @(posedge Clock); // left
					KEY[3] <= 0;							 @(posedge Clock);
																 @(posedge Clock);
																 @(posedge Clock);
					KEY[3] <= 1;							 @(posedge Clock); // left & player 2 wins  
																 @(posedge Clock);
																 @(posedge Clock);
																 @(posedge Clock);
	SW[9] <= 1;			   							 	 @(posedge Clock);
	SW[9] <= 0; KEY[3] <= 1; KEY[0] <= 1;			 @(posedge Clock); 
									 KEY[0] <= 0;			 @(posedge Clock);
					KEY[3] <= 0; KEY[0] <= 1;			 @(posedge Clock);
									 KEY[0] <= 0;			 @(posedge Clock);
					KEY[3] <= 1; KEY[0] <= 1;			 @(posedge Clock);
									 KEY[0] <= 0;			 @(posedge Clock);
									 KEY[0] <= 1;			 @(posedge Clock);
									 KEY[0] <= 0;			 @(posedge Clock);
					KEY[3] <= 0; KEY[0] <= 1;			 @(posedge Clock);
									 KEY[0] <= 0;			 @(posedge Clock);
									 KEY[0] <= 1;			 @(posedge Clock);							
									 KEY[0] <= 0;			 @(posedge Clock);							
																 @(posedge Clock);							
																 @(posedge Clock);	
																 @(posedge Clock);																 
	$stop; // End the simulation.
	end
endmodule
