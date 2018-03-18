`timescale 1ns / 1ns
module alusrcsel(idsrc1mem,idsrc1ex,memaeq,aluaeq,membeq,alubeq,rfd2dmbeq,rfd2alueq,sela,selb,rfd1sel,rdf2sel);
input idsrc1mem;
input idsrc1ex;
input memaeq;
input membeq;
input aluaeq;
input alubeq;
input rfd2dmbeq;
input rfd2alueq;
output reg[1:0] sela;
output reg[1:0] selb;
output reg[1:0] rfd1sel;
output reg[1:0] rdf2sel;
always@(*)
begin
    if({idsrc1mem,idsrc1ex}==2'b11)
        rfd1sel=2'b01;
    else
        rfd1sel={idsrc1mem,idsrc1ex};
end
always@(*)
begin
    if({memaeq,aluaeq}==2'b11)
        sela=1;
    else
        sela={memaeq,aluaeq};
end
always@(*)
begin
    if({membeq,alubeq}==2'b11)
        selb=1;
    else
        selb={membeq,alubeq};
end
always@(*)
begin
    if({rfd2dmbeq,rfd2alueq}==2'b11)
        rfd2sel=1;
    else
        rfd2sel={rfd2dmbeq,rfd2alueq};
end
endmodule