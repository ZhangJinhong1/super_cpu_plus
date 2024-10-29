module IM(pc,clk,RD_code);
input  clk;
input  [31:0] pc;
reg    [31:0]instruction_memory[31:0];
reg    [31:0]A_code=32'b0;
output reg[31:0]RD_code=32'b0;
initial 
begin
$readmemb("D:/quartus/class5/bin.txt",instruction_memory); //存储测试指令
end
always@(*)
begin
A_code=pc>>2;//字寻址字节寻址转换
RD_code=instruction_memory[A_code];//读取当前指令
end
endmodule
