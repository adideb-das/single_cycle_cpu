module pc(clk,rst,pc,pc_next);
input clk,rst;
input [31:0]pc_next;
output reg[31:0]pc;

always@(posedge clk)
begin
if(rst)
    pc<=pc_next;
else 
    pc<=32'b0;
end
endmodule
