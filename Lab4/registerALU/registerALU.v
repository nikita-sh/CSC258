// Arithmetic Logic Unit with register

module registerALU(SW, KEY, LEDR, HEX0, HEX4, HEX5);
	input [9:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0, HEX4, HEX5;

	wire [7:0] out;

	subRegisterALU alu(.clk(KEY[0]),
						    .reset_n(SW[9]),
							 .func(SW[7:5]),
							 .data(SW[3:0]),
							 .ALUout(out));

	assign LEDR[7:0] = out;

	sevenSegDecoder h0(.SW(SW[3:0]), .HEX0(HEX0));
	sevenSegDecoder h1(.SW(out[3:0]), .HEX0(HEX4));
	sevenSegDecoder h2(.SW(out[7:4]), .HEX0(HEX5));
endmodule

module subRegisterALU(clk, reset_n, func, data, ALUout);
	input clk;
	input reset_n;
	input [2:0] func;
	input [3:0] data;
	output reg [7:0] ALUout;

	//register
	wire [3:0] r;
	register reg0(.in(ALUout),
					  .clock(clk),
					  .reset(reset_n),
					  .out(r));

	//A+1
	wire [3:0] addA1;
	wire addA2;
	rippleCarryAdder add1(.A(data), .B(4'b0001), .cin(1'b0), .s(addA1), .cout(addA2));

	//A+B
	wire [3:0] ab1;
	wire ab2;
	rippleCarryAdder add2(.A(data), .B(r[3:0]), .cin(1'b0), .s(ab1), .cout(ab2));


	//A+B using Verilog
	wire [3:0] abv;
  wire abvo;
	fourBitAdd add3(.X(data), .Y(r[3:0]), .C(abv), .overflow(abvo));

	always @(*)
	begin
		case (func)
			//A + 1
			3'b000: ALUout = {3'b000, addA2, addA1};
			//A + B (Using rippleCarryAdder)
			3'b001: ALUout = {3'b000, ab2, ab1};
			//A + B (Using Verilog arithmetic)
			3'b010: ALUout = {3'b000, abvo, abv};
			//A XOR B in lower 4 bits, A OR B in higher 4
			3'b011: ALUout = {data | r[3:0], data ^ r[3:0]};
			//A and B reduction OR
			3'b100: ALUout = {7'b0000000, |(data|r[3:0])};
			//Left shift B by A bits
			3'b101: ALUout = (r[3:0] << data);
			//Right shift B by A bits
			3'b110: ALUout = (r[3:0] >> data);
			//A X B using Verilog *
			3'b111: ALUout = data * r[3:0];
			//Display 0
			default: ALUout = 8'b00000000;
		endcase
	end
endmodule

//Adder using verilog +
module fourBitAdd(X, Y, C, overflow);
	input [3:0] X;
	input [3:0] Y;
	output [3:0] C;
	output overflow;
	assign {overflow, C} = X+Y;
endmodule

module register(in, clock, reset, out);
	input [7:0] in;
	input clock;
	input reset;
	output reg [7:0] out;

	always @(posedge clock)
	begin
		if (reset == 1'b0)
			out <= 8'b00000000;
		else
			out <= in;
	end
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
