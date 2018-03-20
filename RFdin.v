module RFdin(op,sel,dmdout,aluout,pc,imm,data);
input[1:0] sel;
input[5:0] op;
input[31:0] dmdout;
input[31:0] aluout;
input[31:0] pc;
input[15:0] imm;
output reg[31:0] data=0;
reg alusel0=0;
reg alusel1=0;
reg alusel2=0;
reg[2:0] alusel=0;
wire[31:0] tmpdata;
reg[31:0] alusrc1=0;
reg[31:0] alusrc2=0;
reg[31:0] alusrc4=0;
reg[31:0] aluelse=0;
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
MUX8 #32 MUX8_tmpdata(alusel,aluelse,alusrc1,alusrc2,aluelse,alusrc4,aluelse,aluelse,aluelse,tmpdata,0);
always@(*)
begin
    if(op==6'h0f)
        data={16'h0000,imm};
    else
        data=tmpdata;
end
endmodule


