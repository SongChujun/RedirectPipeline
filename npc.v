`timescale 1ns / 1ns
module npc(op,pc,aluout,label,rfd1,funct,clk,pcen,newpc,pcclear,uncondsum,condsuccsum,condsum);
input[5:0] op;
input[31:0] pc;
input[31:0] aluout;
input[25:0] label;
input[31:0] rfd1;
input[5:0] funct;
input clk;
input pcen;
output reg[31:0] newpc;
output reg pcclear;
output reg[15:0] uncondsum;
output reg[15:0] condsuccsum;
output reg[15:0] condsum;
reg muxsel0;
reg muxsel1;
reg muxsel2;
reg muxsrc03567;
reg muxsrc1;
reg muxsrc2;
reg muxsrc4;
reg[2:0] muxsel;
always@(op or funct)
begin
    if((op==6'h0)&&(funct==6'h08))
        muxsel0<=1;
    else
        muxsel0<=0;
end
endmodule
always@(op)
begin
    if((op==6'h2)||(op==6'h3))
        muxsel1<=1;
    else
        muxsel1<=0;
end
always(aluout or pc)
begin
    if(((aluout==0)&&(op==6'h04))||((aluout!=0)&&(op==6'h05))||((aluout==32'b1)&&(op==6'h01)))
        muxsel2<=0;
    else
        muxsel2<=1;
end
always@(*)
begin
    muxsel<={muxsel2,muxsel1 muxsel0}
end
always@(pc)
begin
    muxsrc03567<=pc+32'h4;
    muxsrc2<={pc[27:2],2'b0}-32'h00003000;
end
always@(rfd1)
begin
    muxsrc1<=rfd1;
end
always@(pc or label)
begin
    muxsrc4<={14'b{(label[17:0]&(18'h0ffff))[16:0],2'b00}[17],{(label[17:0]&(18'h0ffff))[16:0],2'b00}}+pc+32'h4;
end
MUX8 MUX8_ins(muxsel,muxsrc03567,muxsrc1,muxsrc2,muxsrc03567,muxsrc4,muxsrc03567,muxsrc03567,muxsrc03567,newpc,0);
always@(*)
begin
    pcclear<=(newpc!=pc+4);
end




