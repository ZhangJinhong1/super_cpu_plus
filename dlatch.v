module dlatch(clk,Dout,Din);
input clk;
input [31:0]Din;
output reg [31:0]Dout=32'b0;
always@(posedge clk)
begin
Dout<=Din;
end
endmodule
