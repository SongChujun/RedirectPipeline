module ID_EX(IR,alusela,aluselb,dmld,dmsel,dmstr,aluop,rfd2sel,rfd1sel,pc,rfd1,rfd2,immext,clk,stall,PCen
,IR_nxt,alusela_nxt,aluselb_nxt,dmld_nxt,dmsel_nxt,dmstr_nxt,aluop_nxt,rfd2sel_nxt,rfd1sel_nxt,pc_nxt,rfd1_nxt,rfd2_nxt,immext_nxt);
input[31:0] IR;
input[1:0] alusela;
input[1:0] aluselb; 
input dmld;
input dmsel;
input dmstr;
input[3:0] aluop;
input[1:0] rfd2sel;
input[1:0] rfd1sel;
input[31:0] pc;
input[31:0] rfd1;
input[31:0] rfd2;
input[31:0] immext;
input clk;
input stall;
input PCen;

output[31:0] IR_nxt;
output[1:0] alusela_nxt;
output[1:0] aluselb_nxt; 
output dmld_nxt;
output dmsel_nxt;
output dmstr_nxt;
output[3:0] aluop_nxt;
output[1:0] rfd2sel_nxt;
output[1:0] rfd1sel_nxt;
output[31:0] pc_nxt;
output[31:0] rfd1_nxt;
output[31:0] rfd2_nxt;
output[31:0] immext_nxt;
reg reg_clr;
wire stallregout;
register #1 register_stall(1,clk,stall,0,stallregout);
always @(stallregout or stall)  
begin
    if(stallregout&&stall)
        reg_clr=1;
    else
        reg_clr=0;
end
register #32 register_IR(!PCen,clk,IR,reg_clr,IR_nxt);
register #2 register_alusela(!PCen,clk,alusela,reg_clr,alusela_nxt);
register #2 register_aluselb(!PCen,clk,aluselb,reg_clr,aluselb_nxt);
register #1 register_dmld(!PCen,clk,dmld,reg_clr,dmld_nxt);
register #1 register_dmsel(!PCen,clk,dmsel,reg_clr,dmsel_nxt);
register #1 register_dmstr(!PCen,clk,dmstr,reg_clr,dmstr_nxt);
register #4 register_aluop(!PCen,clk,aluop,reg_clr,aluop_nxt);
register #2 register_rfd2sel(!PCen,clk,rfd2sel,reg_clr,rfd2sel_nxt);
register #2 register_rfd1sel(!PCen,clk,rfd1sel,reg_clr,rfd1sel_nxt);
register #32 register_pc(!PCen,clk,pc,reg_clr,pc_nxt);
register #32 register_rfd1(!PCen,clk,rfd1,reg_clr,rfd1_nxt);
register #32 register_rfd2(!PCen,clk,rfd2,reg_clr,rfd2_nxt);
register #32 register_immext(!PCen,clk,immext,reg_clr,immext_nxt);
endmodule
