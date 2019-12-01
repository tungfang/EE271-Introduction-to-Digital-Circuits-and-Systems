
module metastability(Clock, Reset, in, out);
	
	input logic Clock, Reset, in;
	output logic out;
	logic temp;

	
	always_ff @(posedge Clock) begin
		if (Reset) begin
			temp <= 0;
			out <= 0;
		end
		else begin
			temp <= in;
			out <= temp;
		end
	end
	
	
	// keyPress2 dut (.Clock, .Reset, .key(in), .out(out2));
	
endmodule

module metastability_testbench();
	logic Clock, Reset, in;
	logic out;
	
	metastability dut (Clock, Reset, in, out);
	
	// Set up clock
	parameter CLOCK_PERIOD = 100;
	initial begin Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin 
											@(posedge Clock); 
		Reset <= 1;						@(posedge Clock); 
		Reset <= 0; in <= 0;			@(posedge Clock); // off
											@(posedge Clock); // off
						in <= 1;			@(posedge Clock); 
											@(posedge Clock); //  
						in <= 0;			@(posedge Clock); // on
											@(posedge Clock); // 
											@(posedge Clock);
		Reset <= 1;	in <= 1;  		@(posedge Clock); // 
											@(posedge Clock);
						in <= 0;			@(posedge Clock);
											@(posedge Clock);
		$stop;
	end

endmodule
