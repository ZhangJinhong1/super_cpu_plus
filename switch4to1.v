module  switch4to1(
input   [31:0]  in1,
input   [31:0]  in2,
input   [31:0]  in3,
input   [31:0]  in4,
input   [1:0]   sel,  
output  reg [31:0]    out
);

always @(*)
begin
    if(sel == 2'b00)
        out <=  in1;
    if(sel == 2'b01)
        out <=  in2;
    if(sel == 2'b10)
        out <=  in3;
    if(sel == 2'b11)
        out <=  in4;
end

endmodule
