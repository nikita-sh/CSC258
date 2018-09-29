//SW[4:0] data inputs
//SW[9] select signal 1
//SW[8] select signal 0

//LEDR[0] output display

module mux(LEDR, SW);
	input [9:0] SW;
	output [9:0] LEDR;
	
	mux4to1 u(
		.u(SW[0]),
		.v(SW[2]),
		.w(SW[1]),
		.x(SW[3]),
		.a(SW[9]),
		.b(SW[8]),
		.m(LEDR[0])
		);
endmodule

module mux4to1(u, v, w, x, a, b, m);
    input u; // selected when a and b are 0
	 input v; // selected when a is 0 and b is 1
	 input w; // selected when a is 1 and b is 0
	 input x; // selected when a and b are 1
	 input a; // select signal 1
	 input b; // select signal 2
	 output m; //output
	 
	 wire c1;
	 wire c2;

    mux2to1 u0(
        .x(u),
        .y(w),
        .s(a),
        .m(c1)
        );
		  
	mux2to1 u1(
		  .x(v),
		  .y(x),
		  .s(a),
		  .m(c2)
		  );
		  
	mux2to1 u2(
		  .x(c1),
		  .y(c2),
		  .s(b),
		  .m(m)
		  );
endmodule

module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule