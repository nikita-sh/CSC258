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
	
	rateDivider rate(.enable(enable), .load({1'b0, 27'b101111101011110000011111111}), .clk(clk), .reset_n(reset), .q(rd));
	
	reg shiftEnable;
	
	always @(*)
	begin
		shiftEnable = (rd == 0) ? 1 : 0;
	end
	
	shiftRegister shift(.enable(shiftEnable), .load(morse), .parallel(1'b1), .reset(reset), .clk(clk), .out(out));
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

//16 bit shift register for storing morse value of letter
module shiftRegister(enable, load, parallel, reset, clk, out);
	input enable, parallel, reset, clk;
	input [15:0] load;
	output reg out;
	
	reg [15:0] loaded;
	
	always @(posedge clk)
	begin
		if (reset == 0)
			loaded <= 0;
		else if (parallel == 1'b1 & enable == 1'b0)
			begin
			loaded <= load;
			parallel <= 0;
			end
		else
			begin
			out <= loaded[15];
			loaded <= loaded << 1'b1;
			end
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
			3'b000: out = 16'b1010100000000000;
			// T
			3'b001: out = 16'b1110000000000000;
			// U
			3'b010: out = 16'b1010111000000000;
			// V
			3'b011: out = 16'b1010101110000000;
			// W
			3'b100: out = 16'b1011101110000000;
			// X
			3'b101: out = 16'b1110101011100000;
			// Y
			3'b110: out = 16'b1110101110111000;
			// Z
			3'b111: out = 16'b1110111010100000;
		endcase
	end
endmodule 

