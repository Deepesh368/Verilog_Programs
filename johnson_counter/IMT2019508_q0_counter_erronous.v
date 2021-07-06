//This is a Johnson counter
//0, 1, 3, 7, F, E, C, 8, 0, repeat

module dff(q,d,clk,reset);
output q;
input d,clk,reset;
reg q;

always@(posedge clk or reset)/*I have reset to posedge reset*/
begin
	if (reset==1) q=0;/*I have these these assignments to non_blocking assignments*/
	else q=d;
end
endmodule



module counter(q,reset,clk);
output [3:0]q;
input clk,reset;
reg w; /*'w' should be a wire*/

initial begin
not n1 (q[3],w); /*Here q[3] and w need to be interchanged*/
dff f1(q[0],w,reset,clk);
dff f2(q[1],q[0],reset,clk);/*Here clk and reset need to be interchanged.*/
dff f3(q[2],q[1],reset,clk);
dff f4(q[3],q[2],reset,clk);
end
endmodule

`timescale 10ns/1ps
module tb_johnson;
    // Inputs
    reg clock;
     reg r;
    // Outputs
    wire Count_out;/*Count_out needs to be of size '4'*/


//in this following notation you have to pass the signals in the same order
//as in the original module
counter uut (Count_out,clock,r); /*Here clock and r need to be interchanged*/


//alternately, the following notation means that clk in the module connects to clock in the testbench.
//reset connects to r, and q to Count_out.
//In this notation, you can pass signals in any order, as you are explicitly mentioning 
//the signal connections

//  counter uut ( .clk(clock),  .reset(r),.q(Count_out) );


initial begin


clk = 0;
r=1;
#50 r=0;  //reset=1 never shows up on the waveform -- why?
            /*reset = 1 never shows up on the waveform because reset = 0 has been assigned before a dump_file and hence in the waveform only reset = 0 will show.*/

$dumpfile ("counter.vcd"); 
$dumpvars(0,counter_test);

end

always 
#3 clk=~clk; /*It should be clock and not clka*/


//initial #300 $finish;

endmodule

