module  Latch_M(
input           clk,
input           RegWriteM,
input           MemtoRegM,

input   [4:0]   WriteRegM,
input   [31:0]  ALUOutM,
input   [31:0]  RDM,


output  reg         RegWriteW,
output  reg         MemtoRegW,
output  reg [4:0]   WriteRegW,
output  reg [31:0]  ALUOutW,
output  reg [31:0]  ReadDataW);

always @(posedge clk)begin
    RegWriteW <= RegWriteM;
    MemtoRegW <= MemtoRegM;
    ALUOutW <= ALUOutM;
    ReadDataW <= RDM;
    WriteRegW <= WriteRegM;
end

endmodule
