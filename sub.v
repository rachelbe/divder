`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cmpen331
// Engineer: Rachel Brooks
// 
// Create Date: 06/09/2020 12:18:08 PM
// Module Name: sub
// Project Name: Divider
// Revision 0.01 - File Created
// Additional Comments: Design Code for restoring divisor
// 
//////////////////////////////////////////////////////////////////////////////////

module division(clrn,clk, b, a,start,q,r,ready,count,busy);
    //inputs
    input clrn;             //clear/reset
    input clk;              //clock
    input [15:0] b;         //divisor
    input [31:0] a;         //dividend
    input start;            //start
    //outputs
    output [31:0] q;        //quotient
    output [15:0] r;        //remainder
    output reg ready;       //indicates that the quotient and remainder are available
    output [4:0] count;     //keeps count
    output reg busy;        // if divider is busy 
//registers
    reg [15:0] reg_b;
    reg [15:0] reg_r;
    reg [31:0] reg_q;
    reg [4:0] count;
    
    assign q= reg_q;  //stores quotient
    assign r = reg_r;  //stores remainder
 //subtract b from partial remainder (sub result)
    wire [16:0] sub_res = {reg_r, reg_q[31]} - {1'b0,reg_b};    
 // implements restoring    
    wire [15:00] mux_res = sub_res[16]?
                            {reg_r[14:0],reg_q[31]}:sub_res[15:0];

    always @ (posedge clk)  //always start at pos edge of clock 
    begin
        if(clrn) //at 5ns starts 
        begin
            if (start) //5 ns - 15  //(start is start of division)
            begin
            //registers
                reg_b <= b;
                reg_r <= 0;  //remainer 0
                reg_q <= a; // "initially q stores a
            // busy, ready, count
                busy <= 1; //indicates busy cant start new division
                ready <= 0; // 0  (1 when expected out is ready)
                count <=0;     //0 (starts iterations)  
            end
            else if (busy)  //during division
            begin
                reg_r = mux_res;  
                reg_q = {reg_q[30:0],~sub_res[16]};
                
                //update count (5 bit , in binary , by 1)
                count <= count + 5'b1;
                
                //if count is full
                if (count == 5'h1f)
                begin
                    busy<= 0;
                    ready<= 1;
                end
            end
        end
        else   //0-5 ns when clrn is 0 
        begin 
            ready <=0;
            busy <=0;
        end  
    end
  //logic  
    //shift if 1
    //a=a-divisor
    //msb
    //if 0 q[0]=1
    //if 1 q[0]=0
    //n=n-1
    //if n=0 repeat 
    //else q = reg_q, r=reg_r

endmodule
