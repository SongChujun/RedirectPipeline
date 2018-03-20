module register#(parameter width=32)(ena,clk,data,clr,out);
input ena;
input clk;
input[width-1:0] data;
input clr;
output reg[width-1:0] out=0;
always@(posedge clk or posedge clr)
begin
    if(clr==1'b1)
        out<=0;
    else if(ena==1'b1)
        out<=data;
end
endmodule