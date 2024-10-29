module DM(clk,WE_Data,WD_Data,A_Data,RD_Data);
input WE_Data;
input  [31:0]WD_Data;
input  [31:0]A_Data;
output [31:0]RD_Data;
reg    [31:0]mem[80:0];
input clk;
initial 
begin
$readmemb("D:/quartus/class5/dm.txt",mem); //写入初值
end

always@(posedge clk)
begin
  if (WE_Data)
      mem[A_Data] <= WD_Data;//写入数据
		
end

assign RD_Data = mem[A_Data];//读取数据
endmodule

