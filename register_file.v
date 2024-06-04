module register_file(clk,rst,wr_en,wr_data,a1,a2,a3,rd_data1,rd_data2);
input clk,rst,wr_en;
input [4:0] a1,a2,a3;
input [31:0]wr_data;
output[31:0]rd_data1,rd_data2;

reg [31:0] register[31:0];

always@(posedge clk)
begin
    if(wr_en)
        register[a3]<=wr_data;
end
assign rd_data1 = (rst)? register[a1]:32'd0;
assign rd_data2 = (rst)? register[a2]:32'd0;


initial begin
    register[5]=32'h00000005;
    register[6]=32'h00000002;
end
endmodule
