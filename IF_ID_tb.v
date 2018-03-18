module IF_ID_tb;
reg clk;
reg clk_sys;
reg[31:0] pc;
wire[31:0] nxt_pc;
reg[31:0] IR;
wire[31:0] nxt_IR;
reg stall;
reg PCclear;
initial
begin
    clk=0;
    clk_sys=0;
    pc=$random;
    IR=$random;
    stall=0;
    PCclear=$random;
end
always@(posedge clk)
begin
  pc=$random;
  IR=$random;
  PCclear=$random;
end
always #10 clk=~clk;
always #3 clk_sys=~clk_sys;
IF_ID IF_ID_ins(pc,nxt_pc,IR,nxt_IR,stall,clk_sys,PCclear);
endmodule