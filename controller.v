`timescale 1ns / 1ns
module controller(IR,ALUop,dmload,dmstr,dmsel,ra,rb,rt,rs,funct,op,imm);
input[31:0] IR;
output reg[3:0] ALUop=0;
output reg dmload=0;
output reg dmstr=0;
output reg dmsel=0;
output reg[4:0] ra=0;
output reg[4:0] rb=0;
output reg[4:0] rt=0;
output reg[4:0] rs=0;
output reg[5:0] funct=0;
output reg[5:0] op=0;
output reg[15:0] imm=0;
reg[3:0] alumuxsrc0=0;
reg[3:0] alumuxsrc1=0;
reg alumuxsel=0;
always@(op)
begin
  if((op==6'b100011)||(op==6'b100100))
    dmload<=1;
  else
    dmload<=0;
end
always@(op)
begin
  if((op==6'b100011)||(op==6'b100100)||(op==6'b101011))
    dmsel<=1;
  else
    dmsel<=0;
end
always@(op)
begin
  if(op==6'b101011)
    dmstr<=1;
  else
    dmstr<=0;
end
always@(*)
begin
    funct<=IR[5:0];
    rt<=IR[20:16];
    rs<=IR[25:21];
    op<=IR[31:26];
    imm<=IR[15:0];
end
always@(funct)
begin
    if(funct==6'b000010)
        alumuxsrc1<=4'h2;
    else if(funct==6'b000011)
        alumuxsrc1<=4'h1;
    else if(funct==6'h6)
        alumuxsrc1<=4'h2;
    else if(funct==6'h20)
        alumuxsrc1<=4'h5;
    else if(funct==6'h21)
        alumuxsrc1<=4'h5;
    else if(funct==6'h22)
        alumuxsrc1<=4'h6;
    else if(funct==6'h24)
        alumuxsrc1<=4'h7;
    else if(funct==6'h25)
        alumuxsrc1<=4'h8;
    else if(funct==6'h26)
        alumuxsrc1<=4'h9;
    else if(funct==6'h27)
        alumuxsrc1<=4'ha;
    else if(funct==6'h2a)
        alumuxsrc1<=4'hb;
    else if(funct==6'h2b)
        alumuxsrc1<=4'hc;
    else
        alumuxsrc1<=0;
end
always@(op)
begin
    case (op)
        6'h1:alumuxsrc0<=4'hb;
        6'h4:alumuxsrc0<=4'h9;
        6'h5:alumuxsrc0<=4'h9;
        6'h8:alumuxsrc0<=4'h5;
        6'h9:alumuxsrc0<=4'h5;
        6'ha:alumuxsrc0<=4'hb;
        6'hc:alumuxsrc0<=4'h7;
        6'hd:alumuxsrc0<=4'h8;
        6'he:alumuxsrc0<=4'h9;
        6'h2b:alumuxsrc0<=4'h5;
      default:alumuxsrc0<=4'h0; 
    endcase
end
always@(op or funct)
begin
    if(op==6'b0)
        alumuxsel<=1;
    else
        alumuxsel<=0;
end
always@(alumuxsel or alumuxsrc0 or alumuxsrc1)
begin
    if(alumuxsel==1'b0)
        ALUop<=alumuxsrc0;
    else
        ALUop<=alumuxsrc1;
end
always@(*)
begin
    if((op==6'b0)&&(funct==6'hc))
    begin
        ra<=4'h2;
        rb<=4'h4;
    end
    else
    begin    
        ra<=rs;
        rb<=rt;
    end
end
endmodule

    


