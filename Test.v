`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/27 14:14:53
// Design Name: 
// Module Name: sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module test(

    );
    reg clk;

    wire clk1;
    wire [5:0] ram_addr;
    wire rst;
    wire frequency;
    wire [2:0] display;
    wire [7:0] SEG, AN;
// module data_route(PCenclr,clk1,ram_addr,frequency,rst,display,AN,SEG);
    data_route my_data_obj(0,clk1, ram_addr,  frequency, rst,display, AN, SEG);
    assign clk1 = clk;
    assign ram_addr = 0;
    assign rst = 0;
    assign frequency = 1; 
    assign display = 0;

    initial
    begin
        clk = 0;
        forever
        #5 clk = ~clk;
    end
endmodule