module data_memory(clk,rst,wr_en,wr_data,a,read_data);
input clk,rst,wr_en;
input [31:0] a,wr_data;
output [31:0] read_data;

reg [31:0] mem[0:1023]; // 32 bit memory with 1024 indexes

always@(posedge clk)
begin
if(wr_en)
    mem[a]<=wr_data;
end
assign read_data=(rst)? mem[a]: 32'd0;

initial begin
    mem[28]=32'h00000056;
end
endmodule