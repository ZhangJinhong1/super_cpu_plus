module Latch_A(
input               CLR,
input               clk,
input       [31:0]  RD,
input       [31:0]  PCPlus4F,
input               EN,
output  reg [31:0] InstrD=32'b11111100000000000000000000000000,
output  reg [31:0] PCPlus4D=0);

always @(posedge clk)
begin
if(EN === 1'b1)//使能位，0使能1失能
begin
   if(CLR)//清零位
	begin
   InstrD = 32'b11111100000000000000000000000000;
   PCPlus4D <= 0;
   end
end
else if(EN === 1'b0)
begin
   if(CLR)
	begin
   InstrD = 32'b11111100000000000000000000000000;
   PCPlus4D <= 0;
   end
   else begin
   InstrD <= RD;
   PCPlus4D <= PCPlus4F;
   end
end
end
endmodule


