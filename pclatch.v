module pclatch(clk,din,dout,EN);
input clk;
input [31:0]din;
input EN;
output reg [31:0]dout=32'b0;
always@(posedge clk)
begin
if(EN==0)
dout<=din;
end
endmodule
