`timescale 1ns / 1ns
module counter #(parameter SIZE=16)(clk,clear,count,outval);
input clk;
input clear;
input count;
output reg[SIZE-1:0] outval=0;
always@(posedge clk or posedge clear)
begin
    if(clear)
        outval<=0;
    else if((count==0)||(count===1'bx)||(count===1'bz))
        ;
    else
        outval=outval+1;
end
endmodule
