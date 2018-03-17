`timescale 1ns / 1ns
    reg[5:0] IDop;
    reg[5:0] IDfunct;
    reg[5:0] IDrs;
    reg[5:0] IDrt;
    reg[5:0] EXop;
    reg[5:0] EXfunct;
    reg[5:0] EXrd;
    reg[5:0] EXrt;
    reg[5:0] MEMop;
    reg[5:0] MEMfunct;
    reg[5:0] MEMrd;
    reg[5:0] MEMrt;
    output  stall;
    output  ALUaeq;
    output ALUbeq;
    output MEMaeq;
    output MEMbeq;
    output rfd2alueq;
    output rfd2dmeq;
    output src1ex;
    output src1mem;
    initial

  initial
   begin
   IDop=6'b0;
   IDfunct=6'b100000;
   IDrs=5'b10001;
   IDrt=5'b10001;
   EXop=6'b1000;
   Exfunct=6'b000000;
   EXrt=5'b10001;//EXrt==ALUA,测试aluaeq,EXrt=ALUB,测试alubeq.EXrt=IDsrc1,测试src1ex,Exdt=IDsrc2,测试rfd2alueq
   Exrs=5'b10001; 
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