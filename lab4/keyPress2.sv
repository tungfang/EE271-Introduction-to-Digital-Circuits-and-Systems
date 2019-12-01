
module keyPress2(Clock, Reset, key, out);
	input logic Clock, Reset, key;
	output logic out;
	
	enum {unpressed, pressed} ps, ns;
	
	// Key Press Logic
	always_comb begin
		case (ps)
			unpressed: if (key) ns = pressed;
				else ns = unpressed;
			pressed: if (key) ns = pressed;
				else ns = unpressed;
		endcase
	end
	
	assign out = (ps == pressed) & ~key;
	
	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= unpressed;
		else
			ps <= ns;
		end
		
	// metastability dut (.Clock, .Reset, .in(key), .out);
	
endmodule

module keyPress2_testbench();
	logic Clock, Reset, key;
	logic out;
	
	keyPress2 dut (Clock, Reset, key, out);
	
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
						key <= 0;		@(posedge Clock); // off
											@(posedge Clock); // on
											@(posedge Clock); // off
		Reset <= 0; key <= 1;  		@(posedge Clock);  
											@(posedge Clock); // off
						key <= 0;		@(posedge Clock); // off
											@(posedge Clock); // on
		$stop;
	end
	
endmodule
