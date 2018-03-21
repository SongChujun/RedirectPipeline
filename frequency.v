module frequency_switch(primitive_clk, clk, clk_switch);
input primitive_clk;
input clk_switch;
output reg clk = 0;
parameter p1=50000;
reg[32:0] counter_M=0;
always @(posedge primitive_clk)  
begin  
    if(clk_switch==0)
    begin
        if(counter_M==(p1/2-1))
        begin
            counter_M = 0;
            clk = ~clk;
        end                  
        counter_M= counter_M + 1;
    end
    else
    begin
            clk = ~clk;
    end
end 
endmodule