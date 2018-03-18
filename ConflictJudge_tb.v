`timescale 1ns / 1ns
module ConflictJudge_tb;
    reg[5:0] IDop;
    reg[5:0] IDfunct;
    reg[4:0] IDrs;
    reg[4:0] IDrt;
    reg[5:0] EXop;
    reg[5:0] Exfunct;
    reg[4:0] EXrd;
    reg[4:0] EXrt;
    reg[5:0] MEMop;
    reg[5:0] MEMfunct;
    reg[4:0] MEMrd;
    reg[4:0] MEMrt;
    wire stall;
    wire  ALUaeq;
    wire ALUbeq;
    wire MEMaeq;
    wire MEMbeq;
    wire rfd2alueq;
    wire rfd2dmeq;
    wire src1ex;
    wire src1mem;
    initial
    begin
   IDop=6'b0;
   IDfunct=6'b100000;
   IDrs=5'b10001;
   IDrt=5'b10001;
   EXop=6'b1000;
   Exfunct=6'b000000;
   EXrt=5'b10001;//EXrt==ALUA,测试aluaeq,EXrt=ALUB,测试alubeq.EXrt=IDsrc1,测试src1ex,Exdt=IDsrc2,测试rfd2alueq
   EXrd=5'b00000;
   MEMop=5'b0;
   MEMfunct=6'b100010;
   MEMrd=5'b10001;
   MEMrt=5'b10001;//Memdt==IDsrc1,测试src1mem,Memdt=IDsrc2,测试rfd2mem;
   #100
   EXop=6'h23;
   EXrt=5'b10001;//Exdt=IDsrc1=IDsrc2,测试stall
   end
     ConflictJudge u1(IDop,IDfunct,IDrs,IDrt,EXop,Exfunct,EXrd,EXrt,MEMop,MEMfunct,MEMrd,MEMrt,stall,
ALUaeq,ALUbeq,MEMaeq,MEMbeq,rfd2alueq,rfd2dmeq,src1ex,src1mem);
endmodule