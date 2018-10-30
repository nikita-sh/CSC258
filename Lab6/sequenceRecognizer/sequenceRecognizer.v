// SW[0]:		reset signal
// SW[1]			input signal
// KEY[0]		clock

// LEDR[2:0]	current state
// LEDR[9]		output

module sequenceRecognizer(SW, KEY, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	
	wire w, clock, reset, z;
	
	reg [2:0] y_Q, Y_D; // y_Q is the current state, Y_D is the next state
	
	localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110;
	
	// connecting inputs and outputs to internal wires
	assign w = SW[1];
	assign clock = KEY[0];
	assign reset = SW[0];
	assign LEDR[9] = z;
	assign LEDR[2:0] = y_Q;
	
	// state table
	always @(*)
	begin //begin state table
		case (y_Q)
			A: begin
					if (!w) Y_D = A;
					else Y_D = B;
				end
			B: begin
					if (!w) Y_D = A;
					else Y_D = C;
				end
			C: begin
					if (!w) Y_D = E;
					else Y_D = D;
				end
			D: begin
					if (!w) Y_D = E;
					else Y_D = F;
				end
			E: begin
					if (!w) Y_D = A;
					else Y_D = G;
				end
			F: begin
					if (!w) Y_D = E;
					else Y_D = F;
				end
			G: begin
					if (!w) Y_D = A;
					else Y_D = C;
				end
			default: Y_D = A;
		endcase
	end
	
	// state register, i.e., flip flops
	always @(posedge clock)
	begin		// start of state flip flops
		if (reset == 1'b0)
			y_Q = A;
		else
			y_Q = Y_D;
	end		// end of state flip flops
	
	// output logic
	// set z to 1 to turn on LED when in relevant states
	assign z = ((y_Q == F) || (y_Q == G));
endmodule 