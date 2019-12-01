
module normalLight (Clock, Reset, L, R, NL, NR, lightOn);
	input logic Clock, Reset;
	
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, NL, NR;
	
	// when lightOn is true, the normal light should be on.
	output logic lightOn;
	
	// Your code goes here!
	logic ns;
	parameter on = 1'b1, off = 1'b0;
	
	// lightOn Logic
	always_comb begin
		case(lightOn)
			on: if ((~R & ~L) || (R & L)) ns = on;
				else ns = off;
			off: if ((NL & R & ~L) || (NR & L & ~R)) ns = on;
				else ns = off;
			default: ns = 1'bx;
		endcase
	end
	
	// DFF
	always_ff @(posedge Clock) begin
	if (Reset)
		lightOn <= off;
   else
		lightOn <= ns;
	end

endmodule	


module normalLight_testbench();
	logic Clock, Reset;
	logic L, R, NL, NR;
	logic lightOn;
	
	normalLight dut(Clock, Reset, L, R, NL, NR, lightOn);
	
	// Set up clock
	parameter CLOCK_PERIOD = 100;
	initial begin Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin 
																		@(posedge Clock);
		Reset <= 1;													@(posedge Clock);
		Reset <= 0; L <= 0; R <= 0; NL <= 0; NR <= 0;	@(posedge Clock); // off
						L <= 1; 						 NR <= 1;	@(posedge Clock); // on
																		@(posedge Clock); // off
						L <= 0; R <= 1; NL <= 1; NR <= 0;	@(posedge Clock); // on
								  R <= 0; NL <= 0;				@(posedge Clock); // on
						L <= 1; R <= 0; 			 NR <= 1;   @(posedge Clock); // off
																		@(posedge Clock); // on
						L <= 0; R <= 1; NL <= 1; 				@(posedge Clock); // off
																		@(posedge Clock); // on 
																		@(posedge Clock); // off
		$stop;
	end
	
endmodule
