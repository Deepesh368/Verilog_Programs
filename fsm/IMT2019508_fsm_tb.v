`timescale 1ns/1ps

module mealy(out,I,clk,rst);
    input I,clk,rst;
    output reg out;
    localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1:0] current_state;
    reg [1:0] next_state;

    initial begin
        current_state = S0;
        out = 0;
        next_state = S0;
    end

    always @(posedge clk) begin
        if(rst) current_state <= S0;
        else current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        case(current_state)
            S0: begin
                if(I==1) next_state = S2;
                else if(I==0) next_state = S1;
            end

            S1: begin
                if(I==1) next_state = S2;     
            end

            S2: begin
                if(I==0) next_state = S1; 
            end
        endcase        
    end

    always @(posedge clk) begin
        out = 1'b0;
        case(current_state)
            S1: begin 
                if(I==1) out = 1'b1;
            end

            S2: begin
                if(I==0) out = 1'b1;
            end 
        endcase       
    end
endmodule

module mealy_tb;
reg I;
reg clk;
reg rst;
wire out;

mealy fsm(out,I,clk,rst);

initial begin

$dumpfile ("fsm_out.vcd"); 
$dumpvars(0,mealy_tb);
clk = 0;
rst = 1;
I = 0;
#2 rst = 0;
#10 rst = 1;
#10 rst = 0;
end

always
#3 clk = ~clk;

always
#5 I=~I;

endmodule