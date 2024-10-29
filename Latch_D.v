module  Latch_D(RegWriteD,RegDstD,AluSrcD,MemWriteD,MemtoRegD,ALUControlD,
                RD1,RD2,RsD,RtD,RdD,SignimmD,CLR,clk,RegWriteE,RegDstE,AluSrcE,
					 MemWriteE,MemtoRegE,RD1E,RD2E,SignimmE,RtE,RdE,RsE,ALUControlE);
input         clk;
input         CLR;

input         RegWriteD;
input         RegDstD;
input         AluSrcD;
input         MemWriteD;
input         MemtoRegD;
input  [2:0]  ALUControlD;

input  [31:0] RD1;
input  [31:0] RD2;
input  [31:0] SignimmD;

input   [4:0] RtD;
input   [4:0] RdD;
input   [4:0] RsD;

output   reg   RegWriteE;
output   reg   RegDstE;
output   reg   AluSrcE;
output   reg   MemWriteE;
output   reg   MemtoRegE;
output   reg   [31:0] RD1E;
output   reg   [31:0] RD2E;
output   reg   [31:0] SignimmE;
output   reg   [4:0]RtE;
output   reg   [4:0]RdE;
output   reg   [4:0]RsE;
output   reg   [2:0]ALUControlE;

always@(posedge clk)
begin
if(CLR)
  begin
   RD1E <= 0;
   RD2E <= 0;
   SignimmE <= 0;
   RegWriteE <= 0;
   MemtoRegE <= 0;
   MemWriteE <= 0;
   ALUControlE <= 0;
   AluSrcE <= 0;
   RegDstE <= 0;
   RtE <= 0;
   RdE <= 0;
  end
  else begin
   RD1E <=RD1;
   RD2E <=RD2;
   SignimmE <=SignimmD;
   RegWriteE <=RegWriteD;
   MemtoRegE <=MemtoRegD;
   MemWriteE <=MemWriteD;
   ALUControlE <=ALUControlD;
   AluSrcE <=AluSrcD;
   RegDstE <=RegDstD;
   RtE <=RtD;
   RdE <=RdD;  
	RsE <=RsD;
  end
end
endmodule

