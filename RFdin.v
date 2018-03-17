module RFdin(op,sel,dmdout,aluout,pc,imm,data)
input[1:0] sel;
input[5:0] op;
input[31:0] dmdout;
input[31:0] aluout;
input[31:0] pc;
output reg data;
reg alusel0;
reg alusel1;
reg alusel2;
reg[2:0] alusel;
reg[31:0] tmpdata;
reg[31:0] alusrc1;
reg[31:0] alusrc2;
reg[31:0] alusrc4;
reg[31:0] aluelse;
always@(op)
begin
    if(op==6'h24)
        alusel0=1;
    else
        alusel0=0;
    if(op==6'h23)
        alusel1=1;
    else
        alusel1=0;
    if(op==6'h03)
        alusel2=1;
    else
        alusel2=0;
end
always@(*)
begin
    alusel={alusel2,alusel1,alusel0};
end
always@(*)
begin
    alusrc1=(dmdout>>{sel,3'b000})&(32'h000000ff);
    alusrc2=dmdout;
    alusrc4=pc+4;
    aluelse=aluout;
end
module Mux_8#(parameter width = 32)(addr,in0,in1,in2,in3,in4,in5,in6,in7,out,enable);
MUX8 #32 MUX8_tmpdata(alusel,aluelse,alusrc1,alusrc2,aluelse,alusrc4,aluelse,aluelse,aluelse);
always@(tmpdata or op or imm)
begin
    if(op==5'h1f)
        data={16'h0000,imm};
    else
        data=tmpdata;
end
endmodule

