//Ripple Carry Adder
module rippleCarryAdder(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	subRippleCarryAdder(.A(SW[7:4]), .B(SW[3:0]), .cin(SW[8]), .s(LEDR[3:0]), .cout(LEDR[4]));
endmodule

module subRippleCarryAdder(A, B, cin, s, cout);
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

module fullAdder(a, b, cin, cout, s);
	input a;
	input b;
	input cin;
	output cout;
	output s;
	
	assign cout = (a & b) | (a & cin) | (b & cin);
	assign s = (a & ~b & ~cin) | (~a & b & ~cin) | (a & b & cin) | (~a & ~b & cin);
endmodule 