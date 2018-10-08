//eight bit shifter
module shifter(SW, KEY, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
endmodule

//eight bit shifter sub module
module subShifter(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, Q);
	input [7:0] LoadVal 
	input Load_n, ShiftRight, ASR, clk, reset_n;
	output [7:0] Q;
	
	wire [7:0] sh_out;
	
	subShifterBit sh7(.load_val(LoadVal[7]), 
						   .load_n(Load_n), 
							.Clk(clk), 
							.in(), 
							.shift(ShiftRight), 
							.resetn(reset_n), 
							.out(sh_out[7]));
							
	subShifterBit sh6(.load_val(LoadVal[6]), 
						   .load_n(Load_n), 
							.Clk(clk), 
							.in(sh_out[7]), 
							.shift(ShiftRight), 
							.resetn(reset_n), 
							.out(sh_out[6]));
							
	subShifterBit sh5(.load_val(LoadVal[5]), 
						   .load_n(Load_n), 
							.Clk(clk), 
							.in(sh_out[6]), 
							.shift(ShiftRight), 
							.resetn(reset_n), 
							.out(sh_out[5]));
							
	subShifterBit sh4(.load_val(LoadVal[4]), 
						   .load_n(Load_n), 
							.Clk(clk), 
							.in(sh_out[5]), 
							.shift(ShiftRight), 
							.resetn(reset_n), 
							.out(sh_out[4]));
							
	subShifterBit sh3(.load_val(LoadVal[3]), 
						   .load_n(Load_n), 
							.Clk(clk), 
							.in(sh_out[4]), 
							.shift(ShiftRight), 
							.resetn(reset_n), 
							.out(sh_out[3]));
							
	subShifterBit sh2(.load_val(LoadVal[2]), 
						   .load_n(Load_n), 
							.Clk(clk), 
							.in(sh_out[3]), 
							.shift(ShiftRight), 
							.resetn(reset_n), 
							.out(sh_out[2]));
	
	subShifterBit sh1(.load_val(LoadVal[1]), 
						   .load_n(Load_n), 
							.Clk(clk), 
							.in(sh_out[2]), 
							.shift(ShiftRight), 
							.resetn(reset_n), 
							.out(sh_out[1]));
							
	subShifterBit sh0(.load_val(LoadVal[0]), 
						   .load_n(Load_n), 
							.Clk(clk), 
							.in(sh_out[1]), 
							.shift(ShiftRight), 
							.resetn(reset_n), 
							.out(sh_out[0]));
							
	assign Q = sh_out;
endmodule

//single bit shifter
module subShifterBit(load_val, load_n, Clk, in, shift, resetn, out);
	input load_val, load_n, Clk, in, shift, resetn;
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
					 
	flipflop ff(.clock(Clk), 
					.Resetn(resetn), 
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
module flipflop(clock, Resetn, d, q);
	input clock, Resetn, d;
	output q;
	
	always @(posedge clock)
	begin
		if (Resetn == 1'b0)
			q <= 0;
		else 
			q <= d;
	end
endmodule
