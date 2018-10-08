//eight bit shifter
module shifter(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, Q);
	input LoadVal, Load_n, ShiftRight, ASR, clk, reset_n;
	output [7:0] Q;
	
	wire w7, w6, w5, w4, w3, w2, w1;
	
	subShifterBit sh7(.load_val(LoadVal), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(), 
							.shift(), 
							.reset_n(), 
							.out(w7));
							
	subShifterBit sh6(.load_val(), 
						   .load_n(), 
							.clk(), 
							.in(w7), 
							.shift(), 
							.reset_n(), 
							.out(w6));
							
	subShifterBit sh5(.load_val(), 
						   .load_n(), 
							.clk(), 
							.in(w6), 
							.shift(), 
							.reset_n(), 
							.out(w5));
							
	subShifterBit sh4(.load_val(), 
						   .load_n(), 
							.clk(), 
							.in(w5), 
							.shift(), 
							.reset_n(), 
							.out(w4));
							
	subShifterBit sh3(.load_val(), 
						   .load_n(), 
							.clk(), 
							.in(w4), 
							.shift(), 
							.reset_n(), 
							.out(w3));
							
	subShifterBit sh2(.load_val(), 
						   .load_n(), 
							.clk(), 
							.in(w3), 
							.shift(), 
							.reset_n(), 
							.out(w2));
	
	subShifterBit sh1(.load_val(), 
						   .load_n(), 
							.clk(), 
							.in(w2), 
							.shift(), 
							.reset_n(), 
							.out(w1));
							
	subShifterBit sh0(.load_val(), 
						   .load_n(), 
							.clk(), 
							.in(w1), 
							.shift(), 
							.reset_n(), 
							.out());
endmodule

//single bit shifter
module subShifterBit(load_val, load_n, clk, in, shift, reset_n, out);
	input load_val, load_n, clk, in, shift, reset_n;
	output out;
	
	wire mux1tomux2;
	wire mux2toff;
	wire ffout;
	
	mux2to1 mux1(.x(in), 
					 .y(ffout), 
					 .s(shift), 
					 .m(mux1tomux2));
					 
	mux2to1 mux1(.x(mux1tomux2), 
					 .y(load_val), 
					 .s(load_n), 
					 .m(mux2toff));
					 
	flipflop ff(.clock(clk), 
					.reset_n(reset_n), 
					.d(mux2toff), 
					.q(ffout));
	
	assign out = ffout;
endmodule

//2 to 1 multiplexer
module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
endmodule

//D flip flop
module flipflop(clock, reset_n, d, q);
	input clock, reset_n, d;
	output q;
	
	always @(posedge clock)
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else 
			q <= d;
	end
endmodule
