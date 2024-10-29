module alu(A,B,Y,F,zero);
input [31:0]A;
input [31:0]B;
input [2:0]F;
output reg[31:0]Y=32'b0;
output reg zero=1'b0;
always@(*)
begin
 case(F)//选择运算类型
 3'b000:Y=A&B;
 3'b001:Y=A|B;
 3'b010:Y=A+B;
 3'b011:Y=A/B;
 3'b100:Y=A&(~B);
 3'b101:Y=A|(~B);
 3'b110:Y=A-B;
 3'b111:
 begin
 if(A<B)//输出zero
 Y=1;
 else
 Y=0;
 end
default:Y=32'bxxx;
endcase
end

always@(*)
begin
if((A-B)==0)
zero=0;
else
zero=1;
end

endmodule

