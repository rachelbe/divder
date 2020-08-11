`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cmpen 331
// Engineer: Rachel Brooks
// Create Date: 06/09/2020 02:02:40 PM
// Module Name: testbench
// Project Name: divider
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////
module testbench();
    reg clrn; //clear negated
    reg start; // start of the division
    reg clk; //clock
    reg [31:0] a;//0 dividend
    reg [15:0] b; // divisor
    
    wire [31:0] q; //quotient
    wire [15:0] r; //remainder
    wire busy; //indicates divider is busy
    wire ready; //indicates that the quotient and remainder are available
    wire [4:0] count; //counter
    
    division div_tb(clrn,clk, b, a,start,q,r,ready,count,busy); //must match design source line

    initial begin //reg start pos
        clrn=0;
        start=0;
        clk=1;  //first 3
        
        a = 31'h4c7f228a;  //write a and b in hex from expected output (bits ', hex, number) 
        b = 15'h6a0e;
        
        //changes
        #5 clrn = 1; //changes at 5ns 
        #0 start = 1; // changes at 5ns already there
        #10 start = 0; // changes at 15 (10 later)     
    end
    //changes every 5ms
    always begin 
       #5 clk=~clk;
    end  
endmodule
