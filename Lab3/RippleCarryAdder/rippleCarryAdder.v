//Ripple Carry Adder
module rippleCarryAdder(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	//SW[7:4] = A
	//SW[3:0] = B
	//SW[8] Carry in bit
	
	wire c1;
	wire c2;
	wire c3;
	
	fullAdder add(
				.a(SW[4]),
				.b(SW[0]),
				.cin(SW[8]),
				.cout(c1),
				.s(LEDR[0]));
				
	fullAdder add1(
				.a(SW[5]),
				.b(SW[1]),
				.cin(c1),
				.cout(c2),
				.s(LEDR[1]));
				
	fullAdder add2(
				.a(SW[6]),
				.b(SW[2]),
				.cin(c2),
				.cout(c3),
				.s(LEDR[2]));
				
	fullAdder add3(
				.a(SW[7]),
				.b(SW[3]),
				.cin(c3),
				.cout(LEDR[4]),
				.s(LEDR[3]));
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