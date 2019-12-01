
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	// Declaring signals P, C, U, Mark and signals Discounted, Expensive and Stolen
	logic P, C, U, M;
	logic D, E, S;
	
	// Assigning each bit in M, C, P, U to certain switch
	assign M = SW[0];
	assign C = SW[7];
	assign P = SW[8];
	assign U = SW[9];
	
	// Assigning each LED to the certain D and S bit
	assign LEDR[0] = D;
	assign LEDR[1] = S;
	

	// Equations for D, E and S
	assign D = P | (C&U);
	assign E = ~(P|C) | (C&U);
	assign S = E&(~M);
	
	// assign 3 bits of in to switch 6, 7 and 8
	logic [3:0] in;
	assign in[0] = SW[6];
	assign in[1] = SW[7];
	assign in[2] = SW[8];
	assign in[3] = 1'b0;
	
	myDesign dut (.bcd(in), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));
	
endmodule

module DE1_SoC_testbench();
	
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

	// Using the for loop to generate all the combination to test
	integer i;
	initial begin
	
	for (i = 0; i < 2**4; i++) begin
		{SW[8], SW[7], SW[6], SW[0]} = i; #10;
	end

end

endmodule
