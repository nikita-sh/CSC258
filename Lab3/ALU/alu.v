//Arithmetic Logic Unit
// two data inputs

module alu(a, a1, a2, a3, b, b1, b2, b3, out1, out2, out3, out4, out5, out6, out7, out8);
	input a;
	input a1;
	input a2;
	input a3;
	input b;
	input b1;
	input b2;
	input b3;
	output out1;
	output out2;
	output out3;
	output out4;
	output out5;
	output out6;
	output out7;
	output out8;
	
	//Add 1
	reg a1;
	reg a2;
	reg a3;
	reg a4;
	reg a5;
	
	rippleCarryAdder mod0(.a(a), .b(0), .a1(a1), .b1(0), .a2(a2), .b2(0), .a3(a3), .b3(1), .cin(0), .s(a1), .s1(a2), .s2(a3), .s3(a4), .cout(a5));
	
	//A+B
	reg ab1;
	reg ab2;
	reg ab3;
	reg ab4;
	reg ab5;
	
	rippleCarryAdder mod1(.a(a), .b(b), .a1(a1), .b1(b1), .a2(a2), .b2(b2), .a3(a3), .b3(b3), .cin(0), .s(ab1), .s1(ab2), .s2(ab3), .s3(ab4), .cout(ab5));
	
	always @(∗)
	begin
		case (function)
			0: begin:
				assign out1 = a1;
				assign out2 = a2;
				assign out3 = a3;
				assign out4 = a4;
				assign out5 = a5;
				assign out6 = 0;
				assign out7 = 0;
				assign out8 = 0;
			end
			1: begin:
				assign out1 = ab1;
				assign out2 = ab2;
				assign out3 = ab3;
				assign out4 = ab4;
				assign out5 = ab5;
				assign out6 = 0;
				assign out7 = 0;
				assign out8 = 0;
			end
			2: begin:
				assign out1 = 0;
				assign out2 = 0;
				assign out3 = 0;
				assign out4 = 0;
				assign out5 = 0;
				assign out6 = 0;
				assign out7 = 0;
				assign out8 = 0;
			end
			3: begin:
				assign out1 = 0;
				assign out2 = 0;
				assign out3 = 0;
				assign out4 = 0;
				assign out5 = 0;
				assign out6 = 0;
				assign out7 = 0;
				assign out8 = 0;
			end
			4: begin:
				assign out1 = 0;
				assign out2 = 0;
				assign out3 = 0;
				assign out4 = 0;
				assign out5 = 0;
				assign out6 = 0;
				assign out7 = 0;
				assign out8 = 0;
			end
			5: begin:
				assign out1 = 0;
				assign out2 = 0;
				assign out3 = 0;
				assign out4 = 0;
				assign out5 = 0;
				assign out6 = 0;
				assign out7 = 0;
				assign out8 = 0;
			end
			default: begin:
				assign out1 = 0;
				assign out2 = 0;
				assign out3 = 0;
				assign out4 = 0;
				assign out5 = 0;
				assign out6 = 0;
				assign out7 = 0;
				assign out8 = 0;
			end
		endcase
	end
endmodule

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