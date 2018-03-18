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
output[31:0] newpc;
output reg pcclear;
output[15:0] uncondsum;
output[15:0] condsuccsum;
output[15:0] condsum;
reg muxsel0=0;
reg muxsel1=0;
reg muxsel2=0;
reg[31:0] muxsrc03567=0;
reg[31:0] muxsrc1=0;
reg[31:0] muxsrc2=0;
reg[31:0] muxsrc4=0;
reg[2:0] muxsel=0;

reg uncondcnt=0;
reg condsuscnt=0;
reg condcnt=0;
reg[17:0] tmp=0;
reg[17:0] tmp1=0;
always@(op or funct)
begin
    if((op==6'h0)&&(funct==6'h08))
        muxsel0<=1;
    else
        muxsel0<=0;
end
always@(op)
begin
    if((op==6'h2)||(op==6'h3))
        muxsel1<=1;
    else
        muxsel1<=0;
end
always@(*)
begin
    if(((aluout==0)&&(op==6'h04))||((aluout!=0)&&(op==6'h05))||((aluout==32'b1)&&(op==6'h01)))
        muxsel2<=1;
    else
        muxsel2<=0;
end
always@(*)
begin
    muxsel<={muxsel2,muxsel1,muxsel0};
end
always@(*)
begin
    muxsrc03567=pc+32'h4;
    muxsrc2={pc[31:28],label[25:0],2'b0}-32'h00003000;
end
always@(rfd1)
begin
    muxsrc1<=rfd1;
end

always@(pc or label)
begin
    tmp=(label[17:0]&(18'h0ffff));
    tmp1={tmp[15:0],2'b00};
    muxsrc4<={{14{tmp1[17]}},tmp1}+pc+32'h4;
end
MUX8  #32 MUX8_ins (muxsel,muxsrc03567,muxsrc1,muxsrc2,muxsrc03567,muxsrc4,muxsrc03567,muxsrc03567,muxsrc03567,newpc,0);
always@(*)
begin
    pcclear<=(newpc!=pc+4);
end
always@(op or funct or muxsel1 or pcen)
begin
    if((((op==0)&&(funct==6'h08))||muxsel1)&&(pcen))
        uncondcnt=1;
    else
        uncondcnt=0;
end
always@(pcen or muxsel2)
begin
    if((pcen==1'b1)&&(muxsel2==1'b1))
        condsuscnt=1;
    else
        condsuscnt=0;
end
always@(aluout or pcen)
begin
    if(((aluout==6'h04)||(aluout==6'h05))&&(pcen==1'b1))
        condcnt=1;
    else
        condcnt=0;
end
counter counter_ins_uncondsum(clk,1'b0,uncondcnt,uncondsum);
counter counter_ins_condsussum(clk,1'b0,condsuscnt,condsuccsum);
counter counter_ins_condsum(clk,1'b0,condcnt,condsum);
endmodule


