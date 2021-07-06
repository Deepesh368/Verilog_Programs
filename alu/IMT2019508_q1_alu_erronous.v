//if select line s=00101, out=a+b
//if s=00110, out= a-b;
//if s=01000, a*b
//01011 --> a/b


module alu (a,b,s,out);/*Put clk in the list*/
input [39:0]a,b;
input [4:0]s;
input clk;
reg [39:0]c,d;
output [39:0]out;/*out should be a reg*/

reg i;

always @ (posedge clk)
begin
if (s==5'b00101)
out = a+b;
else if (s==5'b1000)
begin/*We should remove begin here*/
out= a*b;
else if (s==5'b00110)
out = a-b;
else if (s==5'b01011)
out = a/b;
end
endmodule


`timescale 1ns/1ps
module alu_test;
reg [39:0]a,b;
reg clk;
reg [4:0]select;
wire out;      /*out should of size 40.*/
alu uut (a,b,out,select);/*Select ,clk,out should be placed in their proper places.*/
initial
begin
$dumpfile("alua.vcd");
$dumpvars(0, alu_test);
a= 40'h000000000b;
b= 40'h0000000003;
clk=0;
s= 5'b00101;
end

always
begin
#3 clk=~clk;
end

always
begin

s = 5'b00111;   /*Here also #10 should be placed.*/
#10 s = 5'b00110;
#10 s = 5'b01000;
#10 s = 5'b01011;

end

endmodule
