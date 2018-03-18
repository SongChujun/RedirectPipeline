module RF(
	rA, rB, rW, WE, w, clk,
	A, B
    );
	
	input [4:0] rA;
	input [4:0] rB;
	input [4:0] rW;
	input WE;
	input [31:0] w;
	input clk;

	output [31:0] A;
	output [31:0] B;

	reg [31:0] data [31:0];	// register array 32x32

	assign A = data[rA];
	assign B = data[rB];

	integer i;

	initial begin
		for (i = 0; i < 32; i=i+1) data[i] = 'h00000000;
	end

	always @(negedge clk) begin
		if (WE) begin
			data[rW] = w;
		end
	end


endmodule