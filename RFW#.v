module(op,funct,alusrcb)
input[5:0] op;
input[5:0] funct;
output reg alusrcb;
always@(*)
begin
    if(((op==0)&&((funct==6'h08)||(funct==6'h0c)))
    ||((op==6'h01)||(op==6'h02)||(op==6'h04)||(op==6'h05)||(op==6'h2b)))
        alusrcb=0;
    else
        alusrcb=1;
end