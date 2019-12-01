
module key(Clock, Reset, key, out);

	input logic Clock, Reset, key;
	output logic out;
	
	logic ns, FF1Out;
	parameter on = 1'b1, off = 1'b0;

	always_comb() begin
		case(out)
			on: ns = off;
			off: if ((key == on) & (key != FF1Out)) ns = on;
				else ns = off;
			default: ns = off;
		endcase
	end
	
	always_ff @(posedge Clock) begin
		if (Reset) begin
			FF1Out <= off;
			out <= off;
		end
		else begin 
			FF1Out <= key;
			out <= ns;
		end
	end
	
endmodule





module key_testbench();

endmodule
