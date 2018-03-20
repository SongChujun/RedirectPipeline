module EX_MEM(dmld,dmsel,dmstr,aluout,rfd1,rfd2,pc,IR,clk,rst,dmld_nxt,dmsel_nxt,dmstr_nxt,aluout_nxt,rfd1_nxt,rfd2_nxt
,pc_nxt,IR_nxt);
input dmld;
input dmsel;
input dmstr;
input[31:0] aluout;
input[31:0] rfd1;
input[31:0] rfd2;
input[31:0] pc;
input[31:0] IR;
input clk;
input rst;
output dmld_nxt;
output dmsel_nxt;
output dmstr_nxt;
output[31:0] aluout_nxt;
output[31:0] rfd1_nxt;
output[31:0] rfd2_nxt;
output[31:0] pc_nxt;
output[31:0] IR_nxt;
register #1 register_dmld(1,clk,dmld,rst,dmld_nxt);
register #1 register_dmsel(1,clk,dmsel,rst,dmsel_nxt);
register #1 register_dmstr(1,clk,dmstr,rst,dmstr_nxt);
register #32 register_aluout(1,clk,aluout,rst,aluout_nxt);
register #32 register_rfd1(1,clk,rfd1,rst,rfd1_nxt);
register #32 register_rfd2(1,clk,rfd2,rst,rfd2_nxt);
register #32 register_pc(1,clk,pc,rst,pc_nxt);
register #32 register_IR(1,clk,IR,rst,IR_nxt);
endmodule