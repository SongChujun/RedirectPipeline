`timescale 1ns / 1ns
module ConflictJudge(IDop,IDfunct,IDrs,IDrt,EXop,Exfunct,EXrd,EXrt,MEMop,MEMfunct,MEMrd,MEMrt,stall,
ALUaeq,ALUbeq,MEMaeq,MEMbeq,rfd2alueq,rfd2dmeq,src1ex,src1mem);
input[5:0] IDop;
input[5:0] IDfunct;
input[4:0] IDrs;
input[4:0] IDrt;
input[5:0] EXop;
input[5:0] Exfunct;
input[4:0] EXrd;
input[4:0] EXrt;
input[5:0] MEMop;
input[5:0] MEMfunct;
input[4:0] MEMrd;
input[4:0] MEMrt;

output reg stall==0;
output reg ALUaeq=0;
output reg ALUbeq=0;
output reg MEMaeq=0;
output reg MEMbeq=0;
output reg rfd2alueq=0;
output reg rfd2dmeq=0;
output reg src1ex=0;
output reg src1mem=0;

reg IDsrc1mux1sel=0;
reg IDsrc1mux2sel=0;
reg[4:0] IDsrc1=0;
reg IDsrc2mux1sel=0;
reg IDsrc2mux2sel=0;
reg[4:0] IDsrc2=0;

reg[4:0] Exdt=0;
reg[1:0] Exdtmux1sel=0;
reg Exdtmux2sel=0;
reg Exdtmux3sel=0;

reg[4:0] MEMdt=0;
reg[1:0] MEMdtmux1sel=0;
reg MEMdtmux2sel=0;
reg MEMdtmux3sel=0;

reg[4:0] ALUA=0;
reg ALUAmux1sel=0;
reg ALUAmux2sel=0;

reg[4:0] ALUB=0;
reg ALUBmuxsel=0;

reg[4:0] lwdt=0;
reg lwdtalusel=0;
always@(IDop or IDfunct)
begin
    if((IDop==0)&&(IDfunct==6'h0c))
    begin
        IDsrc1mux1sel=1;
        IDsrc2mux1sel=1;
    end
    else
    begin
        IDsrc1mux1sel=0;
        IDsrc2mux1sel=0;
    end
    if(((IDop==0)&&((IDfunct==6'h08)))||((IDop==6'h9)||(IDop==6'hc)||(IDop==6'hd)||(IDop==6'h23)||
    (IDop==6'ha)||(IDop==6'h2)||(IDop==6'h3)||(IDop==6'he)||(IDop==6'h24)||(IDop==6'h01)))
        IDsrc2mux2sel=1;
    else
        IDsrc2mux2sel=0;
    if((IDop==0)&&((IDfunct==6'h0)||(IDfunct==6'h2)||(IDfunct==6'h3)||(IDfunct==6'h6)))
        ALUAmux1sel=0;
    else
        ALUAmux1sel=1;
    if(((IDop==0)&&((IDfunct==6'h08)||(IDfunct==6'h0c)))||((IDop==6'h1)||(IDop==6'h2)||(IDop==6'h3)))
        ALUAmux2sel=1;
    else
        ALUAmux2sel=0;
    if((IDop==0)&&((IDfunct==6'h20)||(IDfunct==6'h21)||(IDfunct==6'h24)||(IDfunct==6'h22)||(IDfunct==6'h25)
    ||(IDfunct==6'h27)||(IDfunct==6'h2a)||(IDfunct==6'h2b))||((IDop==6'h04)||(IDop==6'h05)))
        ALUBmuxsel=1;
    else
        ALUBmuxsel=0;
    if((EXop==6'h23)||(EXop==6'h24))
        lwdtalusel=1;
    else
        lwdtalusel=0;
        
end
always@(*)
begin
    if((IDsrc1mux1sel==1)||((IDsrc1mux2sel==0)))
        IDsrc1=6'h02;
    else if((IDsrc1mux1sel==0)||((IDsrc1mux2sel==0)))
        IDsrc1=IDrs;
    else
        IDsrc1=0;
end
always@(*)
begin
    if((IDsrc2mux1sel==1)||((IDsrc2mux2sel==0)))
        IDsrc2=6'h04;
    else if((IDsrc1mux1sel==0)||((IDsrc1mux2sel==0)))
        IDsrc2=IDrt;
    else
        IDsrc2=0;
end
always@(EXop or Exfunct)
begin
    Exdtmux1sel={((EXop==6'h08)||(EXop==6'h09)||(EXop==6'h0c)||(EXop==6'h0d)||(EXop==6'h23)||(EXop==6'h24)||
    (EXop==6'h0a)||(EXop==6'h0e)),((EXop==0)&&((Exfunct==6'h20)||(Exfunct==6'h21)||(Exfunct==6'h24)||(Exfunct==6'h0)||
    (Exfunct==6'h02)||(Exfunct==6'h03)||(Exfunct==6'h22)||(Exfunct==6'h25)||(Exfunct==6'h27 )||(Exfunct==6'h2a)||
    (Exfunct==6'h2b)||(Exfunct==6'h06)))};
    Exdtmux2sel=(((EXop==0)&&((Exfunct==6'h08)||(Exfunct==6'h0c)))||((EXop==6'h1)||(EXop==6'h2)||(EXop==6'h4)||
    (EXop==6'h5)||(EXop==6'h2b)));
    if(EXop==6'h03)
        Exdtmux3sel=1;
    else
        Exdtmux3sel=0;
end
always@(*)
begin
    if(Exdtmux3sel==1)
        Exdt=5'h1f;
    else if(((Exdtmux3sel!=1))&&(Exdtmux2sel==1))
        Exdt=0;
    else
    begin
        if(Exdtmux1sel==2'b01)
            Exdt=EXrd;
        else if(Exdtmux1sel==2'b10)
            Exdt=EXrt;
        else
            Exdt=0;
    end
end

always@(MEMop or MEMfunct)
begin
    MEMdtmux1sel={((MEMop==6'h08)||(MEMop==6'h09)||(MEMop==6'h0c)||(MEMop==6'h0d)||(MEMop==6'h23)||(MEMop==6'h24)||
    (MEMop==6'h0a)||(MEMop==6'h0e)),(MEMop==0)&&((MEMfunct==6'h20)||(MEMfunct==6'h21)||(MEMfunct==6'h24)||(MEMfunct==6'h0)||
    (MEMfunct==6'h02)||(MEMfunct==6'h03)||(MEMfunct==6'h22)||(MEMfunct==6'h25)||(MEMfunct==6'h27 )||(MEMfunct==6'h2a)||
    (MEMfunct==6'h2b))};
    MEMdtmux2sel=(((MEMop==0)&&((MEMfunct==6'h08)||(MEMfunct==6'h0c)))||((MEMop==6'h1)||(MEMop==6'h2)||(MEMop==6'h4)||
    (MEMop==6'h5)||(MEMop==6'h2b)));
    if(MEMop==6'h03)
        MEMdtmux3sel=1;
    else
        MEMdtmux3sel=0;
end
always@(*)
begin
    if(MEMdtmux3sel==1)
        MEMdt=5'h1f;
    else if((MEMdtmux3sel!=1)&&(MEMdtmux2sel==1))
        MEMdt=0;
    else
    begin
        if(MEMdtmux1sel==2'b01)
            MEMdt=MEMrd;
        else if(MEMdtmux1sel==2'b10)
            MEMdt=MEMrt;
        else
            MEMdt=0;
    end
end
always@(*)
begin
    if(ALUAmux2sel==1)
        ALUA=0;
    else
    begin
        if(ALUAmux1sel==1)
            ALUA=IDrs;
        else
            ALUA=IDrt;
    end
end
always@(*)
begin
    if(ALUBmuxsel==1)
        ALUB=IDrt;
    else
        ALUB=0;
end
always@(*)
begin
    if(lwdtalusel==1)
        lwdt=EXrt;
    else
        lwdt=0;
end
always@(*)
begin
    if(((IDsrc1!=0)&&(IDsrc1==lwdt))||((IDsrc2!=0)&&(IDsrc2==lwdt)))
        stall=1;
    else
        stall=0;
end
always@(*)
begin
    if((ALUA!=0)&&(ALUA==Exdt))
        ALUaeq=1;
    else
        ALUaeq=0;
end
always@(*)
begin
    if((ALUB!=0)&&(ALUB==Exdt))
        ALUB=1;
    else
        ALUB=0;
end
always@(*)
begin
    if((Exdt!=0)&&(Exdt==IDsrc2))
        rfd2alueq=1;
    else
        rfd2alueq=0;
end
always@(*)
begin
    if((MEMdt!=0)&&(MEMdt==IDsrc2))
        rfd2dmeq=1;
    else
        rfd2dmeq=0;
end
always@(*)
begin
    if((IDsrc1!=0)&&(IDsrc1==Exdt))
        src1ex=1;
    else
        src1ex=0;
end
always@(*)
begin
    if((IDsrc1==MEMdt)&&(IDsrc1!=0))
        src1mem=1;
    else
        src1mem=0;
end
always@(*)
begin
    if((MEMdt!=0)&&(MEMdt==ALUA))
        MEMaeq=1;
    else
        MEMaeq=0;
end
always@(*)
begin
    if((MEMdt!=0)&&(MEMdt==ALUB))
        MEMbeq=1;
    else
        MEMbeq=0;
end
endmodule


