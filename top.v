module top(clk,rst_n);
input clk;
input rst_n;
wire  [31:0]Instr;
wire  [31:0]InstrD;
wire  [4:0]WriteRegW;
wire  [31:0]SignimmD;
wire  [2:0]ALUControlD;
wire  [2:0]ALUControlE;
wire  [31:0]pcb;
wire  [31:0]PCBranchD;
wire  [31:0]PC;
wire  [31:0]PC1;
wire  [31:0]PCPlus4F;
wire  [31:0]PCPlus4D;
wire  [31:0]SrcAE;
wire  [31:0]SrcBE;
wire  [31:0]ALUOutW;
wire  [31:0]ALUOutE;
wire  [31:0]ALUOutM;
wire  [31:0]RD1;
wire  [31:0]RD1E;
wire  [31:0]RD2;
wire  [31:0]RD2E;
wire  [31:0]ReadDataM;
wire  [31:0]ReadDataW;
wire  [31:0]ResultW;
wire  [4:0]RsE;
wire  [4:0]RdE;
wire  [4:0]RtE;
wire  [4:0]WriteRegE;
wire  [4:0]WriteRegM;
wire  [31:0]WriteDataE;
wire  [31:0]SignimmE; 
wire  [31:0]WriteDataM;
wire  [1:0]ForwardAE;
wire  [1:0]ForwardBE;
pclatch   pclatch_inst(
          .clk(clk),
			 .din(PC1),
			 .dout(PC),
			 .EN(StallF));
			 
PCadder   PCadder_inst(
          .A(PC),
			 .Y(PCPlus4F));
			 
IM        IM_inst(
          .pc(PC),
			 .clk(clk),
			 .RD_code(Instr));

encoder   encoder_inst(
          .op(InstrD[31:26]),
			 .funct(InstrD[5:0]),
          .RegWrite(RegWriteD),
			 .RegDst(RegDstD),
			 .AluSrc(AluSrcD),
			 .Branch(BranchD),
			 .MemWrite(MemWriteD),
			 .MemtoReg(MemtoRegD),
			 .ALUControl(ALUControlD));
			 
memory    memory_inst(
          .clk(clk),
			 .WE_Reg(RegWriteW),
			 .WD_Reg(ResultW),
			 .A1(InstrD[25:21]),
			 .A2(InstrD[20:16]),
			 .A3(WriteRegW),
			 .RD1(RD1),
			 .RD2(RD2));

Latch_A	 Latch_A_inst(
          .CLR(PCSrc),
          .clk(clk),
          .RD(Instr),
          .PCPlus4F(PCPlus4F),
          .EN(StallD),
          .InstrD(InstrD),
          .PCPlus4D(PCPlus4D));
			 
Latch_D   Latch_D_inst(
          .RegWriteD(RegWriteD),
			 .RegDstD(RegDstD),
			 .AluSrcD(AluSrcD),
			 .MemWriteD(MemWriteD),
			 .MemtoRegD(MemtoRegD),
			 .ALUControlD(ALUControlD),
			 .RD1(RD1),
			 .RD2(RD2),
			 .RsD(InstrD[25:21]),
			 .RtD(InstrD[20:16]),
			 .RdD(InstrD[15:11]),
			 .SignimmD(SignimmD),
			 .CLR(FlushE),
			 .clk(clk),
			 .RegWriteE(RegWriteE),
			 .RegDstE(RegDstE),
			 .AluSrcE(AluSrcE),
			 .MemWriteE(MemWriteE),
			 .MemtoRegE(MemtoRegE),
			 .RD1E(RD1E),
			 .RD2E(RD2E),
			 .SignimmE(SignimmE),
			 .RtE(RtE),
			 .RdE(RdE),
			 .RsE(RsE),
			 .ALUControlE(ALUControlE));
			 
Latch_E   Latch_E_inst(
          .clk(clk),
          .RegWriteE(RegWriteE),
          .MemtoRegE(MemtoRegE),
          .MemWriteE(MemWriteE),
          .ZeroE(ZeroE),
          .ALUOutE(ALUOutE),
          .WriteDataE(WriteDataE),
          .WriteRegE(WriteRegE),
          .RegWriteM(RegWriteM),
          .MemtoRegM(MemtoRegM),
          .MemWriteM(MemWriteM),
          .ZeroM(ZeroM),
			 .ALUOutM(ALUOutM),
			 .WriteDataM(WriteDataM),
			 .WriteRegM(WriteRegM));			 
			
Latch_M   Latch_M_inst(
          .clk(clk),
          .RegWriteM(RegWriteM),
          .MemtoRegM(MemtoRegM),
			 .WriteRegM(WriteRegM),
		    .ALUOutM(ALUOutM),
		    .RDM(ReadDataM),
          .RegWriteW(RegWriteW),
	   	 .MemtoRegW(MemtoRegW),
			 .WriteRegW(WriteRegW),
			 .ALUOutW(ALUOutW),
		    .ReadDataW(ReadDataW));		
 
immadder  immadder_inst(
          .A(pcb),
			 .B(PCPlus4D),
			 .Y(PCBranchD));
			 
alu       alu_inst(
          .A(SrcAE),
          .B(SrcBE),
			 .Y(ALUOutE),
			 .F(ALUControlE),
			 .zero(ZeroE));

DM        DM_inst(
          .clk(clk),
          .WE_Data(MemWriteM),
			 .WD_Data(RD2),
			 .A_Data(ALUOutM),
			 .RD_Data(ReadDataM));

Hazard    Hazard_inst(
          .RsE(RsE),
			 .RtE(RtE),
		    .RsD(InstrD[25:21]),
			 .RtD(InstrD[20:16]),
			 .WriteRegE(WriteRegE),
			 .WriteRegM(WriteRegM),
			 .WriteRegW(WriteRegW),
          .RegWriteM(RegWriteM),
          .RegWriteW(RegWriteW),
          .MemtoRegE(MemtoRegE),
          .BranchD(BranchD),
          .RegWriteE(RegWriteE),
          .MemtoRegM(MemtoRegM),
          .WriteDataM(WriteDataM),
			 .ForwardAE(ForwardAE),
			 .ForwardBE(ForwardBE),
          .StallF(StallF),
          .StallD(StallD),
          .FlushE(FlushE),
          .ForwardAD(ForwardAD),
          .ForwardBD(ForwardBD));
			 
switch4to1  switch4to1_A(
			 .in1(RD1E),
			 .in2(ResultW),
			 .in3(ALUOutM),
			 .in4(ReadDataM),
			 .sel(ForwardAE),  
			 .out(SrcAE));

switch4to1  switch4to1_B(
			 .in1(RD2E),
			 .in2(ResultW),
			 .in3(ALUOutM),
			 .in4(ReadDataM),
			 .sel(ForwardBE),  
			 .out(WriteDataE));			
			 
assign    WriteRegE=RegDstE?RdE:RtE;
assign    SignimmD={{16{InstrD[15]}},{InstrD[15:0]}};
assign    pcb=SignimmD<<2;
assign    SrcBE=AluSrcE?SignimmE:WriteDataE;  
assign    ResultW=MemtoRegW?ReadDataW:ALUOutW;
assign    PC1=PCSrc?PCBranchD:PCPlus4F;
assign    Equalin1=ForwardAD?ALUOutM:RD1;
assign    Equalin2=ForwardBD?ALUOutM:RD2;
assign    PCSrc=BranchD&(Equalin1!=Equalin2);
endmodule