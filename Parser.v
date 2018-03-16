`timescale 1ns / 1ns
module controller(IR,op,rs,rt,rs,shamt,funct);
input[31:0] IR;
output reg[5:0] op;
output reg[4:0] rs;
output reg[4:0] rt;
output reg[4:0] rd;
output reg[4:0] shamt;
output reg[5:0] funct;
always@(*)
begin
    op<=IR[31:26];
    rs<=IR[25:21];
    rt<=IR[20:16];
    rd<=IR[15:11];
    shamt<=IR[10:6];
    funct<=IR[5:0];
end
endmodule

    


