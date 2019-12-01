
module hlights (clk, reset, sw, led);
	input logic clk, reset;
	input logic [1:0] sw;
	output logic [3:0] led;
	
	// State variables.
	enum { A, B, C, D} ps, ns;
	// Next State logic
	always_comb begin
		case (ps)
			A: if ({sw[0], sw[1] == 2b'10}) ns = C;
				else ns = A;
			B: if (w) ns = C;
				else ns = A;
			C: if (w) ns = C;
				else ns = A;
			D: 
		endcase
	end
	// Output logic - could also be another always, or part of above block.
	assign out = (ps == C);
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end
endmodule