// Arithmetic Logic Unit
// two data inputs

module alu(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [7:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [7:0] hex1;
	
	subALU alu0(.A(SW[7:4]), .B(SW[3:0]), .func(KEY[2:0]), .ALUout(hex1));
	
	assign LEDR[7:0] = hex1[7:0];
	
	sevenSegDecoder h1(.SW(10'b0000000000), .HEX0(HEX1));
	sevenSegDecoder h3(.SW(10'b0000000000), .HEX0(HEX3));
	sevenSegDecoder ha(.SW({6'b000000, SW[7:4]}), .HEX0(HEX2));
	sevenSegDecoder hb(.SW({6'b000000, SW[3:0]}), .HEX0(HEX0));
	sevenSegDecoder h4alu(.SW({hex1[3:0]}), .HEX0(HEX4));
	sevenSegDecoder h5alu(.SW({hex1[7:4]}), .HEX0(HEX5));
endmodule

module subALU(A, B, func, ALUout);
	input [3:0] A;
	input [3:0] B;
	input [2:0] func;
	output reg [7:0] ALUout;
	
	//A+1
	wire [3:0] addA1;
	wire addA2;
	rippleCarryAdder add1(.A(A), .B(4'b0001), .cin(0), .s(addA1), .cout(addA2));
	
	//A+B
	wire [3:0] ab1;
	wire ab2;
	rippleCarryAdder add2(.A(A), .B(B), .cin(0), .s(ab1), .cout(ab2));
	
	
	//A+B using Verilog
	wire [3:0] abv;
	wire abvo;
	fourBitAdd add3(.X(A), .Y(B), .C(abv), .overflow(abvo));
	
	always @(*)
	begin
		case (func)
			//A + 1
			3'b000: ALUout[7:0] = {3'b000, addA2, addA1};
			//A + B (Using rippleCarryAdder)
			3'b001: ALUout = {3'b000, ab2, ab1};
			//A + B (Using Verilog arithmetic)
			3'b010: ALUout = {3'b000, abvo, abv};
			//A XOR B in lower 4 bits, A OR B in higher 4
			3'b011: ALUout = {A | B, A ^ B};
			//A and B reduction OR
			3'b100: ALUout = {7'b0000000, |(A|B)};
			//A in leftmost 4 bits, B in rightmost 4 bits 
			3'b101: ALUout = {A, B};
			//Display 0
			default: ALUout = 8'b00000000;
		endcase
	end
endmodule

module fourBitAdd(X, Y, C, overflow);
	input [3:0] X;
	input [3:0] Y;
	output [3:0] C;
	output overflow;
	assign {overflow, C} = X+Y;
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