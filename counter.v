`timescale 1ns / 1ns
module counter #(parameter SIZE=16)(clk,clear,count,outval);
input clk;
input clear;
input count;
output reg[SIZE-1:0] outval=0;
always@(posedge clk or clear)
begin
    if(clear)
        outval<=0;
    else
        outval=outval+1;
end

