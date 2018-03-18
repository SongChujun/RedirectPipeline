//module register#(parameter width=32)(ena,clk,data,clr,out);
//module IM(A,D_out);
//module IF_ID(pc,nxt_pc,IR,nxt_IR,stall,clk,PCclear);
//module controller(IR,ALUop,dmload,dmstr,dmsel,ra,rb,rt,rs,funct,op,imm);
//module DM(ra, rb, D,load,str,sel, clr, clk,A_out , B_out);
// module RF(rA, rB, rW, WE, w, clk,A, B);
// module ext(data,op,funct,extdata);
module data_toute(clk1,ram_addr,rst,frequency,rst,display,AN,SEG);
input clk1; // 时钟
input [5:0] ram_addr; // 内存地址
input rst; // 总控制开关
input frequency,rst; // fre 切换开关
input [2:0] display; // 控制显示何种消息
output [7:0] AN; // 用于显示输入
output [7:0] SEG; // 用于显示输入
wire [31:0]  total_cycles_display;
wire[31:0] conditional_jmp;
wire[31:0] unconditional_jmp;
wire[31:0] successful_conditional_jmp;
assign total_cycles_display = {16'b0,cycle_counter};
assign conditional_jmp={16'b0,condsum};
assign unconditional_jmp={16'b0,uncondsum};
assign successful_conditional_jmp={16'b0,condsussum}
frequency_switch my_frequency(clk1, clk_sys, frequency);
wire [31:0] memory; // 用于显示的ram 的数值
Data_Choose show_data(
display,
memory,
total_cycles_display,
conditional_jmp,
unconditional_jmp,
successful_conditional_jmp,
syscall_display,
PCregout,
clk1, 
AN,
SEG);

reg clk_sys;
wire[31:0] #npc;
wire PCclear;
wire[15:0] undondsum;
wire[15:0] condsum;
wire[15:0] condsussum;
wire[31:0] PCregout;
wire[31:0] PCregin
reg stall;
reg PCen;

wire[31:0] IFIR;

wire[31:0] IDIR;
wire[31:0] IDpc;
wire[3:0] IDALUop;
wire IDdmload,IDdmstr,IDdmsel;
wire[4:0] IDrA;
wire[4:0] IDrB;
wire[5:0] IDop;
wire[5:0] IDfunct;
wire[4:0] IDrt,IDrs;
wire[15:0] IDinimm;
wire[31:0] IDrfd1;
wire[31:0] IDrfd2;
wire[31:0] IDimm;
wire[1:0] IDALUsela;
wire[1:0] IDALUselb;
wire[1:0] IDrfd2sel;
wire[1:0] IDrfd1sel;

wire Exdmstr;
wire Exdmsel;
wire Exdmld;
wire[3:0] ExALUop;
wire[31:0] ExIR;
wire[1:0] Exalusela;
wire[1:0] Exaluselb;
wire[31:0] Expc;
wire[31:0] Exrfd1;
wire[31:0] Exrfd2;
wire[1:0] Exrfd2sel;
wire[1:0] Exrfd1sel;
wire[31:0] Eximmext;
wire[31:0] ExALUout;
wire[25:0] Exlabel;
wire[5:0] Exop;
wire[5:0] Exfunct;
wire[4:0] Exshamt;
wire[4:0] Exrs;
wire[4:0] Exrt;
wire[4:0] Exrd;
reg[31:0] alusrc1;
reg[31:0] alusrc2;
reg alusrc1muxsel;
wire[31:0] memaluout;
wire[31:0] wbout;
wire[31:0] alusrc2tmp;
wire aluSrcB;
wire[31:0] Exrfd2ToMem;

wire Memdmld;
wire Memdmsel;
wire Memdmstr;
wire[31:0] Memrfd1;
wire[31:0] Memrfd2;
wire[31:0] Mempc;
wire[31:0] MemIR
wire[5:0] Memop;
wire[5:0] Memfunct;
wire[4:0] Memrd;
wire[4:0] Memrt;
wire[4:0] Memrs;
wire[4:0] Memshamt;
reg[23:0] dmaddr;
wire[31:0] Memdmout;//////////////////////////////////////////////////////////////////////////////////////////
wire[1:0] MEMSEL;
wire WBWE;
wire[31:0] WBpc;
wire[4:0] WBrw;
wire[31:0] WBdmout;
wire[31:0] WBaluout;
wire[31:0] WBIR;
wire[1:0] WBSEL;
wire[31:0] WBrfd1;
wire[31:0] WBrfd2; 
wire[5:0] WBop;
wire[5:0] WBfunct;
wire[4:0] WBshamt;
wire[4:0] WBrd;
wire[4:0] WBrs;
wire[4:0] WBrt;
wire[15:0] WBimm;
wire[31:0] WBrfdata;
wire WBrfw3#;
wire[31:0] PCenMUXdata;
wire[15:0] PCencnt; 
wire PCenclr;
wire syscall_display_en;
wire[31:0] syscall_display;
wire ALUaeq,ALUbeq,MEMaeq,MEMbeq,rfd2alueq,rfd2dmeq,src1ex,src1mem;
wire[15:0] cycle_counter;
MUX2 #32 MUX2_pc(PCclear,PCregout+4,#npc,PCregin,0);
regester #32 regester_pc(!(stall|PCen),clk_sys,PCregin,rst,PCregout);
IM IM_IR(PCregout[11:2],IFIR);
IF_IF IF_ID_ins(PCregout,IDpc,IDIR,IFIR,clk_sys,PCclear);
controller controller_ins(IDIR,IDALUop,IDdmload,IDdmstr,IDdmsel,IDrA,IDrB,IDrt,IDrs,IDfunct,IDop,IDinimm);
//module DM(ra, rb, D,load,str,sel, clr, clk,A_out , B_out);
ext ext_ins(IDinimm,IDop,IDfunct,IDimm);
// module ID_EX(IR,alusela,aluselb,dmld,dmsel,dmstr,aluop,rfd2sel,rfd1sel,pc,rfd1,rfd2,immext,clk,stall,PCen
// ,IR_nxt,alusela_nxt,aluselb_nxt,dmld_nxt,dmsel_nxt,dmstr_nxt,aluop_nxt,rfd2sel_nxt,rfd1sel_nxt,pc_nxt,rfd1_nxt,rfd2_nxt,immext_nxt);
ID_EX ID_EX_ins(IDIR,IDALUsela,IDALUselb,IDdmload,IDdmsel,IDdmstr,IDALUop,IDrfd2sel,IDrfd1sel,IDpc,IDrfd1,IDrfd2,IDimm,clk_sys,(PCclear||stall),PCen,
ExIR,Exalusela,Exaluselb,Exdmld,Exdmsel,Exdmstr,ExALUop,Exrfd2sel,Exrfd1sel,Expc,Exrfd1,Exrfd2,Eximmext);
// module parser(IR,op,rs,rt,rd,shamt,funct);
parser parser_Ex(ExIR,Exop,Exrs,Exrt,Exrd,Exshamt,Exfunct);
assign Exlabel={Exrs,Exrt,Exrd,Exshamt,Exfunct};
// module npc(op,pc,aluout,label,rfd1,funct,clk,pcen,newpc,pcclear,uncondsum,condsussum,condsum);
npc npc_ins(Exop,Expc,ExALUout,Exlabel,Exrfd1,Exfunct,clk_sys,!Pcen,#npc,pcclear,uncondsum,condsussum,condsum);
always@(Exop or Exfunct)
begin
    if((Exop==0)&&((Exfunct==0)||(Exfunct==6'h2)||(Exfunct==6'h3)||(Exfunct==6'h6)))
        alusrc1muxsel=1;
    else
        alusrc1muxsel=0;
end
always(*)
begin
    if(Exalusela==0)
    begin
        if(alusrc1muxsel==1)
            alusrc1=Exrfd2;
        else
            alusrc1=Exrfd1;
    end
    else if(Exalusela==2'b01)
        alusrc1=memaluout;
    else if(Exalusela=2'b10)
        alusrc1=wbout;
end
// module ALUsrcB(op,funct,ALUsrcB);
ALUsrcB ALUsrcB_ins(EXop,Exfunct,aluSrcB);
always@(aluSrcB or EXop or Exfunct) 
begin
    if((Exop==0)&&(Exfunct==6'h06))
        alusrc2tmp=Exrfd2;
    else
    begin
        if(aluSrcB)
            alusrc2tmp=Eximmext;
        else
            alusrc2tmp=Exrfd2;
    end
end
always(*)
begin
    if(Exaluselb==0)
        alusrc2=alusrc2tmp;
    else if(Exaluselb==2'b01)
        alusrc2=memaluout;
    else if(Exaluselb==2'b10)
        alusrc2=wbout;
end
// module ALU(X,Y,OP,R,R2,OF,UOF,Equal);
wire[31:0] aluR2;
wire aluof;
wire aluuof;
wire alueq;
ALU ALU_ins(alusrc1,alusrc2,ExALUop,ExALUout,aluR2,aluof,aluuof,alueq);
MUX4 MUX4_exrfd2(Exrfd2sel,Exrfd2,memaluout,wbout,0,Exrfd2ToMem,0);
// module EX_MEM(dmld,dmsel,dmstr,aluout,rfd1,rfd2,pc,IR,clk,rst,dmld_nxt,dmsel_nxt,dmstr_nxt,aluout_nxt,rfd1_nxt,rfd2_nxt
// ,pc_nxt,IR_nxt);
EX_MEM EX_MEM_ins(Exdmld,Exdmsel.Exdmstr,ExALUout,Exrfd1,Exrfd2ToMem,Expc,ExIR,clk_sys,rst,Memdmld,Memdmsel,Memdmstr,memaluout,
Memrfd1,Memrfd2,Mempc,MemIR);
// module parser(IR,op,rs,rt,rd,shamt,funct);
parser parsel_Mem(MemIR,Memop,Memfunct,Memrs,Memrt,Memrd,Memshamt,Memfunct);
always@(*)
begin
    if(Memop==6'h24)
        dmaddr=(memaluout>>2'b10);
    else
        dmaddr=memaluout;
end
// module DM(ra, rb, D,load,str,sel, clr, clk,A_out,B_out);
DM DM_ins(dmaddr[5:0],ram_addr,Memrfd2,Memdmld,Memdmstr,Memdmsel,rst,clk_sys,Memdmout,memory);
assign MEMSEL=memaluout[1:0];
// module ConflictJudge(IDop,IDfunct,IDrs,IDrt,EXop,Exfunct,EXrd,EXrt,MEMop,MEMfunct,MEMrd,MEMrt,stall,
// ALUaeq,ALUbeq,MEMaeq,MEMbeq,rfd2alueq,rfd2dmeq,src1ex,src1mem);
ConflictJudge ConflictJudge_ins(IDop,IDfunct,IDrs,IDrt,Exop,Exfunct,Exrd,MEMop,Memfunct,Memrd,MEMrt,stall
,ALUaeq,ALUbeq,MEMaeq,MEMbeq,rfd2alueq,rfd2dmeq,src1ex,src1mem);
// module alusrcsel(idsrc1mem,idsrc1ex,memaeq,aluaeq,membeq,alubeq,rfd2dmbeq,rfd2alueq,sela,selb,rfd1sel,rdf2sel);
alusrcsel alusrcsel_ins(src1mem,src1ex,memaeq,aluaeq,membeq,alubeq,rfd2dmbeq,rfd2alueq,IDALUsela,IDALUselb,IDrfd1sel,IDrfd2sel);
// module MEM_WB(pc,dmdout,aluout,IR,SEL,rfd1,rfd2,clk,rst,pc_nxt,dmdout_nxt,aluout_nxt,IR_nxt,SEL_nxt,rfd1_nxt,rfd2_nxt);
// module MEM_WB(pc,dmdout,aluout,IR,SEL,rfd1,rfd2,clk,rst
// ,pc_nxt,dmdout_nxt,aluout_nxt,IR_nxt,SEL_nxt,rfd1_nxt,rfd2_nxt);
EX_MEM EX_MEM_ins(Mempc,Memdmout,memaluout,MemIR,MEMSEL,Memrfd1,Memrfd2,clk_sys,rst,WBpc,WBdmout,WBaluout,WBIR,WBSEL,WBrfd1,WBrfd2);
// module parser(IR,op,rs,rt,rd,shamt,funct);
parser parser_wb(MemIR,Memop,Memrs,Memrt,Memrd,Memshamt,Memfunct);
assign WBimm={WBrd,WBshamt,WBfunct};
// module RFdin(op,sel,dmdout,aluout,pc,imm,data)
RFdin RFdin_ins(WBop,WBSEL,WBdmout,WBaluout,WBpc,WBimm,WBrfdata);
// module RFw#(op,funct,w#);
RFw# RFw#_ins(WBop,WBfunct,WBWE);
always@(*)
begin
    if(MEMop==6'H03)
        WBrw=5'h1f;
    else if(MEMop==0)
        WBrw=MEMrd;
    else
        WBrw=MEMrt;
end
// module RF(rA, rB, rW, WE, w, clk,A, B);
RF RF_ins(IDrA,IDrB,WBrw,WBWE,WBrfdata,clk_sys,IDrfd1,IDrfd2);
MUX4 #32 MUX4_PCenMux(Exrfd1sel,Exrfd1,memaluout,wbout,0,PCenMUXdata,0);
always@(*)
begin
    if((PCenMUXdata==32'h00000032)&&(Exop==6'h0)&&(Exfunct==6'h0c))
        PCencnt=1;
    else
        PCencnt=0;
end
// module counter #(parameter SIZE=16)(clk,clear,count,outval);
counter #16 counter_PCen(clk_sys,PCenclr,PCencnt,PCen);
assign syscall_display_en=( (IDop==0)&&(IDfunct==6'h0c)&&(PCenMUXdata!=32'h00000032));
// regester #32 regester_pc(!(stall|PCen),clk_sys,PCregin,rst,PCregout);
regester #32 regester_PCen(syscall_display_en,clk_sys,IDrfd2,rst,syscall_display);
module counter #(parameter SIZE=16)(clk_sys,clear,count,outval);
counter #16 counter_cyclecnt(clk_sys,rst,!PCen,cycle_counter);

