`timescale 1ns / 1ns

module controllertb;
    reg[31:0] IR;
    wire[3:0] ALUop;
    wire dmload;
    wire dmstr;
    wire dmsel;
    wire[4:0] ra;
    wire[4:0] rb;
    wire[4:0] rt;
    wire[4:0] rs;
    wire[5:0] funct;
    wire[5:0] op;
    wire[15:0] imm;
    reg clk;
    initial
    begin
     ;
   #100
   IR[31:26]<=6'b111111;
   IR[5:0]<=6'b111111;
   ;
    end

  initial
   begin
   IR<=$random;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b100000;
   #100
   IR[31:26]<=6'b1000;
   #100
   IR[31:26]<=6'b1001;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b100001;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b100100;
   ;
   #100
   IR[31:26]<=6'b1100;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b0;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b11;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b10;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b100010;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b100101;
   ;
   #100
   IR[31:26]<=6'b1101;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b100111;
   ;
   #100
   IR[31:26]<=6'b100011;
   ;
   #100
   IR[31:26]<=6'b101011;
   ;
   #100
   IR[31:26]<=6'b100;
   ;
   #100
   IR[31:26]<=6'b101;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b101010;
   ;
   #100
   IR[31:26]<=6'b1010;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b101011;
   ;  
   #100
   IR[31:26]<=6'b1010;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b101011;
   ;
   #100
   IR[31:26]<=6'b10;
   ;

   #100
   IR[5:0]<=6'b11;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b1000;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b1100;
   ;
   #100
   IR[31:26]<=6'b0;
   IR[5:0]<=6'b110;
   ;
   #100
   IR[31:26]<=6'b1110;
   ;
   #100
   IR[31:26]<=6'b100100;
   ;
   #100
   IR[31:26]<=6'b1;
   ;
   end
    always #20 clk <= ~clk;
    controller u1(.IR(IR),.ALUop(ALUop),.dmload(dmload),.dmstr(dmstr),.dmsel(dmsel),.ra(ra),.rb(rb),.rt(rt),.rs(rs),.funct(funct),.op(op),.imm(imm));
endmodule