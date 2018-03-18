module DM(
	ra, rb, D,load,str,sel, clr, clk,
	A_out , B_out);

	input [5:0] ra, rb;	// ra is read-write but rb is read-only (for display)
	input [31:0] D;			// D will be wrote at address 'ra'
	input WE, clr, clk,load,str,sel;
	output reg [31:0] A_out
    wire[31:0] B_out;

	reg [31:0] data [0:63];	// 64x31 data

	integer i;


	initial begin
		for (i=0; i<64; i=i+1) data[i] <= 'h00000000;
		A_out <= 0;
		B_out <= 0;
	end

	always @(posedge clk or posedge clr) begin
		if (clr) begin
			for (i=0; i<64; i=i+1) data[i] <= 'h00000000;
		end
		else if ((str)&&(sel)) 
        begin
				data[ra] <= D;
		end
	end


	always @(*) 
    begin
        if((load)&&(sel))
        begin
            A_out <= data[ra];
        end
    end
    assign B_out=data[rb];

endmodule