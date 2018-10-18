module morseEncoder(SW, KEY, CLOCK_50, LEDR);
	input [2:0] SW;
	input [1:0] KEY;
	input CLOCK_50;
	output [0:0] LEDR;
	
	genMorseEncoder gme(.enable(KEY[1]), .letter(SW[2:0]), .reset(KEY[0]), .clk(CLOCK_50), .out(LEDR[0]));
endmodule 

module genMorseEncoder(enable, letter, reset, clk, out);
	input enable, reset, clk;
	input [2:0] letter;
	output out;
	
	wire [15:0] morse;
	
	lookUpTable lut(.in(letter), .out(morse));
	
	wire [27:0] rd;
	
	rateDivider rate(.enable(enable), .load({3'b000, 25'b1011111010111100000111111}), .clk(clk), .reset_n(reset), .q(rd));
	
	wire shiftEnable;
	assign shiftEnable = (rd == 0) ? 1 : 0;
	
	subShifter(.LoadVal(morse), .in(1'b0), .Load_n(enable), .clk(shiftEnable), .shift(1'b1), .reset_n(reset), .Q(out));
endmodule

//Rate Divider for morse timing
module rateDivider(enable, load, clk, reset_n, q);
	input enable, clk, reset_n;
	input [27:0] load;
	output reg [27:0] q;
	
	always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			q <= load;
		else if (enable == 1'b1)
			begin
				if (q == 0)
					q <= load;
				else
					q <= q - 1'b1;
			end
	end
endmodule

//16 bit shifter sub module
module subShifter(LoadVal, in, Load_n, clk, shift, reset_n, Q);
	input [15:0] LoadVal;
	input Load_n, clk, reset_n, shift, in;
	output Q;
	
	wire [15:0] sh_out;
	
	subShifterBit sh15(.load_val(LoadVal[15]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(in), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[15]));
							
	subShifterBit sh14(.load_val(LoadVal[14]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[15]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[14]));
							
	subShifterBit sh13(.load_val(LoadVal[13]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[14]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[13]));
	
	subShifterBit sh12(.load_val(LoadVal[12]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[13]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[12]));
							
	subShifterBit sh11(.load_val(LoadVal[11]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[12]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[11]));
							
	subShifterBit sh10(.load_val(LoadVal[10]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[11]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[10]));
						
	subShifterBit sh9(.load_val(LoadVal[9]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[10]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[9]));
							
	subShifterBit sh8(.load_val(LoadVal[8]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[9]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[8]));
							
	subShifterBit sh7(.load_val(LoadVal[7]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[8]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[7]));
							
	subShifterBit sh6(.load_val(LoadVal[6]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[7]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[6]));
							
	subShifterBit sh5(.load_val(LoadVal[5]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[6]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[5]));
							
	subShifterBit sh4(.load_val(LoadVal[4]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[5]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[4]));
							
	subShifterBit sh3(.load_val(LoadVal[3]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[4]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[3]));
							
	subShifterBit sh2(.load_val(LoadVal[2]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[3]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[2]));
							
	subShifterBit sh1(.load_val(LoadVal[1]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[2]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[1]));
							
	subShifterBit sh0(.load_val(LoadVal[0]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[1]), 
							.shift(shift), 
							.resetn(reset_n), 
							.out(sh_out[0]));
							
	assign Q = sh_out[0];
endmodule

//single bit shifter
module subShifterBit(load_val, load_n, clk, in, shift, resetn, out);
	input load_val, load_n, clk, in, shift, resetn;
	output out;
	
	wire mux1tomux2;
	wire mux2toff;
	wire ffout;
	
	mux2to1 mux1(.x(ffout), 
					 .y(in), 
					 .s(shift), 
					 .m(mux1tomux2));
					 
	mux2to1 mux2(.x(load_val), 
					 .y(mux1tomux2), 
					 .s(load_n), 
					 .m(mux2toff));
					 
	flipflop ff(.clock(clk), 
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
	output reg q;
	
	always @(posedge clock)
	begin
		if (Resetn == 1'b0)
			q <= 0;
		else 
			q <= d;
	end
endmodule

//Lookup Table
module lookUpTable(in, out);
	input [2:0] in;
	output reg [15:0] out;
	
	always @(*)
	begin
		case(in)
			// S
			3'b000: out = 16'b0000000000010101;
			// T
			3'b001: out = 16'b0000000000000111;
			// U
			3'b010: out = 16'b0000000001010111;
			// V
			3'b011: out = 16'b0000000101010111;
			// W
			3'b100: out = 16'b0000000101110111;
			// X
			3'b101: out = 16'b0000011101010111;
			// Y
			3'b110: out = 16'b0001110101110111;
			// Z
			3'b111: out = 16'b0000011101110101;
		endcase
	end
endmodule 

