`timescale 1ns / 1ns
module parser(IR,op,rs,rt,rd,shamt,funct);
input[31:0] IR;
output reg[5:0] op=0;
output reg[4:0] rs=0;
output reg[4:0] rt=0;
output reg[4:0] rd=0;
output reg[4:0] shamt=0;
output reg[5:0] funct=0;
always@(*)
begin
    op=IR[31:26];
    rs=IR[25:21];
    rt=IR[20:16];
    rd=IR[15:11];
    shamt=IR[10:6];
    funct=IR[5:0];
end
endmodule

    


