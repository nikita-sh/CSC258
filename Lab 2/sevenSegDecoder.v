//SW[3:0] inputs
//HEX0 output display

// c0 = SW[0]
// c1 = SW[1]
// c2 = SW[2]
// c3 = SW[3]

module sevenSegDecoder(SW, HEX0);
	input [9:0] SW;
	output [6:0] HEX0;

	assign HEX0[0] = (~SW[0] & SW[1] & ~SW[2] & ~SW[3]) | (SW[0] & ~SW[1] & SW[2] & SW[3]) | (SW[0] & SW[1] & ~SW[2] & SW[3]) | (~SW[0] & ~SW[1] & ~SW[2] & SW[3]);
						  
	assign HEX0[1] = (SW[0] & SW[2] & SW[3]) | (SW[0] & SW[1] & ~SW[3]) | (SW[1] & SW[2] & ~SW[3]) | (~SW[0] & SW[1] & ~SW[2] & SW[3]);
	
	assign HEX0[2] = (~SW[0] & ~SW[1] & SW[2] & ~SW[3]) | (SW[0] & SW[1] & ~SW[3]) | (SW[0] & SW[1] & SW[2]);
	
	assign HEX0[3] = (~SW[1] & ~SW[2] & SW[3]) | (SW[0] & ~SW[1] & SW[2] & ~SW[3]) | (SW[1] & SW[2] & SW[3]) | (~SW[0] & SW[1] & ~SW[2] & ~SW[3]);
						  
	assign HEX0[4] = (~SW[0] & ~SW[1] & SW[3]) | (~SW[1] & ~SW[2] & SW[3]) | (~SW[0] & SW[1] & ~SW[2]) | (~SW[0] & SW[1] & SW[3]);
						  
	assign HEX0[5] = (~SW[0] & ~SW[1] & SW[2]) | (~SW[0] & ~SW[1] & SW[3]) | (~SW[0] & SW[2] & SW[3]) | (SW[0] & SW[1] & ~SW[2] & SW[3]);
						  
	assign HEX0[6] = (~SW[0] & ~SW[1] & ~SW[2]) | (SW[0] & SW[1] & ~SW[2] & ~SW[3]) | (~SW[0] & SW[1] & SW[2] & SW[3]);
endmodule