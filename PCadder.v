module PCadder(A,Y);
input [31:0]A;
output reg[31:0]Y=32'b0;
always@(*)
begin
Y=A+4;
end
endmodule 