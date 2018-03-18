`timescale 1ns / 1ns
module ext(data,op,funct,extdata);
input data;
input op;
input funct;
output reg[31:0] extdata;
reg[31:0] data1=0;
reg[31:0] data2=0;
reg[31:0] data4=0;
reg bit0=0;
reg bit1=0;
reg bit2=0;
reg[31:0] middleres=0;
always@(*)
begin
    data1={{16{data[15]}}, data};
    data2={{16{0}}, data};
    data4={27{1'b0},data[10:6]};
end 
always@(*)
begin
    bit0=((op==6'h8)||(op==6'h9)||(op==6'h23)||(op==6'h2b)||(op==6'h0a)||(op==6'bh24));
    bit1=((op==6'b001100)||(op==6'b001101)||(op==6'b001110));
    bit2=(((op==6'b000000)||(funct==6'b000010)||(funct==6'b000011))&&(funct==6'b000000));
end
always@(*)
begin
    if({bit2,bit1,bit0}==3'b001)
        middleres=data1;
    else if(({bit2,bit1,bit0}==3'b010))
        middleres=data2;
    else if ({bit2,bit1,bit0}==3'b100)
        middleres=data4;
    else
        middleres=0;
end
always@(*)
begin
    if(op==6'b000001)
        extdata=0;
    else
        extdata=middleres;
end
