`timescale 1ns / 1ns
module controllertb;
    reg[5:0] op;
    reg[31:0] pc;
    reg[31:0] aluout;
    reg[25:0] label;
    reg[31:0] rfd1;
    reg[5:0] funct;
    reg clk;
    reg pcen;
    wire[31:0] newpc;
    wire pcclear;
    wire[15:0] uncondsum;
    wire[15:0] condsuccsum;
    wire[15:0] condsum; 
  initial
   begin
   
   pc<=$random;
   aluout<=$random;
   label<=$random;
   rfd1<=$random;
   clk<=0; 
   op<=$random;
   funct<=random;
   #10
   op<=6'b0;
   funct<=6'b08;
   #10
   op<=6'h2;
   #10
   op>=6'h3;
   #10
    aluout<=0;
    op<=6'h4;
    #10
    aluout<=2;
    op<=5; 
    #10
    aluout<=1;
    op<=6'h01;
   end
    always #10 clk <= ~clk;
    npc npc_ins(op,pc,aluout,label,rfd1,funct,clk,pcen,newpc,pcclear,uncondsum,condsuccsum,condsum);
endmodule