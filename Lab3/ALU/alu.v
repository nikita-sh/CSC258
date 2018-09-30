// Arithmetic Logic Unit
// two data inputs

module alu(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [7:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
endmodule

module subALU(A, B, func, ALUout);
	input [3:0] A;
	input [3:0] B;
	input [2:0] func;
	output [7:0] ALUout;
	
	//A+1
	reg [3:0] a1;
	reg a2;
	rippleCarryAdder(.A(A), .B(4'b0001), .cin(0), .s(a1), .cout(a2));
	
	//A+B
	reg [3:0] ab1;
	reg ab2;
	rippleCarryAdder(.A(A), .B(B), .cin(0), .s(ab1), .cout(ab2));
	
	//A+B using Verilog
	reg [3:0] abv;
	reg abvo;
	fourBitAdd(.A(A), .B(B), .C(abv), .overflow(abvo));
	
	always @(∗)
	begin
		case (function ????????)
			//A + 1
			0: assign ALUout = {3'b000, a2, a1};
			//A + B (Using rippleCarryAdder)
			1: assign ALUout = {3'b000, ab2, ab1};
			//A + B (Using Verilog arithmetic)
			2: assign ALUout = {3'b000, abvo, abv};
			//A XOR B in lower 4 bits, A OR B in higher 4
			3: assign ALUout = {A | B, A ^ B};
			//A and B reduction OR
			4: assign ALUout = {7'b0000000, |(A|B)};
			//A in leftmost 4 bits, B in rightmost 4 bits 
			5: assign {A, B};
			//Display 0
			default: assign ALUout = 8'b00000000
		endcase
	end
endmodule;

module fourBitAdd(A, B, C, overflow);
	input [3:0] A;
	input [3:0] B;
	output [3:0] C;
	output overflow;
	assign {overflow, C} = A+B;
endmodule 

module func();
	function func;
	endfunction
endmodule

//Ripple Carry Adder for use in ALU
module rippleCarryAdder(A, B, cin, s, cout);
	input [3:0] A;
	input [3:0] B;
	input cin;
	output [3:0] s;
	output cout;
	
	wire c1;
	wire c2;
	wire c3;
	
	fullAdder add(
				.a(A[0]),
				.b(B[0]),
				.cin(cin),
				.cout(c1),
				.s(s[0]));
				
	fullAdder add1(
				.a(A[1]),
				.b(B[1]),
				.cin(c1),
				.cout(c2),
				.s(s[1]));
				
	fullAdder add2(
				.a(A[2]),
				.b(B[2]),
				.cin(c2),
				.cout(c3),
				.s(s[2]));
				
	fullAdder add3(
				.a(A[3]),
				.b(B[3]),
				.cin(c3),
				.cout(cout),
				.s(s[3]));
endmodule

//Full Adder for use in RippleCarryAdder
module fullAdder(a, b, cin, cout, s);
	input a;
	input b;
	input cin;
	output cout;
	output s;
	
	assign cout = (a & b) | (a & cin) | (b & cin);
	assign s = (a & ~b & ~cin) | (~a & b & ~cin) | (a & b & cin) | (~a & ~b & cin);
endmodule 

//Seven segment display decoder for use in ALU output
module sevenSegDecoder(SW, HEX0);
	input [9:0] SW;
	output [6:0] HEX0;

	assign HEX0[0] = (~SW[0] & SW[1] & ~SW[2] & ~SW[3]) | 
					     (SW[0] & ~SW[1] & SW[2] & SW[3]) | 
						  (SW[0] & SW[1] & ~SW[2] & SW[3]) | 
						  (~SW[0] & ~SW[1] & ~SW[2] & SW[3]);
						  
	assign HEX0[1] = (SW[0] & SW[2] & SW[3]) | 
						  (SW[0] & SW[1] & ~SW[3]) | 
						  (SW[1] & SW[2] & ~SW[3]) | 
						  (~SW[0] & SW[1] & ~SW[2] & SW[3]);
	
	assign HEX0[2] = (~SW[0] & ~SW[1] & SW[2] & ~SW[3]) | 
						  (SW[0] & SW[1] & ~SW[3]) | 
						  (SW[0] & SW[1] & SW[2]);
	
	assign HEX0[3] = (~SW[1] & ~SW[2] & SW[3]) | 
						  (SW[0] & ~SW[1] & SW[2] & ~SW[3]) | 
						  (SW[1] & SW[2] & SW[3]) | 
						  (~SW[0] & SW[1] & ~SW[2] & ~SW[3]);
						  
	assign HEX0[4] = (~SW[0] & ~SW[1] & SW[3]) | 
						  (~SW[1] & ~SW[2] & SW[3]) | 
						  (~SW[0] & SW[1] & ~SW[2]) | 
						  (~SW[0] & SW[1] & SW[3]);
						  
	assign HEX0[5] = (~SW[0] & ~SW[1] & SW[2]) | 
						  (~SW[0] & ~SW[1] & SW[3]) | 
						  (~SW[0] & SW[2] & SW[3]) | 
						  (SW[0] & SW[1] & ~SW[2] & SW[3]);
						  
	assign HEX0[6] = (~SW[0] & ~SW[1] & ~SW[2]) | 
						  (SW[0] & SW[1] & ~SW[2] & ~SW[3]) | 
						  (~SW[0] & SW[1] & SW[2] & SW[3]);
endmodule 