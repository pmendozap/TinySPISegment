`timescale 1ns / 1ps

module segment_disp(

	input [15:0] x,
    input clk,
    input rst,
    input we,
	input [4:0] divider,
    output reg [6:0] a_to_g, //to
    output reg [3:0] an	 );
	 
	 logic [31:0] x_r;
	 always @(posedge clk) begin
	   if(!rst) begin
	       x_r <= 0;
	   end else begin
	       if(we)
	           x_r <= x;
	   end
	 end
	 
	 
reg [2:0] s;	 
reg [3:0] digit;
wire [3:0] aen;
reg [31:0] clkdiv;

//assign s = clkdiv[19-3:17-3];
	 
always @(*) begin
	s = (clkdiv>>divider)&2'b11;
end

assign aen = 4'b1111; // all turned off initially

// quad 4to1 MUX.


always @(posedge clk)// or posedge clr)
	if(!rst) digit <= 0;
	else
	case(s)
	0:digit <= x_r[3:0] ; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
	1:digit <= x_r[7:4] ; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
	2:digit <= x_r[11:8] ; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
	3:digit <= x_r[15:12]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]
	default:digit <= x_r[3:0];
	
	endcase
	
	//decoder or truth-table for 7a_to_g display values
	always @(*)

case(digit)


//////////<---MSB-LSB<---
//////////////gfedcba////////////////////////////////////////////              a
0:a_to_g = 7'b1000000;////0000												   __					
1:a_to_g = 7'b1111001;////0001												f/	  /b
2:a_to_g = 7'b0100100;////0010												  g
//                                                                           __	
3:a_to_g = 7'b0110000;////0011										 	 e /   /c
4:a_to_g = 7'b0011001;////0100												 __
5:a_to_g = 7'b0010010;////0101                                               d  
6:a_to_g = 7'b0000010;////0110
7:a_to_g = 7'b1111000;////0111
8:a_to_g = 7'b0000000;////1000
9:a_to_g = 7'b0010000;////1001
10:a_to_g = 7'b0001000;////1001
11:a_to_g = 7'b0000011;////1001
12:a_to_g = 7'b1000110;////1001
13:a_to_g = 7'b0100001;////1001
14:a_to_g = 7'b0000110;////1001
15:a_to_g = 7'b0001110;////1001

default: a_to_g = 7'b0000000; // U

endcase

logic [3:0] an_p;

always @(*)begin
an_p=4'b1111;
if(aen[s] == 1)
an_p[s] = 0;
end

always @(posedge clk) begin
    if(!rst)
		an <= 4'hf;
	else
		an <= an_p;
	end





//clkdiv

always @(posedge clk) begin
    if(!rst) begin
        clkdiv <= 0;
    end else begin
        clkdiv <= clkdiv+1;
    end
end


endmodule
