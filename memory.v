module memory(clk,WE_Reg,WD_Reg,A1,A2,A3,RD1,RD2);
input clk;
input WE_Reg;
input  [31:0]WD_Reg;
input  [4:0]A1;
input  [4:0]A2;
input  [4:0]A3;
output [31:0]RD1;
output [31:0]RD2;
reg    [31:0]mem2[8:0];
initial
begin//寄存器赋初值
mem2[0]=32'b0;
mem2[1]=32'b0;
mem2[2]=32'b1;
mem2[3]=32'b0;
mem2[4]=32'b0;
mem2[5]=32'b1000;
mem2[6]=32'b0;
mem2[7]=32'b0;
mem2[8]=32'b0;
end
always@(posedge clk)
begin
  if (WE_Reg)
      mem2[A3] <= WD_Reg;//写入数据
end


assign RD1 = mem2[A1];
assign RD2 = mem2[A2];//读取数据
endmodule
