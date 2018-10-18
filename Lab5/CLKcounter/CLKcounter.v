module CLKcounter(SW, CLOCK_50, HEX0);
	input [8:0] SW; //8:enable, 7-4: load, 3:parallel load, 2: reset, 1-0:frequency
	input CLOCK_50;
	output HEX0;
	
	wire [3:0] hw;
	
	genCLKcounter cc(.enable(SW[8]), .load(SW[7:4]), .par_load(SW[3]), .clk(CLOCK_50), .reset_n(SW[2]), .freq(SW[1:0]), .out(hw));
	
	sevenSegDecoder dec(.SW(hw), .HEX0(HEX0));
endmodule 

module genCLKcounter(enable, load, par_load, clk, reset_n, freq, out);
	input enable, clk, reset_n, par_load;
	input [3:0] load;
	input [1:0] freq;
	output [3:0] out;
	
	wire [25:0] w1, w05, w025;
	reg c;
	
	rateDivider r1(.enable(enable), .load({2'b00, 26'b10111110101111000001111111}), .clk(clk), .reset_n(reset_n), .q(w1));
	rateDivider r05(.enable(enable), .load({1'b0, 27'b101111101011110000011111111}), .clk(clk), .reset_n(reset_n), .q(w05));
	rateDivider r025(.enable(enable), .load({28'b1011111010111100000111111111}), .clk(clk), .reset_n(reset_n), .q(w025));
	
	always @(*)
		begin
			case(freq)
				2'b00: c = enable;
				2'b01: c = (w1 == 0) ? 1 : 0;
				2'b10: c = (w05 == 0) ? 1 : 0;
				2'b11: c = (w025 == 0) ? 1 : 0;
			endcase
		end
		
	fourBitCounter count(.d(load), .clck(clk), .reset_n(reset_n), .par_load(par_load), .enable(c), .Q(out));
endmodule 

// rate divider
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

// Four bit counter using parallel load and active low synchronous clear
module fourBitCounter(d, clck, reset_n, par_load, enable, Q);
	input [3:0] d;
	input clck, reset_n, par_load, enable;
	output reg [3:0] Q;
	
	always @(posedge clck, negedge reset_n)
	begin
		if (reset_n == 1'b0)
			Q <= 0;
		else if (par_load == 1'b1)
			Q <= d;
		else if (enable == 1'b1)
			begin
				if (Q == 4'b1111)
					Q <= 0;
				else
					Q <= Q + 1'b1;
			end
	end
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