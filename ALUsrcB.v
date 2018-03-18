module ALUsrcB(op,funct,ALUsrcB);
input[5:0] op;
input[5:0] funct;
output reg ALUsrcB=0;
always@(*)
begin
    if(((op==0)&&((funct==6'h00)||(funct==6'h02)||(funct==6'h03)))
    ||((op==6'h09)||(op==6'h08)||(op==6'h0c)||(op==6'h0d)||(op==6'h23)||(op==6'h2b)||(op==6'h0a)||(op==6'h0e)||(op==6'h24)))
        ALUsrcB=1;
    else
        ALUsrcB=0;
end
endmodule