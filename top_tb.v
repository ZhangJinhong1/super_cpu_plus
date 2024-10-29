`timescale 10ns/1ns
module top_tb;
reg clk=1'b0;
reg rst_n=1'b1;
top  top_inst(
     .clk(clk),
	  .rst_n(rst_n));

initial
begin
forever 
begin
#5 clk<=~clk;
end
end


initial
begin
#1000 $stop;
end
initial
begin
clk<=1'b0;
end
initial begin
    $dumpon;
    $dumpfile ("mydump.vcd");
    $dumpvars;//加入全部信号
    $dumpflush;
end
endmodule
