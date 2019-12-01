module victory (Clock, Reset, L, R, leftLight, rightLight, winner);
	input logic Clock, Reset;
	 // L is true when left key is pressed, 
	 // R is true when right key is pressed.
	 // leftLight is true when the light on the most left is on.
	 // rightLight is true when the light on the most right is on.
	 input logic L, R, leftLight, rightLight;
	 
	 output logic [6:0] winner;
	 
	 enum bit[6:0] { inGame = 7'b1111111, p1Wins = 7'b1111001, p2Wins = 7'b0100100} ps, ns;

	 always_comb begin
		case(ps)
			inGame: if (L & ~R & leftLight)  
							ns = p2Wins;
					  else if (R & ~L & rightLight) 
							ns = p1Wins;
					  else 
							ns = inGame;
			p1Wins: ns = p1Wins;
			p2Wins: ns = p2Wins;
			default: ns = inGame;	
		endcase 
	end

	assign winner = ps;

	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= inGame;
		else
			ps <= ns;
		end

endmodule

module victory_testbench();
	 logic Clock, Reset;
	 logic L, R, leftLight, rightLight;
	 logic [6:0] winner;

	victory dut (Clock, Reset, L, R, leftLight, rightLight, winner);

	 // Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	 // Set up the inputs to the design. Each line is a clock cycle.
	 initial begin
																						 @(posedge Clock);
	 Reset <= 1;			   							    					 @(posedge Clock);
	 Reset <= 0; L <= 0; R <= 0; leftLight <= 0; rightLight <= 0;   @(posedge Clock); //off
										  leftLight <= 1; 					    @(posedge Clock); //testing when left most light is on (inGame)
					 L <= 1; 							   					    @(posedge Clock); //LEFT is pressed and RIGHT not (P1WINS)
																						 @(posedge Clock); //show winner 2  
																						 @(posedge Clock); //show winner 2 
																						 @(posedge Clock); //show winner 2 
	 Reset <= 1;			   							    					 @(posedge Clock); //reset
	 Reset <= 0; L <= 0; R <= 0; leftLight <= 0; rightLight <= 0;   @(posedge Clock); //off				 
																rightLight <= 1;   @(posedge Clock); //testing when right most light is on (inGame)
								R <= 1; 						  					    @(posedge Clock); //RIGHT is pressed and LEFT is not (P2WINS)
																						 @(posedge Clock); //show winner 1 
																						 @(posedge Clock); //show winner 1							
																						 @(posedge Clock); //show winner 1							
							 
	$stop; // End the simulation.
	end
endmodule
 