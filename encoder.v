module encoder(op,funct,RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg,ALUControl);
input[5:0]op;
input[5:0]funct;
output reg RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg=1'b0;
output reg[2:0]ALUControl=000;
reg[1:0]ALUOp=2'b0;
always@(*)
begin
case(op)
6'b001000:{RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg,ALUOp}=8'b10100000;//addi
6'b100011:{RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg,ALUOp}=8'b10100100;//lw
6'b000000:{RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg,ALUOp}=8'b10000000;//add     
6'b000100:{RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg,ALUOp}=8'b00010001;//beq
6'b001001:{RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg,ALUOp}=8'b11000010;//div
6'b101011:{RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg,ALUOp}=8'b00101000;//sw
default:{RegWrite,RegDst,AluSrc,Branch,MemWrite,MemtoReg,ALUOp}=8'b00000000;
endcase
case(ALUOp)
2'b00:ALUControl=3'b010;
2'b01:ALUControl=3'b110;
2'b10:
begin
   case(funct)
   6'b100000:ALUControl=3'b010;
   6'b100010:ALUControl=3'b110;
   6'b100100:ALUControl=3'b000;
   6'b100101:ALUControl=3'b001;
   6'b101010:ALUControl=3'b111;
   6'b111111:ALUControl=3'b011;
	default:    ALUControl = 3'bxxx;
   endcase
end
endcase
end
endmodule

