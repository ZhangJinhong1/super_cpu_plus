module  Hazard(
input   [4:0]   RsE,
input   [4:0]   RtE,
input   [4:0]   RsD,
input   [4:0]   RtD,
input   [4:0]   WriteRegE,
input   [4:0]   WriteRegM,
input   [4:0]   WriteRegW,
input           RegWriteM,
input           RegWriteW,
input           MemtoRegE,
input           BranchD,
input           RegWriteE,
input           MemtoRegM,
input   [31:0]  WriteDataM,

output  reg [1:0]   ForwardAE,
output  reg [1:0]   ForwardBE,
output  reg         StallF,
output  reg         StallD,
output  reg         FlushE,

output              ForwardAD,
output              ForwardBD
);

wire    branchstall;
wire    lwstall;

initial
begin
   StallF = 0;
   StallD = 0;
end

always @(*)
begin//旁路技术
	if((RsE != 0)&&(RsE == WriteRegM)&&(RegWriteM))
	//对应A1通路
	//判断要从reg里面读数的地址等于M阶段要往reg写入的地址且M阶段的指令是个往reg写数据的指令
	ForwardAE <= 2'b10;//取alu结果
	else if((RsE != 0)&&(RsE == WriteRegW)&&(RegWriteW))
	//w阶段
	ForwardAE <= 2'b01;//取写回数据
	else
   ForwardAE <= 2'b00;//正常执行

   if((RtE != 0)&&(RtE == WriteRegM)&&(RegWriteM))
	//对应A2通路
   ForwardBE <= 2'b10;
   else if((RtE != 0)&&(RtE == WriteRegW)&&(RegWriteW))
   ForwardBE <= 2'b01;
   else
   ForwardBE <= 2'b00;

   StallF=lwstall | branchstall;
   StallD=lwstall | branchstall;
	FlushE=lwstall | branchstall;
end
assign lwstall=((RsD==RtE)|(RtD==RtE))&MemtoRegE;
       //E阶段的指令是个要从DM里面读数的指令，需要等一个周期等数取出来
assign branchstall=(BranchD & RegWriteE & (RsD == WriteRegE | RtD == WriteRegE))
       |(BranchD & MemtoRegM &(RsD == WriteRegM | RtD == WriteRegM));
       //出现跳转指令时，若用于比较的地址正好为前一条指令要写回a3的目标地址，需要停顿等待数据写回reg寄存器
assign ForwardAD = (RsD != 0) && (RsD == WriteRegM) && WriteRegM;
assign ForwardBD = (RtD != 0) && (RtD == WriteRegM) && WriteRegM;
       //D阶段的旁路技术
endmodule
		 
		 
