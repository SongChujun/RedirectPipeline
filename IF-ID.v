module IF_ID(pc,nxt_pc,IR,nxt_IR,stall,clk,PCclear);
input[31:0] pc;
input[31:0] IR;
output[31:0] nxt_pc;
output[31:0] nxt_IR;
input stall;
input clk;
input PCclear;
reg reg_clr;
wire PCclearregout;
register #1 register_pcclear(1,clk,PCclear,0,PCclearregout);
always @(PCclearregout or PCclear)  
begin
    if((PCclearregout)&&(PCclear))
        reg_clr=1;
    else
        reg_clr=0;
end
register #32 register_pc(stall,clk,pc,reg_clr,nxt_pc);
register #32 register_IR(stall,clk,IR,reg_clr,nxt_IR);
endmodule
