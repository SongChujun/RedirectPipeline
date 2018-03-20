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
wire pcclearregout;
// register #1 register_stall(1,!clk,pcclear,0,pcclearregout);
register #1 register_stall(1,clk,stall,0,stallregout);
always @(stallregout or stall)  
begin
    if(stallregout&&stall)
        reg_clr=1;  
    else
        reg_clr=0;
end
register #32 register_IR(!PCen,clk,IR,stallregout&stall,IR_nxt);
register #2 register_alusela(!PCen,clk,alusela,stallregout&stall,alusela_nxt);
register #2 register_aluselb(!PCen,clk,aluselb,stallregout&stall,aluselb_nxt);
register #1 register_dmld(!PCen,clk,dmld,stallregout&stall,dmld_nxt);
register #1 register_dmsel(!PCen,clk,dmsel,stallregout&stall,dmsel_nxt);
register #1 register_dmstr(!PCen,clk,dmstr,stallregout&stall,dmstr_nxt);
register #4 register_aluop(!PCen,clk,aluop,stallregout&stall,aluop_nxt);
register #2 register_rfd2sel(!PCen,clk,rfd2sel,stallregout&stall,rfd2sel_nxt);
register #2 register_rfd1sel(!PCen,clk,rfd1sel,stallregout&stall,rfd1sel_nxt);
register #32 register_pc(!PCen,clk,pc,stallregout&stall,pc_nxt);
register #32 register_rfd1(!PCen,clk,rfd1,stallregout&stall,rfd1_nxt);
register #32 register_rfd2(!PCen,clk,rfd2,stallregout&stall,rfd2_nxt);
register #32 register_immext(!PCen,clk,immext,stallregout&stall,immext_nxt);
endmodule
