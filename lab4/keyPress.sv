
module keyPress(Clock, Reset, key, out);

	input logic Clock, Reset, key;
	output logic out;
	
	logic ns, temp;
	parameter on = 1'b1, off = 1'b0;

	always_comb begin
		case(out)
			on: ns = off; // output is true for only 1 cycle
			off: if (key == on) ns = on; // is this part correct?
				else ns = off;
			default: ns = off;
		endcase
	end
	
	always_ff @(posedge Clock) begin
		if (Reset) begin
			temp <= off;
			out <= off;
		end
		else begin
			temp <= key;
			out <= temp; // what about ns?
		end
	end
	
	
endmodule





module keyPress_testbench();
	logic Clock, Reset, key;
	logic out;
	
	keyPress dut (Clock, Reset, key, out);
	
	// Set up clock
	parameter CLOCK_PERIOD = 100;
	initial begin Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin 
											@(posedge Clock); 
		Reset <= 1;						@(posedge Clock); 
		Reset <= 0; key <= 0;		@(posedge Clock); // off
											@(posedge Clock); // off
											@(posedge Clock); 
						key <= 1;		@(posedge Clock); //  
											@(posedge Clock); // on
		Reset <= 1; 			    	@(posedge Clock); // 
											@(posedge Clock);
		Reset <= 0; key <= 0;  		@(posedge Clock); // 
											@(posedge Clock);
						key <= 1;		@(posedge Clock);
											@(posedge Clock);
		$stop;
	end
	
endmodule
