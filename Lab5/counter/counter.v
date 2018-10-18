// 8-bit synchronous counter - TOP LEVEL
module counter(SW, KEY, HEX0, HEX1);
	input [1:0] SW;
	input [0:0] KEY;
	output HEX0, HEX1;
	
	wire [7:0] h;
	
	//counter
	genCounter c(.enable(SW[1]), .clk(KEY[0]), .clear_b(SW[0]), .Q(h));
	
	//decoders
	sevenSegDecoder s0(.SW(h[7:4]), .HEX0(HEX1));
	sevenSegDecoder s1(.SW(h[3:0]), .HEX0(HEX0));
endmodule 

// 8-bit synchronous counter- GENERIC
module genCounter(enable, clk, clear_b, Q);
	input enable, clk, clear_b;
	output [7:0] Q;
	
	wire [6:0] w;
	tFlipFlop t7(.t(enable), .clock(clk), .clear(clear_b), .q(Q[7]));
	assign w[6] = enable & Q[7];
	
	tFlipFlop t6(.t(w[6]), .clock(clk), .clear(clear_b), .q(Q[6]));
	assign w[5] = w[6] & Q[6];
	
	tFlipFlop t5(.t(w[5]), .clock(clk), .clear(clear_b), .q(Q[5]));
	assign w[4] = w[5] & Q[5];
	
	tFlipFlop t4(.t(w[4]), .clock(clk), .clear(clear_b), .q(Q[4]));
	assign w[3] = w[4] & Q[4];
	
	tFlipFlop t3(.t(w[3]), .clock(clk), .clear(clear_b), .q(Q[3]));
	assign w[2] = w[3] & Q[3];
	
	tFlipFlop t2(.t(w[2]), .clock(clk), .clear(clear_b), .q(Q[2]));
	assign w[1] = w[2] & Q[2];
	
	tFlipFlop t1(.t(w[1]), .clock(clk), .clear(clear_b), .q(Q[1]));
	assign w[0] = w[1] & Q[1];
	
	tFlipFlop t0(.t(w[0]), .clock(clk), .clear(clear_b), .q(Q[0]));
endmodule 

// T flip flop
module tFlipFlop(t, clock, clear, q);
	input t, clock, clear;
	output reg q;
	
	always @(posedge clock, negedge clear)
		begin
			if (clear == 1'b0)
				q <= 1'b0;
			else
				q <= t;
		end
endmodule

//Seven Segment Decoder
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
