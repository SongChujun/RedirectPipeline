`timescale 1ns / 1ns
module MUX8#(parameter width = 32)(addr,in0,in1,in2,in3,in4,in5,in6,in7,out,enable);
input[2:0] addr;
input[width - 1:0] in0,in1,in2,in3,in4,in5,in6,in7;
input enable;
output reg[width - 1:0] out=0;

always@(addr or in0 or in1 or in2 or in3 or in4 or in5 or in6 or in7 or enable )
begin
    if(!enable)
        case (addr)
          3'b000:out=in0;
          3'b001:out=in1;
          3'b010:out=in2;
          3'b011:out=in3;
          3'b100:out=in4;
          3'b101:out=in5;
          3'b110:out=in6;
          3'b111:out=in7;
        endcase
    else
        out=0;
end
endmodule