//Ripple Carry Adder

module rippleCarryAdder(a, b, a1, b1, a2, b2, a3, b3, cin, s, s1, s2, s3, cout);
	input a;
	input b;
	input a1;
	input b1;
	input a2;
	input b2;
	input a3;
	input b3;
	input cin;
	output s;
	output s1;
	output s2;
	output s3;
	output cout;
	
	wire c1;
	wire c2;
	wire c3;
	
	fullAdder add(
				.a(a),
				.b(b),
				.cin(cin),
				.cout(c1),
				.s(s));
				
	fullAdder add1(
				.a(a1),
				.b(b1),
				.cin(c1),
				.cout(c2),
				.s(s1));
				
	fullAdder add2(
				.a(a2),
				.b(b2),
				.cin(c2),
				.cout(c3),
				.s(s2));
				
	fullAdder add3(
				.a(a3),
				.b(b3),
				.cin(c3),
				.cout(cout),
				.s(s3));
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