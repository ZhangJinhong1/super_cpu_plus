module immadder(A,B,Y);
input [31:0]A;
input [31:0]B;
output reg[31:0]Y=32'b0;
always@(*)
begin
Y=A+B;
end
endmodule 