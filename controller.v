module controller(IR,ALUop,dmload,dmstr,dmsel,ra,rb,rt,rs,funct,op,imm);
input IR[31:0];
output reg  ALUop[3:0];
output reg dmload;
output reg dmstr;
output reg dmsel;
output reg[4:0] ra;
output reg[4:0] rb;
output reg[4:0] rt;
output reg[4:0] rs;
output reg[5:0] funct;
output reg[5:0] op;
output reg[15:0] imm;
always@(op)
begin
  if((op==6'b100011)||(op==6'b100100))
    dmsel<=1;
  else
    dmsel<=0;
end
always@(op)
begin
  if((op==6'b100011)||(op==6'b100100))
    dmsel<=1;
  else
    dmsel<=0;
end
always@(op)
begin
  if((op==6'b100011)||(op==6'b100100))
    dmsel<=1;
  else
    dmsel<=0;
end

