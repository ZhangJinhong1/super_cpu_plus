module Latch_E(
input           clk,
input           RegWriteE,
input           MemtoRegE,
input           MemWriteE,

input           ZeroE,
input   [31:0]  ALUOutE,

input   [31:0]  WriteDataE,
input   [4:0]   WriteRegE,

output  reg         RegWriteM,
output  reg         MemtoRegM,
output  reg         MemWriteM,
output  reg         ZeroM,
output  reg [31:0]  ALUOutM,
output  reg [31:0]  WriteDataM,
output  reg [4:0]   WriteRegM);

always @(posedge clk)begin
    RegWriteM <= RegWriteE;
    MemtoRegM <= MemtoRegE;
    MemWriteM <= MemWriteE;
    ZeroM <= ZeroE;
    ALUOutM <= ALUOutE;
    WriteDataM <= WriteDataE;
    WriteRegM <= WriteRegE;
end

endmodule
