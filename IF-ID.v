module IF_ID(pc,nxt_pc,IR,nxt_IR,stall,clk,PCclear);
input[31:0] pc;
input[31:0] IR;
output[31:0] nxt_pc;
output[31:0] nxt_IR;
input stall;
input clk;
input PCclear;
wire PCclearregout;
reg reg_clr=0;
register #1 register_pcclear(1,!clk,PCclear,0,PCclearregout);
// always @( negedge clk or PCclearregout or reg_clr)  
// begin
//     if(PCclearregout==1)
//         reg_clr=0;
//     else

// end
register #32 register_pc(stall,clk,pc,PCclearregout,nxt_pc);
register #32 register_IR(stall,clk,IR,PCclearregout,nxt_IR);
endmodule
