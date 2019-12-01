
module myDesign(bcd, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input logic [3:0] bcd;
	output logic[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	always_comb begin case 
	(bcd)
		//light nothing
		4'b0000: HEX5 = 7'b1111111; 
		4'b0001: HEX5 = 7'b1111111; 
		4'b0010: HEX5 = 7'b1111111; 
		4'b0011: HEX5 = 7'b1111111; 
		4'b0100: HEX5 = 7'b1111111; 
		4'b0101: HEX5 = 7'b1111111;
		4'b0110: HEX5 = 7'b1111111; 
		4'b0111: HEX5 = 7'b1111111; 
		4'b1000: HEX5 = 7'b1111111; 
		4'b1001: HEX5 = 7'b1111111;
		default: HEX5 = 7'bx;	endcase
	end
	
	always_comb begin case 
	(bcd)
		//light nothing
		4'b0000: HEX4 = 7'b1111111; 
		4'b0001: HEX4 = 7'b1111111; 
		4'b0010: HEX4 = 7'b1111111; 
		4'b0011: HEX4 = 7'b1111111; 
		4'b0100: HEX4 = 7'b1111111; 
		4'b0101: HEX4 = 7'b1111111;
		4'b0110: HEX4 = 7'b1111111; 
		4'b0111: HEX4 = 7'b1111111; 
		4'b1000: HEX4 = 7'b1111111; 
		4'b1001: HEX4 = 7'b1111111;
		default: HEX4 = 7'bx;	endcase
	end
	
	always_comb begin case 
	(bcd)
		//light C, d
		4'b0000: HEX3 = 7'b1000110; // C 
		4'b0001: HEX3 = 7'b1000110; // C
		4'b0010: HEX3 = 7'b1000110; // C
		4'b0011: HEX3 = 7'b0100001; // d 
		4'b0100: HEX3 = 7'b1111111; 
		4'b0101: HEX3 = 7'b1111111;
		4'b0110: HEX3 = 7'b1111111; 
		4'b0111: HEX3 = 7'b1111111; 
		4'b1000: HEX3 = 7'b1111111; 
		4'b1001: HEX3 = 7'b1111111;
		default: HEX3 = 7'bx;	endcase
	end
	
	always_comb begin case 
	(bcd)
		//light A, O, U, I, I, P
		4'b0000: HEX2 = 7'b0001000; // A 
		4'b0001: HEX2 = 7'b1000000; // O 
		4'b0010: HEX2 = 7'b1000001; // U 
		4'b0011: HEX2 = 7'b1001111; // I
		4'b0100: HEX2 = 7'b1001111; // I
		4'b0101: HEX2 = 7'b0001100; // P
		4'b0110: HEX2 = 7'b1111111; 
		4'b0111: HEX2 = 7'b1111111; 
		4'b1000: HEX2 = 7'b1111111; 
		4'b1001: HEX2 = 7'b1111111;
		default: HEX2 = 7'bx;	endcase
	end
	
	always_comb begin case 
	(bcd)
		//light S, N, b, C, C, I
		4'b0000: HEX1 = 7'b0010010; // S 
		4'b0001: HEX1 = 7'b1001000; // N
		4'b0010: HEX1 = 7'b0000011; // b 
		4'b0011: HEX1 = 7'b1000110; // C 
		4'b0100: HEX1 = 7'b1000110; // C 
		4'b0101: HEX1 = 7'b1001111; // I
		4'b0110: HEX1 = 7'b1111111; 
		4'b0111: HEX1 = 7'b1111111; 
		4'b1000: HEX1 = 7'b1111111; 
		4'b1001: HEX1 = 7'b1111111;
		default: HEX1 = 7'bx;	endcase
	end
	
	always_comb begin case 
	(bcd)
		//light E
		4'b0000: HEX0 = 7'b0000110; // E 
		4'b0001: HEX0 = 7'b0000110; // E
		4'b0010: HEX0 = 7'b0000110; // E
		4'b0011: HEX0 = 7'b0000110; // E
		4'b0100: HEX0 = 7'b0000110; // E
		4'b0101: HEX0 = 7'b0000110; // E
		4'b0110: HEX0 = 7'b1111111; 
		4'b0111: HEX0 = 7'b1111111; 
		4'b1000: HEX0 = 7'b1111111; 
		4'b1001: HEX0 = 7'b1111111;
		default: HEX0 = 7'bx;	endcase
	end
	
endmodule