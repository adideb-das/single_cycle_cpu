module alu (a,b,alucontrol,overflow,carry,zero,negetive,result);

input [31:0] a,b;
input [2:0] alucontrol;
output carry, overflow, zero, negetive;
output [31:0] result;

wire cout;
wire [31:0]sum;
assign {cout,sum}=(alucontrol[0]==1'b0)? (a+b) : (a+((~b)+1));
assign result = (alucontrol==3'b000)?sum://add
                (alucontrol==3'b001)?sum://sub
                (alucontrol==3'b010)?a & b ://and
                (alucontrol==3'b011)?a | b://or
                (alucontrol==3'b101)?{{31{1'b0}},(sum[31])}:{32{1'b0}};
assign overflow= ((sum[31]^a[31] & (alucontrol[0] ^ b[31] ^ a[31])) &(~alucontrol[1]));
assign carry = ((~alucontrol[1])& cout)?1'b1:'dz;
assign zero = (result==32'b0)? 1'b1: 'dz;
assign negetive= (result[31]==1'b1)?1'b1:'dz;
endmodule