module MEM_WB(pc,dmdout,aluout,IR,SEL,rfd1,rfd2,clk,rst
,pc_nxt,dmdout_nxt,aluout_nxt,IR_nxt,SEL_nxt,rfd1_nxt,rfd2_nxt);
input[31:0] pc;
input[31:0] dmdout;
input[31:0] aluout;
input[31:0] IR;
input[1:0] SEL;
input[31:0] rfd1;
input[31:0] rfd2;
input clk;
input rst;
output[31:0] pc_nxt;
output[31:0] dmdout_nxt;
output[31:0] aluout_nxt;
output[31:0] IR_nxt;
output[1:0] SEL_nxt;
output[31:0] rfd1_nxt;
output[31:0] rfd2_nxt;
register #32 register_pc(1,clk,pc,rst,pc_nxt);
register #32 register_dmdout(1,clk,dmdout,rst,dmdout_nxt);
register #32 register_aluout(1,clk,aluout,rst,aluout_nxt);
register #32 register_IR(1,clk,IR,rst,IR_nxt);
register #2 register_SEL(1,clk,SEL,rst,SEL_nxt);
register #32 register_rfd1(1,clk,rfd1,rst,rfd1_nxt);
register #32 register_rfd2(1,clk,rfd2,rst,rfd2_nxt);
endmodule